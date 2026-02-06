import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:realtime_item/core/utils/safe_async.dart';
import 'package:realtime_item/feature/alert/presentation/provider/alert_provider.dart';
import 'package:realtime_item/feature/favorite/domain/entity/favorite_item.dart';
import 'package:realtime_item/feature/favorite/domain/usecase/usecase.dart';
import 'package:realtime_item/feature/favorite/presentation/provider/favorite_state.dart';
import 'package:realtime_item/shared/domain/entity/price_update.dart';

/// 관심 종목 상태 관리 Provider
class FavoriteProvider extends ChangeNotifier {
  FavoriteProvider({
    required GetFavoriteListUseCase getFavoriteListUseCase,
    required AddFavoriteItemUseCase addFavoriteItemUseCase,
    required UpdateFavoriteItemUseCase updateFavoriteItemUseCase,
    required DeleteFavoriteItemUseCase deleteFavoriteItemUseCase,
    required SubscribePriceUpdatesUseCase subscribePriceUpdatesUseCase,
    required UnsubscribePriceUpdatesUseCase unsubscribePriceUpdatesUseCase,
  })  : _getFavoriteListUseCase = getFavoriteListUseCase,
        _addFavoriteItemUseCase = addFavoriteItemUseCase,
        _updateFavoriteItemUseCase = updateFavoriteItemUseCase,
        _deleteFavoriteItemUseCase = deleteFavoriteItemUseCase,
        _subscribePriceUpdatesUseCase = subscribePriceUpdatesUseCase,
        _unsubscribePriceUpdatesUseCase = unsubscribePriceUpdatesUseCase;

  // UseCases
  final GetFavoriteListUseCase _getFavoriteListUseCase;
  final AddFavoriteItemUseCase _addFavoriteItemUseCase;
  final UpdateFavoriteItemUseCase _updateFavoriteItemUseCase;
  final DeleteFavoriteItemUseCase _deleteFavoriteItemUseCase;
  final SubscribePriceUpdatesUseCase _subscribePriceUpdatesUseCase;
  final UnsubscribePriceUpdatesUseCase _unsubscribePriceUpdatesUseCase;

  // AlertProvider 참조 (목표가 알림용)
  AlertProvider? _alertProvider;

  // 상태 (Freezed Union Type)
  FavoriteState _state = const FavoriteState.initial();

  // 내부 상태 (실시간 구독 관리용)
  final Map<String, int> _previousPrices = {};
  final Map<String, StreamSubscription<PriceUpdate>> _subscriptions = {};

  // Getter
  FavoriteState get state => _state;

  // 편의 Getters
  List<FavoriteItem> get favoriteList => switch (_state) {
        FavoriteLoaded(favoriteList: final list) => list,
        FavoriteError(favoriteList: final list) => list ?? [],
        _ => [],
      };

  Map<String, PriceUpdate> get priceUpdates => switch (_state) {
        FavoriteLoaded(priceUpdates: final updates) => updates,
        FavoriteError(priceUpdates: final updates) => updates ?? {},
        _ => {},
      };

  bool get isLoading => _state is FavoriteLoading;

  String? get error => switch (_state) {
        FavoriteError(message: final message) => message,
        _ => null,
      };

  /// AlertProvider 연동 (목표가 알림용)
  AlertProvider? get alertProvider => _alertProvider;
  set alertProvider(AlertProvider alertProvider) => _alertProvider = alertProvider;

  /// 특정 종목의 현재 가격 조회
  PriceUpdate? getPriceUpdate(String stockCode) => priceUpdates[stockCode];

  /// 관심 종목 목록 로드
  Future<void> loadFavoriteList() async {
    _state = const FavoriteState.loading();
    notifyListeners();

    try {
      final favoriteList = await _getFavoriteListUseCase();

      _state = FavoriteState.loaded(
        favoriteList: favoriteList,
        priceUpdates: {},
      );
      notifyListeners();

      // 각 종목에 대해 가격 스트림 구독
      for (final item in favoriteList) {
        _subscribeToPriceUpdates(item.stockCode);
      }
    } on Exception catch (e) {
      _state = FavoriteState.error(message: e.toString());
      notifyListeners();
    }
  }

  /// 관심 종목 추가
  Future<void> addFavoriteItem(FavoriteItem item) async {
    try {
      await _addFavoriteItemUseCase(item);

      if (_state is FavoriteLoaded) {
        final currentState = _state as FavoriteLoaded;
        _state = currentState.copyWith(
          favoriteList: [...currentState.favoriteList, item],
        );
        _subscribeToPriceUpdates(item.stockCode);
        notifyListeners();
      }
    } on DuplicateFavoriteItemException {
      debugPrint('[FavoriteProvider] 중복 종목 추가 시도: ${item.stockCode}');
      _setError('이미 등록된 관심 종목입니다.');
      rethrow;
    } on Exception catch (e) {
      debugPrint('[FavoriteProvider] 종목 추가 실패: $e');
      _setError('관심 종목 추가에 실패했습니다. 다시 시도해주세요.');
      rethrow;
    }
  }

  /// 관심 종목 수정
  Future<void> updateFavoriteItem(FavoriteItem item) async {
    try {
      await _updateFavoriteItemUseCase(item);

      if (_state is FavoriteLoaded) {
        final currentState = _state as FavoriteLoaded;

        // map을 사용하여 효율적으로 리스트 업데이트 (불필요한 복사 방지)
        final newList = currentState.favoriteList
            .map((i) => i.stockCode == item.stockCode ? item : i)
            .toList();

        _state = currentState.copyWith(favoriteList: newList);

        // 목표가 수정 시 AlertProvider의 알림 상태 초기화
        safeFuture(
          _alertProvider?.resetAlertStatus(item.stockCode),
          context: 'FavoriteProvider.updateFavoriteItem.resetAlertStatus',
        );
        notifyListeners();
      }
    } on Exception catch (e) {
      debugPrint('[FavoriteProvider] 종목 수정 실패: $e');
      _setError('목표가 저장에 실패했습니다. 다시 시도해주세요.');
      rethrow;
    }
  }

  /// 관심 종목 삭제
  Future<void> deleteFavoriteItem(String stockCode) async {
    try {
      await _deleteFavoriteItemUseCase(stockCode);
      _unsubscribeFromPriceUpdates(stockCode);

      if (_state is FavoriteLoaded) {
        final currentState = _state as FavoriteLoaded;
        final newList = currentState.favoriteList
            .where((i) => i.stockCode != stockCode)
            .toList();
        final newPriceUpdates = Map<String, PriceUpdate>.from(
          currentState.priceUpdates,
        )..remove(stockCode);

        _state = currentState.copyWith(
          favoriteList: newList,
          priceUpdates: newPriceUpdates,
        );

        _previousPrices.remove(stockCode);
        safeFuture(
          _alertProvider?.resetAlertStatus(stockCode),
          context: 'FavoriteProvider.deleteFavoriteItem.resetAlertStatus',
        );
        notifyListeners();
      }
    } on Exception catch (e) {
      debugPrint('[FavoriteProvider] 종목 삭제 실패: $e');
      _setError('관심 종목 삭제에 실패했습니다. 다시 시도해주세요.');
      rethrow;
    }
  }

  /// 가격 스트림 구독 (단일 종목용 - 상세 페이지에서 사용)
  void subscribeToPriceUpdates(String stockCode) {
    _subscribeToPriceUpdates(stockCode);
  }

  // 재연결 시도 횟수 관리
  final Map<String, int> _retryCount = {};
  static const int _maxRetries = 3;

  /// 내부 가격 스트림 구독
  void _subscribeToPriceUpdates(String stockCode) {
    if (_subscriptions.containsKey(stockCode)) return;

    final stream = _subscribePriceUpdatesUseCase(stockCode);
    final subscription = stream.listen(
      (priceUpdate) {
        // 성공 시 재시도 횟수 초기화
        _retryCount.remove(stockCode);
        _handlePriceUpdate(stockCode, priceUpdate);
      },
      onError: (Object error) {
        debugPrint('[FavoriteProvider] 가격 스트림 에러 ($stockCode): $error');
        _handleStreamError(stockCode, error);
      },
    );

    _subscriptions[stockCode] = subscription;
  }

  /// 스트림 에러 처리 및 재연결
  void _handleStreamError(String stockCode, Object error) {
    final currentRetry = _retryCount[stockCode] ?? 0;

    if (currentRetry < _maxRetries) {
      _retryCount[stockCode] = currentRetry + 1;
      debugPrint('[FavoriteProvider] 스트림 재연결 시도 (${currentRetry + 1}/$_maxRetries): $stockCode');

      // 기존 구독 해제 후 재연결
      _subscriptions[stockCode]?.cancel();
      _subscriptions.remove(stockCode);

      // 지연 후 재연결
      Future.delayed(Duration(seconds: currentRetry + 1), () {
        if (!_subscriptions.containsKey(stockCode)) {
          _subscribeToPriceUpdates(stockCode);
        }
      });
    } else {
      debugPrint('[FavoriteProvider] 최대 재시도 횟수 초과: $stockCode');
      _setError('가격 정보를 가져오는 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
      _retryCount.remove(stockCode);
    }
  }

  /// 가격 업데이트 처리
  void _handlePriceUpdate(String stockCode, PriceUpdate priceUpdate) {
    final previousPrice = _previousPrices[stockCode];
    _previousPrices[stockCode] = priceUpdate.currentPrice;

    if (_state is FavoriteLoaded) {
      final currentState = _state as FavoriteLoaded;
      final newPriceUpdates = Map<String, PriceUpdate>.from(
        currentState.priceUpdates,
      )..[stockCode] = priceUpdate;

      _state = currentState.copyWith(priceUpdates: newPriceUpdates);

      // AlertProvider에 목표가 도달 체크 위임
      final item = currentState.favoriteList
          .where((i) => i.stockCode == stockCode)
          .firstOrNull;

      if (item != null && previousPrice != null && _alertProvider != null) {
        _alertProvider!.checkAndTriggerAlert(
          item: item,
          priceUpdate: priceUpdate,
          previousPrice: previousPrice,
        );
      }

      notifyListeners();
    }
  }

  /// 가격 스트림 구독 해제
  void _unsubscribeFromPriceUpdates(String stockCode) {
    _subscriptions[stockCode]?.cancel();
    _subscriptions.remove(stockCode);
    _unsubscribePriceUpdatesUseCase(stockCode);
  }

  /// 에러 설정 (기존 데이터 유지)
  void _setError(String message) {
    if (_state is FavoriteLoaded) {
      final currentState = _state as FavoriteLoaded;
      _state = FavoriteState.error(
        message: message,
        favoriteList: currentState.favoriteList,
        priceUpdates: currentState.priceUpdates,
      );
    } else {
      _state = FavoriteState.error(message: message);
    }
    notifyListeners();
  }

  /// 에러 초기화
  void clearError() {
    if (_state is FavoriteError) {
      final errorState = _state as FavoriteError;
      if (errorState.favoriteList != null) {
        _state = FavoriteState.loaded(
          favoriteList: errorState.favoriteList!,
          priceUpdates: errorState.priceUpdates ?? {},
        );
      } else {
        _state = const FavoriteState.initial();
      }
      notifyListeners();
    }
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions.values) {
      subscription.cancel();
    }
    _subscriptions.clear();
    _previousPrices.clear();
    _retryCount.clear();
    _unsubscribePriceUpdatesUseCase.disposeAll();
    super.dispose();
  }
}

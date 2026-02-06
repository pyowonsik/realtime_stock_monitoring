import 'package:flutter/foundation.dart';
import 'package:realtime_item/core/utils/safe_async.dart';
import 'package:realtime_item/feature/alert/domain/entity/alert_history_item.dart';
import 'package:realtime_item/feature/alert/domain/usecase/usecase.dart';
import 'package:realtime_item/feature/alert/presentation/provider/alert_state.dart';
import 'package:realtime_item/feature/favorite/domain/entity/favorite_item.dart';
import 'package:realtime_item/feature/favorite/domain/usecase/usecase.dart';
import 'package:realtime_item/shared/domain/entity/price_update.dart';

/// 알림 상태 관리 Provider
class AlertProvider extends ChangeNotifier {
  AlertProvider({
    required GetAlertHistoryUseCase getAlertHistoryUseCase,
    required AddAlertHistoryUseCase addAlertHistoryUseCase,
    required DeleteAlertHistoryUseCase deleteAlertHistoryUseCase,
    required ClearAlertHistoryUseCase clearAlertHistoryUseCase,
    required GetAlertedStocksUseCase getAlertedStocksUseCase,
    required AddAlertedStockUseCase addAlertedStockUseCase,
    required RemoveAlertedStockUseCase removeAlertedStockUseCase,
    required CheckTargetPriceUseCase checkTargetPriceUseCase,
  })  : _getAlertHistoryUseCase = getAlertHistoryUseCase,
        _addAlertHistoryUseCase = addAlertHistoryUseCase,
        _deleteAlertHistoryUseCase = deleteAlertHistoryUseCase,
        _clearAlertHistoryUseCase = clearAlertHistoryUseCase,
        _getAlertedStocksUseCase = getAlertedStocksUseCase,
        _addAlertedStockUseCase = addAlertedStockUseCase,
        _removeAlertedStockUseCase = removeAlertedStockUseCase,
        _checkTargetPriceUseCase = checkTargetPriceUseCase;

  // UseCases
  final GetAlertHistoryUseCase _getAlertHistoryUseCase;
  final AddAlertHistoryUseCase _addAlertHistoryUseCase;
  final DeleteAlertHistoryUseCase _deleteAlertHistoryUseCase;
  final ClearAlertHistoryUseCase _clearAlertHistoryUseCase;
  final GetAlertedStocksUseCase _getAlertedStocksUseCase;
  final AddAlertedStockUseCase _addAlertedStockUseCase;
  final RemoveAlertedStockUseCase _removeAlertedStockUseCase;
  final CheckTargetPriceUseCase _checkTargetPriceUseCase;

  // 상태 (Freezed Union Type)
  AlertState _state = const AlertState.initial();

  // 알림 콜백
  void Function(FavoriteItem item, PriceUpdate priceUpdate)? onTargetReached;

  // Getter
  AlertState get state => _state;

  // 편의 Getters
  List<AlertHistoryItem> get alertHistory => switch (_state) {
        AlertLoaded(alertHistory: final history) => history,
        AlertError(alertHistory: final history) => history ?? [],
        _ => [],
      };

  Set<String> get alertedStocks => switch (_state) {
        AlertLoaded(alertedStocks: final stocks) => stocks,
        AlertError(alertedStocks: final stocks) => stocks ?? {},
        _ => {},
      };

  bool get isLoading => _state is AlertLoading;

  String? get error => switch (_state) {
        AlertError(message: final message) => message,
        _ => null,
      };

  /// 알림 데이터 로드
  Future<void> loadAlertData() async {
    _state = const AlertState.loading();
    notifyListeners();

    try {
      final alertHistory = await _getAlertHistoryUseCase();
      final alertedStocks = await _getAlertedStocksUseCase();

      _state = AlertState.loaded(
        alertHistory: alertHistory,
        alertedStocks: alertedStocks,
      );
      notifyListeners();
    } on Exception catch (e) {
      _state = AlertState.error(message: e.toString());
      notifyListeners();
    }
  }

  /// 목표가 도달 여부 확인 및 알림 처리
  void checkAndTriggerAlert({
    required FavoriteItem item,
    required PriceUpdate priceUpdate,
    required int? previousPrice,
  }) {
    if (_state is! AlertLoaded) return;

    final currentState = _state as AlertLoaded;
    if (currentState.alertedStocks.contains(item.stockCode)) return;

    final reached = _checkTargetPriceUseCase(
      item: item,
      priceUpdate: priceUpdate,
      previousPrice: previousPrice,
    );

    if (reached && onTargetReached != null && item.targetPrice != null) {
      _addAlertedStock(item.stockCode);

      final alertItem = AlertHistoryItem(
        id: '${item.stockCode}_${DateTime.now().millisecondsSinceEpoch}',
        stockCode: item.stockCode,
        stockName: item.stockName,
        targetPrice: item.targetPrice!,
        triggeredPrice: priceUpdate.currentPrice,
        alertType: item.alertType,
        triggeredAt: DateTime.now(),
      );

      _addAlertHistory(alertItem);
      onTargetReached!(item, priceUpdate);
    }
  }

  /// 알림 히스토리 추가 (내부용)
  void _addAlertHistory(AlertHistoryItem alertItem) {
    if (_state is AlertLoaded) {
      final currentState = _state as AlertLoaded;
      final newAlertHistory = [alertItem, ...currentState.alertHistory];
      _state = currentState.copyWith(alertHistory: newAlertHistory);
      safeAsync(
        () => _addAlertHistoryUseCase(alertItem),
        context: 'AlertProvider._addAlertHistory',
      );
      notifyListeners();
    }
  }

  /// 알림 발송된 종목 추가 (내부용)
  void _addAlertedStock(String stockCode) {
    if (_state is AlertLoaded) {
      final currentState = _state as AlertLoaded;
      final newAlertedStocks = {...currentState.alertedStocks, stockCode};
      _state = currentState.copyWith(alertedStocks: newAlertedStocks);
      safeAsync(
        () => _addAlertedStockUseCase(stockCode),
        context: 'AlertProvider._addAlertedStock',
      );
    }
  }

  /// 특정 종목의 알림 상태 초기화 (목표가 수정 시 호출)
  Future<void> resetAlertStatus(String stockCode) async {
    if (_state is AlertLoaded) {
      final currentState = _state as AlertLoaded;
      final newAlertedStocks = {...currentState.alertedStocks}..remove(stockCode);
      _state = currentState.copyWith(alertedStocks: newAlertedStocks);
      await _removeAlertedStockUseCase(stockCode);
      notifyListeners();
    }
  }

  /// 특정 종목의 알림 히스토리 조회
  List<AlertHistoryItem> getAlertHistoryForStock(String stockCode) {
    return alertHistory.where((h) => h.stockCode == stockCode).toList();
  }

  /// 알림 히스토리 삭제
  Future<void> deleteAlertHistory(String alertId) async {
    if (_state is AlertLoaded) {
      final currentState = _state as AlertLoaded;
      final newAlertHistory =
          currentState.alertHistory.where((h) => h.id != alertId).toList();
      _state = currentState.copyWith(alertHistory: newAlertHistory);
      await _deleteAlertHistoryUseCase(alertId);
      notifyListeners();
    }
  }

  /// 알림 히스토리 전체 삭제
  Future<void> clearAlertHistory() async {
    if (_state is AlertLoaded) {
      final currentState = _state as AlertLoaded;
      _state = currentState.copyWith(alertHistory: []);
      await _clearAlertHistoryUseCase();
      notifyListeners();
    }
  }

  /// 에러 초기화
  void clearError() {
    if (_state is AlertError) {
      final errorState = _state as AlertError;
      if (errorState.alertHistory != null) {
        _state = AlertState.loaded(
          alertHistory: errorState.alertHistory!,
          alertedStocks: errorState.alertedStocks ?? {},
        );
      } else {
        _state = const AlertState.initial();
      }
      notifyListeners();
    }
  }
}

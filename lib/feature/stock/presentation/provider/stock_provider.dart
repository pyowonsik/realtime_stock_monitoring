import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:realtime_item/feature/stock/domain/entity/stock.dart';
import 'package:realtime_item/feature/stock/domain/usecase/get_stocks_usecase.dart';
import 'package:realtime_item/feature/stock/presentation/provider/stock_state.dart';

/// 종목 상태 관리 Provider
class StockProvider extends ChangeNotifier {
  StockProvider({
    required GetStocksUseCase getStocksUseCase,
  }) : _getStocksUseCase = getStocksUseCase;

  final GetStocksUseCase _getStocksUseCase;

  // 상태 (Sealed Class)
  StockState _state = const StockInitial();

  // Getter
  StockState get state => _state;

  // 편의 Getters (UI에서 쉽게 접근)
  List<Stock> get stocks => switch (_state) {
        StockLoaded(stocks: final stocks) => stocks,
        _ => [],
      };

  bool get isLoading => _state is StockLoading;

  String? get error => switch (_state) {
        StockError(message: final message) => message,
        _ => null,
      };

  /// 전체 종목 목록 로드
  Future<void> loadStocks() async {
    _state = const StockLoading();
    notifyListeners();

    try {
      final stocks = await _getStocksUseCase();
      _state = StockLoaded(stocks: stocks);
    } on SocketException catch (e) {
      debugPrint('[StockProvider] 네트워크 에러: $e');
      _state = const StockError(message: '네트워크 연결을 확인해주세요.');
    } on FormatException catch (e) {
      debugPrint('[StockProvider] 데이터 형식 에러: $e');
      _state = const StockError(message: '데이터를 불러오는 중 문제가 발생했습니다.');
    } on Exception catch (e) {
      debugPrint('[StockProvider] 종목 로드 실패: $e');
      _state = const StockError(message: '종목 목록을 불러올 수 없습니다. 잠시 후 다시 시도해주세요.');
    } finally {
      notifyListeners();
    }
  }

  /// 에러 초기화
  void clearError() {
    if (_state is StockError) {
      _state = const StockInitial();
      notifyListeners();
    }
  }
}

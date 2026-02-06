import 'package:realtime_stock_monitoring/feature/stock/domain/entity/stock.dart';

/// 종목 목록 상태 Sealed Class
sealed class StockState {
  const StockState();
}

/// 초기 상태
class StockInitial extends StockState {
  const StockInitial();
}

/// 로딩 상태
class StockLoading extends StockState {
  const StockLoading();
}

/// 로드 완료 상태
class StockLoaded extends StockState {
  const StockLoaded({required this.stocks});

  final List<Stock> stocks;
}

/// 에러 상태
class StockError extends StockState {
  const StockError({required this.message});

  final String message;
}

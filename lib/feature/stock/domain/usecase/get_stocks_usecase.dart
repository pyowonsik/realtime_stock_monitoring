import 'package:realtime_stock_monitoring/feature/stock/domain/entity/stock.dart';
import 'package:realtime_stock_monitoring/feature/stock/domain/repository/stock_repository.dart';

/// 전체 종목 목록 조회 유즈케이스
class GetStocksUseCase {
  GetStocksUseCase(this._repository);

  final StockRepository _repository;

  Future<List<Stock>> call() {
    return _repository.getStocks();
  }
}

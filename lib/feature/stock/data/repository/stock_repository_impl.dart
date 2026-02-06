import 'package:realtime_item/feature/stock/data/datasource/stock_mock_datasource.dart';
import 'package:realtime_item/feature/stock/domain/entity/stock.dart';
import 'package:realtime_item/feature/stock/domain/repository/stock_repository.dart';

/// 종목 레포지토리 구현체
class StockRepositoryImpl implements StockRepository {
  StockRepositoryImpl({required StockMockDataSource dataSource})
      : _dataSource = dataSource;

  final StockMockDataSource _dataSource;

  @override
  Future<List<Stock>> getStocks() {
    return _dataSource.getStocks();
  }

  @override
  Future<Stock?> getStockByCode(String stockCode) {
    return _dataSource.getStockByCode(stockCode);
  }
}

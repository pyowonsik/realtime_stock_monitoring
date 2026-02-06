import 'package:realtime_stock_monitoring/feature/stock/domain/entity/stock.dart';

/// 종목 레포지토리 인터페이스
abstract class StockRepository {
  /// 전체 종목 목록 조회
  Future<List<Stock>> getStocks();

  /// 종목 코드로 종목 조회
  Future<Stock?> getStockByCode(String stockCode);
}

import 'package:realtime_item/feature/stock/domain/entity/stock.dart';

/// Mock 종목 데이터소스 인터페이스
abstract class StockMockDataSource {
  Future<List<Stock>> getStocks();
  Future<Stock?> getStockByCode(String stockCode);
}

/// Mock 종목 데이터소스 구현체
class StockMockDataSourceImpl implements StockMockDataSource {
  // Mock 종목 데이터
  static const List<Map<String, dynamic>> _mockStocks = [
    {'stockCode': '005930', 'stockName': '삼성전자', 'logoUrl': null},
    {'stockCode': '000660', 'stockName': 'SK하이닉스', 'logoUrl': null},
    {'stockCode': '035420', 'stockName': 'NAVER', 'logoUrl': null},
    {'stockCode': '035720', 'stockName': '카카오', 'logoUrl': null},
    {'stockCode': '051910', 'stockName': 'LG화학', 'logoUrl': null},
    {'stockCode': '006400', 'stockName': '삼성SDI', 'logoUrl': null},
    {'stockCode': '005380', 'stockName': '현대차', 'logoUrl': null},
    {'stockCode': '000270', 'stockName': '기아', 'logoUrl': null},
    {'stockCode': '207940', 'stockName': '삼성바이오로직스', 'logoUrl': null},
    {'stockCode': '068270', 'stockName': '셀트리온', 'logoUrl': null},
  ];

  @override
  Future<List<Stock>> getStocks() async {
    // 실제 API 호출 시뮬레이션을 위한 딜레이
    await Future<void>.delayed(const Duration(milliseconds: 100));

    return _mockStocks
        .map((data) => Stock(
              stockCode: data['stockCode'] as String,
              stockName: data['stockName'] as String,
              logoUrl: data['logoUrl'] as String?,
            ))
        .toList();
  }

  @override
  Future<Stock?> getStockByCode(String stockCode) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));

    final data = _mockStocks.cast<Map<String, dynamic>?>().firstWhere(
          (stock) => stock?['stockCode'] == stockCode,
          orElse: () => null,
        );

    if (data == null) return null;

    return Stock(
      stockCode: data['stockCode'] as String,
      stockName: data['stockName'] as String,
      logoUrl: data['logoUrl'] as String?,
    );
  }
}

import 'package:hive/hive.dart';

/// 알림 발송된 종목 로컬 데이터소스 인터페이스
abstract class AlertedStocksLocalDataSource {
  Future<Set<String>> getAlertedStocks();
  Future<void> addAlertedStock(String stockCode);
  Future<void> removeAlertedStock(String stockCode);
  Future<void> clearAlertedStocks();
}

/// 알림 발송된 종목 로컬 데이터소스 구현체
class AlertedStocksLocalDataSourceImpl implements AlertedStocksLocalDataSource {
  static const String _boxName = 'alerted_stocks';

  Future<Box<bool>> _getBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return Hive.openBox<bool>(_boxName);
    }
    return Hive.box<bool>(_boxName);
  }

  @override
  Future<Set<String>> getAlertedStocks() async {
    final box = await _getBox();
    return box.keys.cast<String>().toSet();
  }

  @override
  Future<void> addAlertedStock(String stockCode) async {
    final box = await _getBox();
    await box.put(stockCode, true);
  }

  @override
  Future<void> removeAlertedStock(String stockCode) async {
    final box = await _getBox();
    await box.delete(stockCode);
  }

  @override
  Future<void> clearAlertedStocks() async {
    final box = await _getBox();
    await box.clear();
  }
}

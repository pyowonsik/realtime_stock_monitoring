import 'package:realtime_item/feature/alert/domain/entity/alert_history_item.dart';

/// 알림 히스토리 레포지토리 인터페이스
abstract class AlertHistoryRepository {
  Future<List<AlertHistoryItem>> getAlertHistory();
  Future<void> addAlertHistory(AlertHistoryItem item);
  Future<void> deleteAlertHistory(String id);
  Future<void> clearAlertHistory();
}

/// 알림 발송 상태 레포지토리 인터페이스
abstract class AlertedStocksRepository {
  Future<Set<String>> getAlertedStocks();
  Future<void> addAlertedStock(String stockCode);
  Future<void> removeAlertedStock(String stockCode);
}

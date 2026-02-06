import 'package:hive/hive.dart';
import 'package:realtime_item/feature/alert/data/model/alert_history_model.dart';
import 'package:realtime_item/feature/alert/domain/entity/alert_history_item.dart';

/// 알림 히스토리 로컬 데이터소스 인터페이스
abstract class AlertHistoryLocalDataSource {
  Future<List<AlertHistoryItem>> getAlertHistory();
  Future<List<AlertHistoryItem>> getAlertHistoryByStockCode(String stockCode);
  Future<void> addAlertHistory(AlertHistoryItem item);
  Future<void> deleteAlertHistory(String id);
  Future<void> clearAlertHistory();
}

/// 알림 히스토리 로컬 데이터소스 구현체
class AlertHistoryLocalDataSourceImpl implements AlertHistoryLocalDataSource {
  static const String _boxName = 'alert_history';

  Future<Box<AlertHistoryModel>> _getBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return Hive.openBox<AlertHistoryModel>(_boxName);
    }
    return Hive.box<AlertHistoryModel>(_boxName);
  }

  @override
  Future<List<AlertHistoryItem>> getAlertHistory() async {
    final box = await _getBox();
    final models = box.values.toList()
      ..sort((a, b) => b.triggeredAt.compareTo(a.triggeredAt));
    return models.map((m) => m.toItem()).toList();
  }

  @override
  Future<List<AlertHistoryItem>> getAlertHistoryByStockCode(
    String stockCode,
  ) async {
    final box = await _getBox();
    final models = box.values.where((m) => m.stockCode == stockCode).toList()
      ..sort((a, b) => b.triggeredAt.compareTo(a.triggeredAt));
    return models.map((m) => m.toItem()).toList();
  }

  @override
  Future<void> addAlertHistory(AlertHistoryItem item) async {
    final box = await _getBox();
    final model = AlertHistoryModel.fromItem(item);
    await box.put(item.id, model);
  }

  @override
  Future<void> deleteAlertHistory(String id) async {
    final box = await _getBox();
    await box.delete(id);
  }

  @override
  Future<void> clearAlertHistory() async {
    final box = await _getBox();
    await box.clear();
  }
}

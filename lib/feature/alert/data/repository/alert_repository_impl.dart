import 'package:realtime_item/feature/alert/data/datasource/alert_history_local_datasource.dart';
import 'package:realtime_item/feature/alert/data/datasource/alerted_stocks_local_datasource.dart';
import 'package:realtime_item/feature/alert/domain/entity/alert_history_item.dart';
import 'package:realtime_item/feature/alert/domain/repository/alert_repository.dart';

/// 알림 히스토리 레포지토리 구현체
class AlertHistoryRepositoryImpl implements AlertHistoryRepository {
  AlertHistoryRepositoryImpl({
    required AlertHistoryLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  final AlertHistoryLocalDataSource _localDataSource;

  @override
  Future<List<AlertHistoryItem>> getAlertHistory() {
    return _localDataSource.getAlertHistory();
  }

  @override
  Future<void> addAlertHistory(AlertHistoryItem item) {
    return _localDataSource.addAlertHistory(item);
  }

  @override
  Future<void> deleteAlertHistory(String id) {
    return _localDataSource.deleteAlertHistory(id);
  }

  @override
  Future<void> clearAlertHistory() {
    return _localDataSource.clearAlertHistory();
  }
}

/// 알림 발송 상태 레포지토리 구현체
class AlertedStocksRepositoryImpl implements AlertedStocksRepository {
  AlertedStocksRepositoryImpl({
    required AlertedStocksLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  final AlertedStocksLocalDataSource _localDataSource;

  @override
  Future<Set<String>> getAlertedStocks() {
    return _localDataSource.getAlertedStocks();
  }

  @override
  Future<void> addAlertedStock(String stockCode) {
    return _localDataSource.addAlertedStock(stockCode);
  }

  @override
  Future<void> removeAlertedStock(String stockCode) {
    return _localDataSource.removeAlertedStock(stockCode);
  }
}

import 'package:realtime_stock_monitoring/feature/alert/domain/repository/alert_repository.dart';

/// 알림 발송된 종목 제거 UseCase
class RemoveAlertedStockUseCase {
  RemoveAlertedStockUseCase({required AlertedStocksRepository repository})
      : _repository = repository;

  final AlertedStocksRepository _repository;

  Future<void> call(String stockCode) {
    return _repository.removeAlertedStock(stockCode);
  }
}

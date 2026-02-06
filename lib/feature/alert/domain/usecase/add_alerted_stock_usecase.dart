import 'package:realtime_stock_monitoring/feature/alert/domain/repository/alert_repository.dart';

/// 알림 발송된 종목 추가 UseCase
class AddAlertedStockUseCase {
  AddAlertedStockUseCase({required AlertedStocksRepository repository})
      : _repository = repository;

  final AlertedStocksRepository _repository;

  Future<void> call(String stockCode) {
    return _repository.addAlertedStock(stockCode);
  }
}

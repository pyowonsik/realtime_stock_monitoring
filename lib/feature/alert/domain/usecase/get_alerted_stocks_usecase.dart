import 'package:realtime_item/feature/alert/domain/repository/alert_repository.dart';

/// 알림 발송된 종목 조회 UseCase
class GetAlertedStocksUseCase {
  GetAlertedStocksUseCase({required AlertedStocksRepository repository})
      : _repository = repository;

  final AlertedStocksRepository _repository;

  Future<Set<String>> call() {
    return _repository.getAlertedStocks();
  }
}

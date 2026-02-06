import 'package:realtime_item/feature/alert/domain/entity/alert_history_item.dart';
import 'package:realtime_item/feature/alert/domain/repository/alert_repository.dart';

/// 알림 히스토리 조회 UseCase
class GetAlertHistoryUseCase {
  GetAlertHistoryUseCase({required AlertHistoryRepository repository})
      : _repository = repository;

  final AlertHistoryRepository _repository;

  Future<List<AlertHistoryItem>> call() {
    return _repository.getAlertHistory();
  }
}

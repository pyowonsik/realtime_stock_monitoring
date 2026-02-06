import 'package:realtime_item/feature/alert/domain/repository/alert_repository.dart';

/// 알림 히스토리 삭제 UseCase
class DeleteAlertHistoryUseCase {
  DeleteAlertHistoryUseCase({required AlertHistoryRepository repository})
      : _repository = repository;

  final AlertHistoryRepository _repository;

  Future<void> call(String id) {
    return _repository.deleteAlertHistory(id);
  }
}

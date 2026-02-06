import 'package:realtime_item/feature/alert/domain/repository/alert_repository.dart';

/// 알림 히스토리 전체 삭제 UseCase
class ClearAlertHistoryUseCase {
  ClearAlertHistoryUseCase({required AlertHistoryRepository repository})
      : _repository = repository;

  final AlertHistoryRepository _repository;

  Future<void> call() {
    return _repository.clearAlertHistory();
  }
}

import 'package:realtime_item/feature/alert/domain/entity/alert_history_item.dart';
import 'package:realtime_item/feature/alert/domain/repository/alert_repository.dart';

/// 알림 히스토리 추가 UseCase
class AddAlertHistoryUseCase {
  AddAlertHistoryUseCase({required AlertHistoryRepository repository})
      : _repository = repository;

  final AlertHistoryRepository _repository;

  Future<void> call(AlertHistoryItem item) {
    return _repository.addAlertHistory(item);
  }
}

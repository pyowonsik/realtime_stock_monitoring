import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:realtime_item/feature/alert/domain/entity/alert_history_item.dart';

part 'alert_state.freezed.dart';

/// 알림 상태 (Freezed Union Type)
@freezed
sealed class AlertState with _$AlertState {
  /// 초기 상태
  const factory AlertState.initial() = AlertInitial;

  /// 로딩 상태
  const factory AlertState.loading() = AlertLoading;

  /// 로드 완료 상태
  const factory AlertState.loaded({
    required List<AlertHistoryItem> alertHistory,
    required Set<String> alertedStocks,
  }) = AlertLoaded;

  /// 에러 상태
  const factory AlertState.error({
    required String message,
    List<AlertHistoryItem>? alertHistory,
    Set<String>? alertedStocks,
  }) = AlertError;
}

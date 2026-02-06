import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:realtime_stock_monitoring/feature/favorite/domain/entity/favorite_item.dart';

part 'alert_history_item.freezed.dart';
part 'alert_history_item.g.dart';

/// 알림 히스토리 항목
@freezed
class AlertHistoryItem with _$AlertHistoryItem {
  const factory AlertHistoryItem({
    required String id,
    required String stockCode,
    required String stockName,
    required int targetPrice,
    required int triggeredPrice,
    required AlertType alertType,
    required DateTime triggeredAt,
  }) = _AlertHistoryItem;

  factory AlertHistoryItem.fromJson(Map<String, dynamic> json) =>
      _$AlertHistoryItemFromJson(json);
}

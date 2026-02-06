import 'package:hive/hive.dart';
import 'package:realtime_item/core/constants/hive_type_ids.dart';
import 'package:realtime_item/feature/alert/domain/entity/alert_history_item.dart';
import 'package:realtime_item/feature/favorite/domain/entity/favorite_item.dart';

part 'alert_history_model.g.dart';

@HiveType(typeId: HiveTypeIds.alertHistoryModel)
class AlertHistoryModel extends HiveObject {
  AlertHistoryModel({
    required this.id,
    required this.stockCode,
    required this.stockName,
    required this.targetPrice,
    required this.triggeredPrice,
    required this.alertTypeIndex,
    required this.triggeredAt,
  });

  /// AlertHistoryItem으로부터 모델 생성
  factory AlertHistoryModel.fromItem(AlertHistoryItem item) {
    return AlertHistoryModel(
      id: item.id,
      stockCode: item.stockCode,
      stockName: item.stockName,
      targetPrice: item.targetPrice,
      triggeredPrice: item.triggeredPrice,
      alertTypeIndex: item.alertType.index,
      triggeredAt: item.triggeredAt,
    );
  }

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String stockCode;

  @HiveField(2)
  final String stockName;

  @HiveField(3)
  final int targetPrice;

  @HiveField(4)
  final int triggeredPrice;

  @HiveField(5)
  final int alertTypeIndex;

  @HiveField(6)
  final DateTime triggeredAt;

  /// 모델을 AlertHistoryItem으로 변환
  AlertHistoryItem toItem() {
    return AlertHistoryItem(
      id: id,
      stockCode: stockCode,
      stockName: stockName,
      targetPrice: targetPrice,
      triggeredPrice: triggeredPrice,
      alertType: AlertType.values[alertTypeIndex],
      triggeredAt: triggeredAt,
    );
  }
}

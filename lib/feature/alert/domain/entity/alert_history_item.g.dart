// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_history_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlertHistoryItemImpl _$$AlertHistoryItemImplFromJson(
        Map<String, dynamic> json) =>
    _$AlertHistoryItemImpl(
      id: json['id'] as String,
      stockCode: json['stockCode'] as String,
      stockName: json['stockName'] as String,
      targetPrice: (json['targetPrice'] as num).toInt(),
      triggeredPrice: (json['triggeredPrice'] as num).toInt(),
      alertType: $enumDecode(_$AlertTypeEnumMap, json['alertType']),
      triggeredAt: DateTime.parse(json['triggeredAt'] as String),
    );

Map<String, dynamic> _$$AlertHistoryItemImplToJson(
        _$AlertHistoryItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stockCode': instance.stockCode,
      'stockName': instance.stockName,
      'targetPrice': instance.targetPrice,
      'triggeredPrice': instance.triggeredPrice,
      'alertType': _$AlertTypeEnumMap[instance.alertType]!,
      'triggeredAt': instance.triggeredAt.toIso8601String(),
    };

const _$AlertTypeEnumMap = {
  AlertType.upper: 'upper',
  AlertType.lower: 'lower',
  AlertType.both: 'both',
};

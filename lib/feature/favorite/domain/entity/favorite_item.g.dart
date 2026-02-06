// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FavoriteItemImpl _$$FavoriteItemImplFromJson(Map<String, dynamic> json) =>
    _$FavoriteItemImpl(
      stockCode: json['stockCode'] as String,
      stockName: json['stockName'] as String,
      alertType: $enumDecode(_$AlertTypeEnumMap, json['alertType']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      logoUrl: json['logoUrl'] as String?,
      targetPrice: (json['targetPrice'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$FavoriteItemImplToJson(_$FavoriteItemImpl instance) =>
    <String, dynamic>{
      'stockCode': instance.stockCode,
      'stockName': instance.stockName,
      'alertType': _$AlertTypeEnumMap[instance.alertType]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'logoUrl': instance.logoUrl,
      'targetPrice': instance.targetPrice,
    };

const _$AlertTypeEnumMap = {
  AlertType.upper: 'upper',
  AlertType.lower: 'lower',
  AlertType.both: 'both',
};

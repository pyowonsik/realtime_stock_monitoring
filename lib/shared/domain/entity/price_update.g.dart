// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PriceUpdateImpl _$$PriceUpdateImplFromJson(Map<String, dynamic> json) =>
    _$PriceUpdateImpl(
      stockCode: json['stockCode'] as String,
      currentPrice: (json['currentPrice'] as num).toInt(),
      changeRate: (json['changeRate'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$PriceUpdateImplToJson(_$PriceUpdateImpl instance) =>
    <String, dynamic>{
      'stockCode': instance.stockCode,
      'currentPrice': instance.currentPrice,
      'changeRate': instance.changeRate,
      'timestamp': instance.timestamp.toIso8601String(),
    };

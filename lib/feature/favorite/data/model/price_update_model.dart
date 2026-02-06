import 'package:realtime_stock_monitoring/shared/domain/entity/price_update.dart';

/// 가격 업데이트 모델 (Mock WebSocket 데이터용)
class PriceUpdateModel {
  const PriceUpdateModel({
    required this.type,
    required this.stockCode,
    required this.currentPrice,
    required this.changeRate,
    required this.timestamp,
  });

  /// JSON으로부터 모델 생성
  factory PriceUpdateModel.fromJson(Map<String, dynamic> json) {
    return PriceUpdateModel(
      type: json['type'] as String,
      stockCode: json['stockCode'] as String,
      currentPrice: json['currentPrice'] as int,
      changeRate: (json['changeRate'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  final String type;
  final String stockCode;
  final int currentPrice;
  final double changeRate;
  final DateTime timestamp;

  /// 모델을 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'stockCode': stockCode,
      'currentPrice': currentPrice,
      'changeRate': changeRate,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  /// 모델을 엔티티로 변환
  PriceUpdate toEntity() {
    return PriceUpdate(
      stockCode: stockCode,
      currentPrice: currentPrice,
      changeRate: changeRate,
      timestamp: timestamp,
    );
  }
}

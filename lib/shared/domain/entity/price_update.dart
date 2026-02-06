import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_update.freezed.dart';
part 'price_update.g.dart';

/// 실시간 가격 업데이트 엔티티
/// stock과 favorite 모듈에서 공통으로 사용
@freezed
class PriceUpdate with _$PriceUpdate {
  const factory PriceUpdate({
    required String stockCode,
    required int currentPrice,
    required double changeRate,
    required DateTime timestamp,
  }) = _PriceUpdate;

  factory PriceUpdate.fromJson(Map<String, dynamic> json) =>
      _$PriceUpdateFromJson(json);
}

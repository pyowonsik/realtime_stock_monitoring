import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_item.freezed.dart';
part 'favorite_item.g.dart';

/// 알림 조건 타입
enum AlertType {
  /// 상한가 도달 시 알림
  upper,

  /// 하한가 도달 시 알림
  lower,

  /// 양방향 (상한가 또는 하한가) 도달 시 알림
  both,
}

/// 관심 종목 엔티티
@freezed
class FavoriteItem with _$FavoriteItem {
  const factory FavoriteItem({
    required String stockCode,
    required String stockName,
    required AlertType alertType,
    required DateTime createdAt,
    String? logoUrl,
    int? targetPrice,
  }) = _FavoriteItem;

  factory FavoriteItem.fromJson(Map<String, dynamic> json) =>
      _$FavoriteItemFromJson(json);
}

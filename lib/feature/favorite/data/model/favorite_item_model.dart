import 'package:hive/hive.dart';
import 'package:realtime_item/core/constants/hive_type_ids.dart';
import 'package:realtime_item/feature/favorite/domain/entity/favorite_item.dart';

part 'favorite_item_model.g.dart';

@HiveType(typeId: HiveTypeIds.favoriteItemModel)
class FavoriteItemModel extends HiveObject {
  FavoriteItemModel({
    required this.stockCode,
    required this.stockName,
    required this.alertTypeIndex,
    required this.createdAt,
    this.logoUrl,
    this.targetPrice,
  });

  /// 엔티티로부터 모델 생성
  factory FavoriteItemModel.fromEntity(FavoriteItem entity) {
    return FavoriteItemModel(
      stockCode: entity.stockCode,
      stockName: entity.stockName,
      logoUrl: entity.logoUrl,
      targetPrice: entity.targetPrice,
      alertTypeIndex: entity.alertType.index,
      createdAt: entity.createdAt,
    );
  }

  @HiveField(0)
  final String stockCode;

  @HiveField(1)
  final String stockName;

  @HiveField(2)
  final String? logoUrl;

  @HiveField(3)
  final int? targetPrice;

  @HiveField(4)
  final int alertTypeIndex;

  @HiveField(5)
  final DateTime createdAt;

  /// 모델을 엔티티로 변환
  FavoriteItem toEntity() {
    return FavoriteItem(
      stockCode: stockCode,
      stockName: stockName,
      logoUrl: logoUrl,
      targetPrice: targetPrice,
      alertType: AlertType.values[alertTypeIndex],
      createdAt: createdAt,
    );
  }
}

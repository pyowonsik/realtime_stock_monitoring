import 'package:realtime_item/feature/favorite/domain/entity/favorite_item.dart';
import 'package:realtime_item/shared/domain/entity/price_update.dart';

/// 목표가 도달 여부 확인 유즈케이스
class CheckTargetPriceUseCase {
  CheckTargetPriceUseCase();

  /// 목표가 도달 여부 확인
  /// [item] 관심 종목
  /// [priceUpdate] 현재 가격 정보
  /// [previousPrice] 이전 가격 (비교용)
  bool call({
    required FavoriteItem item,
    required PriceUpdate priceUpdate,
    required int? previousPrice,
  }) {
    if (item.targetPrice == null) return false;
    if (previousPrice == null) return false;

    final targetPrice = item.targetPrice!;
    final currentPrice = priceUpdate.currentPrice;

    switch (item.alertType) {
      case AlertType.upper:
        // 이전에는 목표가 미만이었고, 현재는 목표가 이상인 경우
        return previousPrice < targetPrice && currentPrice >= targetPrice;
      case AlertType.lower:
        // 이전에는 목표가 초과였고, 현재는 목표가 이하인 경우
        return previousPrice > targetPrice && currentPrice <= targetPrice;
      case AlertType.both:
        // 상한 또는 하한 조건 충족
        final upperReached =
            previousPrice < targetPrice && currentPrice >= targetPrice;
        final lowerReached =
            previousPrice > targetPrice && currentPrice <= targetPrice;
        return upperReached || lowerReached;
    }
  }
}

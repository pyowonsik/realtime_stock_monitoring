import 'package:realtime_item/feature/favorite/domain/repository/favorite_repository.dart';
import 'package:realtime_item/shared/domain/entity/price_update.dart';

/// 실시간 가격 업데이트 구독 유즈케이스
class SubscribePriceUpdatesUseCase {
  SubscribePriceUpdatesUseCase(this._repository);

  final FavoriteRepository _repository;

  Stream<PriceUpdate> call(String stockCode) {
    return _repository.getPriceStream(stockCode);
  }
}

import 'package:realtime_item/feature/favorite/domain/entity/favorite_item.dart';
import 'package:realtime_item/feature/favorite/domain/repository/favorite_repository.dart';

/// 관심 종목 단건 조회 유즈케이스
class GetFavoriteItemUseCase {
  GetFavoriteItemUseCase(this._repository);

  final FavoriteRepository _repository;

  Future<FavoriteItem?> call(String stockCode) {
    return _repository.getFavoriteItem(stockCode);
  }
}

import 'package:realtime_item/feature/favorite/domain/entity/favorite_item.dart';
import 'package:realtime_item/feature/favorite/domain/repository/favorite_repository.dart';

/// 관심 종목 수정 유즈케이스
class UpdateFavoriteItemUseCase {
  UpdateFavoriteItemUseCase(this._repository);

  final FavoriteRepository _repository;

  Future<void> call(FavoriteItem item) {
    return _repository.updateFavoriteItem(item);
  }
}

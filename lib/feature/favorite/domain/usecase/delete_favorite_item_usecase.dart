import 'package:realtime_item/feature/favorite/domain/repository/favorite_repository.dart';

/// 관심 종목 삭제 유즈케이스
class DeleteFavoriteItemUseCase {
  DeleteFavoriteItemUseCase(this._repository);

  final FavoriteRepository _repository;

  Future<void> call(String stockCode) {
    return _repository.deleteFavoriteItem(stockCode);
  }
}

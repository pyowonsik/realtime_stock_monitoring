import 'package:realtime_stock_monitoring/feature/favorite/domain/entity/favorite_item.dart';
import 'package:realtime_stock_monitoring/feature/favorite/domain/repository/favorite_repository.dart';

/// 관심 종목 목록 조회 유즈케이스
class GetFavoriteListUseCase {
  GetFavoriteListUseCase(this._repository);

  final FavoriteRepository _repository;

  Future<List<FavoriteItem>> call() {
    return _repository.getFavoriteList();
  }
}

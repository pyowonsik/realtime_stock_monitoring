import 'package:realtime_stock_monitoring/feature/favorite/domain/entity/favorite_item.dart';
import 'package:realtime_stock_monitoring/feature/favorite/domain/repository/favorite_repository.dart';

/// 중복 관심 종목 예외
class DuplicateFavoriteItemException implements Exception {
  DuplicateFavoriteItemException(this.stockCode);

  final String stockCode;

  @override
  String toString() => '이미 관심 종목에 등록된 종목입니다: $stockCode';
}

/// 관심 종목 추가 유즈케이스
class AddFavoriteItemUseCase {
  AddFavoriteItemUseCase(this._repository);

  final FavoriteRepository _repository;

  Future<void> call(FavoriteItem item) async {
    // 중복 체크
    final existing = await _repository.getFavoriteItem(item.stockCode);
    if (existing != null) {
      throw DuplicateFavoriteItemException(item.stockCode);
    }

    return _repository.addFavoriteItem(item);
  }
}

import 'package:realtime_item/feature/favorite/data/datasource/favorite_local_datasource.dart';
import 'package:realtime_item/feature/favorite/data/datasource/favorite_remote_datasource.dart';
import 'package:realtime_item/feature/favorite/data/model/favorite_item_model.dart';
import 'package:realtime_item/feature/favorite/domain/entity/favorite_item.dart';
import 'package:realtime_item/feature/favorite/domain/repository/favorite_repository.dart';
import 'package:realtime_item/shared/domain/entity/price_update.dart';

/// 관심 종목 레포지토리 구현체
class FavoriteRepositoryImpl implements FavoriteRepository {
  FavoriteRepositoryImpl({
    required FavoriteLocalDataSource localDataSource,
    required FavoriteRemoteDataSource remoteDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  final FavoriteLocalDataSource _localDataSource;
  final FavoriteRemoteDataSource _remoteDataSource;

  @override
  Future<List<FavoriteItem>> getFavoriteList() async {
    final models = await _localDataSource.getAll();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<FavoriteItem?> getFavoriteItem(String stockCode) async {
    final model = await _localDataSource.getByStockCode(stockCode);
    return model?.toEntity();
  }

  @override
  Future<void> addFavoriteItem(FavoriteItem item) async {
    final model = FavoriteItemModel.fromEntity(item);
    await _localDataSource.add(model);
  }

  @override
  Future<void> updateFavoriteItem(FavoriteItem item) async {
    final model = FavoriteItemModel.fromEntity(item);
    await _localDataSource.update(model);
  }

  @override
  Future<void> deleteFavoriteItem(String stockCode) async {
    await _localDataSource.delete(stockCode);
  }

  @override
  Stream<PriceUpdate> getPriceStream(String stockCode) {
    return _remoteDataSource
        .getPriceStream(stockCode)
        .map((model) => model.toEntity());
  }

  @override
  void disposePriceStream(String stockCode) {
    _remoteDataSource.dispose(stockCode);
  }

  @override
  void disposeAllStreams() {
    _remoteDataSource.disposeAll();
  }
}

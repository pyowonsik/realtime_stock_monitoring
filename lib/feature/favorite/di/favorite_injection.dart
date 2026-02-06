import 'package:get_it/get_it.dart';
import 'package:realtime_item/feature/favorite/data/datasource/favorite_local_datasource.dart';
import 'package:realtime_item/feature/favorite/data/datasource/favorite_remote_datasource.dart';
import 'package:realtime_item/feature/favorite/data/repository/favorite_repository_impl.dart';
import 'package:realtime_item/feature/favorite/domain/repository/favorite_repository.dart';
import 'package:realtime_item/feature/favorite/domain/usecase/usecase.dart';
import 'package:realtime_item/feature/favorite/presentation/provider/favorite_provider.dart';

/// Favorite feature 의존성 주입 설정
void registerFavoriteDependencies(GetIt getIt) {
  // DataSources
  getIt
    ..registerLazySingleton<FavoriteLocalDataSource>(
      FavoriteLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<FavoriteRemoteDataSource>(
      FavoriteRemoteDataSourceImpl.new,
    )
    // Repositories
    ..registerLazySingleton<FavoriteRepository>(
      () => FavoriteRepositoryImpl(
        localDataSource: getIt<FavoriteLocalDataSource>(),
        remoteDataSource: getIt<FavoriteRemoteDataSource>(),
      ),
    )
    // UseCases
    ..registerLazySingleton<GetFavoriteListUseCase>(
      () => GetFavoriteListUseCase(getIt<FavoriteRepository>()),
    )
    ..registerLazySingleton<GetFavoriteItemUseCase>(
      () => GetFavoriteItemUseCase(getIt<FavoriteRepository>()),
    )
    ..registerLazySingleton<AddFavoriteItemUseCase>(
      () => AddFavoriteItemUseCase(getIt<FavoriteRepository>()),
    )
    ..registerLazySingleton<UpdateFavoriteItemUseCase>(
      () => UpdateFavoriteItemUseCase(getIt<FavoriteRepository>()),
    )
    ..registerLazySingleton<DeleteFavoriteItemUseCase>(
      () => DeleteFavoriteItemUseCase(getIt<FavoriteRepository>()),
    )
    ..registerLazySingleton<SubscribePriceUpdatesUseCase>(
      () => SubscribePriceUpdatesUseCase(getIt<FavoriteRepository>()),
    )
    ..registerLazySingleton<UnsubscribePriceUpdatesUseCase>(
      () => UnsubscribePriceUpdatesUseCase(getIt<FavoriteRepository>()),
    )
    ..registerLazySingleton<CheckTargetPriceUseCase>(
      CheckTargetPriceUseCase.new,
    )
    // Provider
    ..registerFactory<FavoriteProvider>(
      () => FavoriteProvider(
        getFavoriteListUseCase: getIt<GetFavoriteListUseCase>(),
        addFavoriteItemUseCase: getIt<AddFavoriteItemUseCase>(),
        updateFavoriteItemUseCase: getIt<UpdateFavoriteItemUseCase>(),
        deleteFavoriteItemUseCase: getIt<DeleteFavoriteItemUseCase>(),
        subscribePriceUpdatesUseCase: getIt<SubscribePriceUpdatesUseCase>(),
        unsubscribePriceUpdatesUseCase: getIt<UnsubscribePriceUpdatesUseCase>(),
      ),
    );
}

import 'package:get_it/get_it.dart';
import 'package:realtime_item/feature/alert/data/datasource/alert_history_local_datasource.dart';
import 'package:realtime_item/feature/alert/data/datasource/alerted_stocks_local_datasource.dart';
import 'package:realtime_item/feature/alert/data/repository/alert_repository_impl.dart';
import 'package:realtime_item/feature/alert/domain/repository/alert_repository.dart';
import 'package:realtime_item/feature/alert/domain/usecase/usecase.dart';
import 'package:realtime_item/feature/alert/presentation/provider/alert_provider.dart';
import 'package:realtime_item/feature/favorite/domain/usecase/usecase.dart';

/// Alert feature 의존성 주입 설정
void registerAlertDependencies(GetIt getIt) {
  // DataSources
  getIt
    ..registerLazySingleton<AlertHistoryLocalDataSource>(
      AlertHistoryLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<AlertedStocksLocalDataSource>(
      AlertedStocksLocalDataSourceImpl.new,
    )

    // Repositories
    ..registerLazySingleton<AlertHistoryRepository>(
      () => AlertHistoryRepositoryImpl(localDataSource: getIt()),
    )
    ..registerLazySingleton<AlertedStocksRepository>(
      () => AlertedStocksRepositoryImpl(localDataSource: getIt()),
    )

    // UseCases - AlertHistory
    ..registerLazySingleton(
      () => GetAlertHistoryUseCase(repository: getIt()),
    )
    ..registerLazySingleton(
      () => AddAlertHistoryUseCase(repository: getIt()),
    )
    ..registerLazySingleton(
      () => DeleteAlertHistoryUseCase(repository: getIt()),
    )
    ..registerLazySingleton(
      () => ClearAlertHistoryUseCase(repository: getIt()),
    )

    // UseCases - AlertedStocks
    ..registerLazySingleton(
      () => GetAlertedStocksUseCase(repository: getIt()),
    )
    ..registerLazySingleton(
      () => AddAlertedStockUseCase(repository: getIt()),
    )
    ..registerLazySingleton(
      () => RemoveAlertedStockUseCase(repository: getIt()),
    )

    // Provider
    ..registerFactory<AlertProvider>(
      () => AlertProvider(
        getAlertHistoryUseCase: getIt<GetAlertHistoryUseCase>(),
        addAlertHistoryUseCase: getIt<AddAlertHistoryUseCase>(),
        deleteAlertHistoryUseCase: getIt<DeleteAlertHistoryUseCase>(),
        clearAlertHistoryUseCase: getIt<ClearAlertHistoryUseCase>(),
        getAlertedStocksUseCase: getIt<GetAlertedStocksUseCase>(),
        addAlertedStockUseCase: getIt<AddAlertedStockUseCase>(),
        removeAlertedStockUseCase: getIt<RemoveAlertedStockUseCase>(),
        checkTargetPriceUseCase: getIt<CheckTargetPriceUseCase>(),
      ),
    );
}

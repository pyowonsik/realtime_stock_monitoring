import 'package:get_it/get_it.dart';
import 'package:realtime_item/feature/stock/data/datasource/stock_mock_datasource.dart';
import 'package:realtime_item/feature/stock/data/repository/stock_repository_impl.dart';
import 'package:realtime_item/feature/stock/domain/repository/stock_repository.dart';
import 'package:realtime_item/feature/stock/domain/usecase/get_stocks_usecase.dart';
import 'package:realtime_item/feature/stock/presentation/provider/stock_provider.dart';

/// Stock feature 의존성 주입 설정
void registerStockDependencies(GetIt getIt) {
  // DataSources
  getIt
    ..registerLazySingleton<StockMockDataSource>(
      StockMockDataSourceImpl.new,
    )
    // Repositories
    ..registerLazySingleton<StockRepository>(
      () => StockRepositoryImpl(
        dataSource: getIt<StockMockDataSource>(),
      ),
    )
    // UseCases
    ..registerLazySingleton<GetStocksUseCase>(
      () => GetStocksUseCase(getIt<StockRepository>()),
    )
    // Providers
    ..registerFactory<StockProvider>(
      () => StockProvider(
        getStocksUseCase: getIt<GetStocksUseCase>(),
      ),
    );
}

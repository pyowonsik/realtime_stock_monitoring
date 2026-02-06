import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:realtime_stock_monitoring/feature/favorite/domain/entity/favorite_item.dart';
import 'package:realtime_stock_monitoring/shared/domain/entity/price_update.dart';

part 'favorite_state.freezed.dart';

/// 관심 종목 상태 (Freezed Union Type)
@freezed
sealed class FavoriteState with _$FavoriteState {
  /// 초기 상태
  const factory FavoriteState.initial() = FavoriteInitial;

  /// 로딩 상태
  const factory FavoriteState.loading() = FavoriteLoading;

  /// 로드 완료 상태
  const factory FavoriteState.loaded({
    required List<FavoriteItem> favoriteList,
    required Map<String, PriceUpdate> priceUpdates,
  }) = FavoriteLoaded;

  /// 에러 상태
  const factory FavoriteState.error({
    required String message,
    List<FavoriteItem>? favoriteList,
    Map<String, PriceUpdate>? priceUpdates,
  }) = FavoriteError;
}

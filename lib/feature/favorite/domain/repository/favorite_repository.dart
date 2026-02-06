import 'package:realtime_item/feature/favorite/domain/entity/favorite_item.dart';
import 'package:realtime_item/shared/domain/entity/price_update.dart';

/// 관심 종목 레포지토리 인터페이스
abstract class FavoriteRepository {
  /// 모든 관심 종목 조회
  Future<List<FavoriteItem>> getFavoriteList();

  /// 종목 코드로 관심 종목 조회
  Future<FavoriteItem?> getFavoriteItem(String stockCode);

  /// 관심 종목 추가
  Future<void> addFavoriteItem(FavoriteItem item);

  /// 관심 종목 수정
  Future<void> updateFavoriteItem(FavoriteItem item);

  /// 관심 종목 삭제
  Future<void> deleteFavoriteItem(String stockCode);

  /// 실시간 가격 스트림 구독
  Stream<PriceUpdate> getPriceStream(String stockCode);

  /// 실시간 가격 스트림 구독 해제
  void disposePriceStream(String stockCode);

  /// 모든 스트림 해제
  void disposeAllStreams();
}

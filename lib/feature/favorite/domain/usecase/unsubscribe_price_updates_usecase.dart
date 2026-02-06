import 'package:realtime_item/feature/favorite/domain/repository/favorite_repository.dart';

/// 실시간 가격 업데이트 구독 해제 유즈케이스
class UnsubscribePriceUpdatesUseCase {
  UnsubscribePriceUpdatesUseCase(this._repository);

  final FavoriteRepository _repository;

  void call(String stockCode) {
    _repository.disposePriceStream(stockCode);
  }

  void disposeAll() {
    _repository.disposeAllStreams();
  }
}

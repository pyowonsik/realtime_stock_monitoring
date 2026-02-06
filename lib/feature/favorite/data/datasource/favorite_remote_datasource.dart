import 'dart:async';
import 'dart:math';

import 'package:realtime_item/core/constants/app_constants.dart';
import 'package:realtime_item/feature/favorite/data/model/price_update_model.dart';
import 'package:rxdart/rxdart.dart';

/// Mock WebSocket 데이터소스 인터페이스
abstract class FavoriteRemoteDataSource {
  Stream<PriceUpdateModel> getPriceStream(String stockCode);
  void dispose(String stockCode);
  void disposeAll();
}

/// Mock WebSocket 데이터소스 구현체
/// 실시간 가격 데이터를 시뮬레이션합니다.
class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  final Map<String, BehaviorSubject<PriceUpdateModel>> _subjects = {};
  final Map<String, Timer> _timers = {};
  final Random _random = Random();

  // 종목별 기준 가격 (Mock 데이터)
  static const Map<String, int> _basePrices = {
    '005930': 72500, // 삼성전자
    '000660': 185000, // SK하이닉스
    '035420': 380000, // NAVER
    '035720': 55000, // 카카오
    '051910': 450000, // LG화학
    '006400': 500000, // 삼성SDI
    '005380': 200000, // 현대차
    '000270': 90000, // 기아
    '207940': 750000, // 삼성바이오로직스
    '068270': 350000, // 셀트리온
  };

  int _getBasePrice(String stockCode) {
    return _basePrices[stockCode] ?? 50000;
  }

  @override
  Stream<PriceUpdateModel> getPriceStream(String stockCode) {
    if (_subjects.containsKey(stockCode)) {
      return _subjects[stockCode]!.stream;
    }

    final subject = BehaviorSubject<PriceUpdateModel>();
    _subjects[stockCode] = subject;

    // 초기 가격 방출
    final basePrice = _getBasePrice(stockCode);
    int currentPrice = basePrice;

    subject.add(PriceUpdateModel(
      type: 'price_update',
      stockCode: stockCode,
      currentPrice: currentPrice,
      changeRate: 0.0,
      timestamp: DateTime.now(),
    ));

    // 실시간 가격 업데이트 시뮬레이션
    final timer = Timer.periodic(AppConstants.priceUpdateInterval, (_) {
      // -2% ~ +2% 범위의 랜덤 변동
      final changePercent = (_random.nextDouble() * 4 - 2) / 100;
      final priceChange = (currentPrice * changePercent).round();
      currentPrice = currentPrice + priceChange;

      // 가격이 기준가의 50% ~ 150% 범위 내로 제한
      final minPrice = (basePrice * 0.5).round();
      final maxPrice = (basePrice * 1.5).round();
      currentPrice = currentPrice.clamp(minPrice, maxPrice);

      final changeRate =
          (currentPrice - basePrice) / basePrice * 100;

      if (!subject.isClosed) {
        subject.add(PriceUpdateModel(
          type: 'price_update',
          stockCode: stockCode,
          currentPrice: currentPrice,
          changeRate: double.parse(changeRate.toStringAsFixed(2)),
          timestamp: DateTime.now(),
        ));
      }
    });

    _timers[stockCode] = timer;

    return subject.stream;
  }

  @override
  void dispose(String stockCode) {
    _timers[stockCode]?.cancel();
    _timers.remove(stockCode);

    _subjects[stockCode]?.close();
    _subjects.remove(stockCode);
  }

  @override
  void disposeAll() {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear();

    for (final subject in _subjects.values) {
      subject.close();
    }
    _subjects.clear();
  }
}

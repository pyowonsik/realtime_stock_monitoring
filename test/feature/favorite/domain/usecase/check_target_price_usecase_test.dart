import 'package:flutter_test/flutter_test.dart';
import 'package:realtime_stock_monitoring/feature/favorite/domain/entity/favorite_item.dart';
import 'package:realtime_stock_monitoring/feature/favorite/domain/usecase/check_target_price_usecase.dart';
import 'package:realtime_stock_monitoring/shared/domain/entity/price_update.dart';

void main() {
  late CheckTargetPriceUseCase useCase;

  setUp(() {
    useCase = CheckTargetPriceUseCase();
  });

  group('CheckTargetPriceUseCase', () {
    group('상한가 알림 (AlertType.upper)', () {
      test('이전가 < 목표가 && 현재가 >= 목표가 → true', () {
        final item = FavoriteItem(
          stockCode: '005930',
          stockName: '삼성전자',
          targetPrice: 70000,
          alertType: AlertType.upper,
          createdAt: DateTime.now(),
        );
        final priceUpdate = PriceUpdate(
          stockCode: '005930',
          currentPrice: 70000,
          changeRate: 1.0,
          timestamp: DateTime.now(),
        );

        final result = useCase(
          item: item,
          priceUpdate: priceUpdate,
          previousPrice: 69000,
        );

        expect(result, isTrue);
      });

      test('이전가 >= 목표가 → false (이미 도달)', () {
        final item = FavoriteItem(
          stockCode: '005930',
          stockName: '삼성전자',
          targetPrice: 70000,
          alertType: AlertType.upper,
          createdAt: DateTime.now(),
        );
        final priceUpdate = PriceUpdate(
          stockCode: '005930',
          currentPrice: 71000,
          changeRate: 1.0,
          timestamp: DateTime.now(),
        );

        final result = useCase(
          item: item,
          priceUpdate: priceUpdate,
          previousPrice: 70000,
        );

        expect(result, isFalse);
      });

      test('현재가 < 목표가 → false (아직 미도달)', () {
        final item = FavoriteItem(
          stockCode: '005930',
          stockName: '삼성전자',
          targetPrice: 70000,
          alertType: AlertType.upper,
          createdAt: DateTime.now(),
        );
        final priceUpdate = PriceUpdate(
          stockCode: '005930',
          currentPrice: 69500,
          changeRate: 1.0,
          timestamp: DateTime.now(),
        );

        final result = useCase(
          item: item,
          priceUpdate: priceUpdate,
          previousPrice: 69000,
        );

        expect(result, isFalse);
      });
    });

    group('하한가 알림 (AlertType.lower)', () {
      test('이전가 > 목표가 && 현재가 <= 목표가 → true', () {
        final item = FavoriteItem(
          stockCode: '005930',
          stockName: '삼성전자',
          targetPrice: 70000,
          alertType: AlertType.lower,
          createdAt: DateTime.now(),
        );
        final priceUpdate = PriceUpdate(
          stockCode: '005930',
          currentPrice: 70000,
          changeRate: -1.0,
          timestamp: DateTime.now(),
        );

        final result = useCase(
          item: item,
          priceUpdate: priceUpdate,
          previousPrice: 71000,
        );

        expect(result, isTrue);
      });

      test('이전가 <= 목표가 → false (이미 도달)', () {
        final item = FavoriteItem(
          stockCode: '005930',
          stockName: '삼성전자',
          targetPrice: 70000,
          alertType: AlertType.lower,
          createdAt: DateTime.now(),
        );
        final priceUpdate = PriceUpdate(
          stockCode: '005930',
          currentPrice: 69000,
          changeRate: -1.0,
          timestamp: DateTime.now(),
        );

        final result = useCase(
          item: item,
          priceUpdate: priceUpdate,
          previousPrice: 70000,
        );

        expect(result, isFalse);
      });
    });

    group('양방향 알림 (AlertType.both)', () {
      test('상향 돌파 시 → true', () {
        final item = FavoriteItem(
          stockCode: '005930',
          stockName: '삼성전자',
          targetPrice: 70000,
          alertType: AlertType.both,
          createdAt: DateTime.now(),
        );
        final priceUpdate = PriceUpdate(
          stockCode: '005930',
          currentPrice: 70500,
          changeRate: 1.0,
          timestamp: DateTime.now(),
        );

        final result = useCase(
          item: item,
          priceUpdate: priceUpdate,
          previousPrice: 69500,
        );

        expect(result, isTrue);
      });

      test('하향 돌파 시 → true', () {
        final item = FavoriteItem(
          stockCode: '005930',
          stockName: '삼성전자',
          targetPrice: 70000,
          alertType: AlertType.both,
          createdAt: DateTime.now(),
        );
        final priceUpdate = PriceUpdate(
          stockCode: '005930',
          currentPrice: 69500,
          changeRate: -1.0,
          timestamp: DateTime.now(),
        );

        final result = useCase(
          item: item,
          priceUpdate: priceUpdate,
          previousPrice: 70500,
        );

        expect(result, isTrue);
      });
    });

    group('엣지 케이스', () {
      test('목표가가 null이면 → false', () {
        final item = FavoriteItem(
          stockCode: '005930',
          stockName: '삼성전자',
          targetPrice: null,
          alertType: AlertType.upper,
          createdAt: DateTime.now(),
        );
        final priceUpdate = PriceUpdate(
          stockCode: '005930',
          currentPrice: 70000,
          changeRate: 1.0,
          timestamp: DateTime.now(),
        );

        final result = useCase(
          item: item,
          priceUpdate: priceUpdate,
          previousPrice: 69000,
        );

        expect(result, isFalse);
      });

      test('이전 가격이 null이면 → false', () {
        final item = FavoriteItem(
          stockCode: '005930',
          stockName: '삼성전자',
          targetPrice: 70000,
          alertType: AlertType.upper,
          createdAt: DateTime.now(),
        );
        final priceUpdate = PriceUpdate(
          stockCode: '005930',
          currentPrice: 70000,
          changeRate: 1.0,
          timestamp: DateTime.now(),
        );

        final result = useCase(
          item: item,
          priceUpdate: priceUpdate,
          previousPrice: null,
        );

        expect(result, isFalse);
      });
    });
  });
}

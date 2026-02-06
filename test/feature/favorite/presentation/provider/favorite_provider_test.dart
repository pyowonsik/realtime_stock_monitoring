import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:realtime_stock_monitoring/feature/favorite/domain/entity/favorite_item.dart';
import 'package:realtime_stock_monitoring/feature/favorite/domain/usecase/usecase.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/provider/favorite_provider.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/provider/favorite_state.dart';
import 'package:realtime_stock_monitoring/shared/domain/entity/price_update.dart';

// Mocks
class MockGetFavoriteListUseCase extends Mock implements GetFavoriteListUseCase {}

class MockAddFavoriteItemUseCase extends Mock implements AddFavoriteItemUseCase {}

class MockUpdateFavoriteItemUseCase extends Mock implements UpdateFavoriteItemUseCase {}

class MockDeleteFavoriteItemUseCase extends Mock implements DeleteFavoriteItemUseCase {}

class MockSubscribePriceUpdatesUseCase extends Mock implements SubscribePriceUpdatesUseCase {}

class MockUnsubscribePriceUpdatesUseCase extends Mock implements UnsubscribePriceUpdatesUseCase {}

// Fakes
class FakeFavoriteItem extends Fake implements FavoriteItem {}

void main() {
  late FavoriteProvider provider;
  late MockGetFavoriteListUseCase mockGetFavoriteListUseCase;
  late MockAddFavoriteItemUseCase mockAddFavoriteItemUseCase;
  late MockUpdateFavoriteItemUseCase mockUpdateFavoriteItemUseCase;
  late MockDeleteFavoriteItemUseCase mockDeleteFavoriteItemUseCase;
  late MockSubscribePriceUpdatesUseCase mockSubscribePriceUpdatesUseCase;
  late MockUnsubscribePriceUpdatesUseCase mockUnsubscribePriceUpdatesUseCase;

  setUpAll(() {
    registerFallbackValue(FakeFavoriteItem());
  });

  setUp(() {
    mockGetFavoriteListUseCase = MockGetFavoriteListUseCase();
    mockAddFavoriteItemUseCase = MockAddFavoriteItemUseCase();
    mockUpdateFavoriteItemUseCase = MockUpdateFavoriteItemUseCase();
    mockDeleteFavoriteItemUseCase = MockDeleteFavoriteItemUseCase();
    mockSubscribePriceUpdatesUseCase = MockSubscribePriceUpdatesUseCase();
    mockUnsubscribePriceUpdatesUseCase = MockUnsubscribePriceUpdatesUseCase();

    provider = FavoriteProvider(
      getFavoriteListUseCase: mockGetFavoriteListUseCase,
      addFavoriteItemUseCase: mockAddFavoriteItemUseCase,
      updateFavoriteItemUseCase: mockUpdateFavoriteItemUseCase,
      deleteFavoriteItemUseCase: mockDeleteFavoriteItemUseCase,
      subscribePriceUpdatesUseCase: mockSubscribePriceUpdatesUseCase,
      unsubscribePriceUpdatesUseCase: mockUnsubscribePriceUpdatesUseCase,
    );
  });

  group('FavoriteProvider', () {
    final testItem = FavoriteItem(
      stockCode: '005930',
      stockName: '삼성전자',
      alertType: AlertType.upper,
      targetPrice: 70000,
      createdAt: DateTime.now(),
    );

    group('초기 상태', () {
      test('초기 상태는 FavoriteInitial', () {
        expect(provider.state, isA<FavoriteInitial>());
        expect(provider.favoriteList, isEmpty);
        expect(provider.isLoading, isFalse);
      });
    });

    group('loadFavoriteList', () {
      test('로딩 성공 시 FavoriteLoaded 상태로 변경', () async {
        // Given
        final favoriteList = [testItem];
        when(() => mockGetFavoriteListUseCase())
            .thenAnswer((_) async => favoriteList);
        when(() => mockSubscribePriceUpdatesUseCase(any()))
            .thenAnswer((_) => const Stream.empty());

        // When
        await provider.loadFavoriteList();

        // Then
        expect(provider.state, isA<FavoriteLoaded>());
        expect(provider.favoriteList, equals(favoriteList));
      });

      test('로딩 중 isLoading이 true', () async {
        // Given
        when(() => mockGetFavoriteListUseCase())
            .thenAnswer((_) async {
          await Future<void>.delayed(const Duration(milliseconds: 100));
          return <FavoriteItem>[];
        });

        // When
        final future = provider.loadFavoriteList();

        // Then
        expect(provider.isLoading, isTrue);
        await future;
      });

      test('로딩 실패 시 FavoriteError 상태로 변경', () async {
        // Given
        when(() => mockGetFavoriteListUseCase())
            .thenThrow(Exception('Load failed'));

        // When
        await provider.loadFavoriteList();

        // Then
        expect(provider.state, isA<FavoriteError>());
        expect(provider.error, contains('Load failed'));
      });
    });

    group('addFavoriteItem', () {
      test('종목 추가 성공', () async {
        // Given - 먼저 로드된 상태로 설정
        when(() => mockGetFavoriteListUseCase())
            .thenAnswer((_) async => <FavoriteItem>[]);
        when(() => mockSubscribePriceUpdatesUseCase(any()))
            .thenAnswer((_) => const Stream.empty());
        await provider.loadFavoriteList();

        when(() => mockAddFavoriteItemUseCase(any()))
            .thenAnswer((_) async {});

        // When
        await provider.addFavoriteItem(testItem);

        // Then
        expect(provider.favoriteList, contains(testItem));
        verify(() => mockAddFavoriteItemUseCase(testItem)).called(1);
      });

      test('중복 종목 추가 시 예외 발생 및 에러 상태', () async {
        // Given - 먼저 로드된 상태로 설정
        when(() => mockGetFavoriteListUseCase())
            .thenAnswer((_) async => <FavoriteItem>[]);
        when(() => mockSubscribePriceUpdatesUseCase(any()))
            .thenAnswer((_) => const Stream.empty());
        await provider.loadFavoriteList();

        when(() => mockAddFavoriteItemUseCase(any()))
            .thenThrow(DuplicateFavoriteItemException('005930'));

        // When & Then
        expect(
          () => provider.addFavoriteItem(testItem),
          throwsA(isA<DuplicateFavoriteItemException>()),
        );
      });
    });

    group('deleteFavoriteItem', () {
      test('종목 삭제 성공', () async {
        // Given - 먼저 아이템이 있는 상태로 로드
        when(() => mockGetFavoriteListUseCase())
            .thenAnswer((_) async => [testItem]);
        when(() => mockSubscribePriceUpdatesUseCase(any()))
            .thenAnswer((_) => const Stream.empty());
        await provider.loadFavoriteList();

        when(() => mockDeleteFavoriteItemUseCase(any()))
            .thenAnswer((_) async {});
        when(() => mockUnsubscribePriceUpdatesUseCase(any()))
            .thenReturn(null);

        // When
        await provider.deleteFavoriteItem(testItem.stockCode);

        // Then
        expect(
          provider.favoriteList.any((i) => i.stockCode == testItem.stockCode),
          isFalse,
        );
        verify(() => mockDeleteFavoriteItemUseCase(testItem.stockCode)).called(1);
      });
    });

    group('updateFavoriteItem', () {
      test('목표가 수정 성공', () async {
        // Given - 먼저 아이템이 있는 상태로 로드
        when(() => mockGetFavoriteListUseCase())
            .thenAnswer((_) async => [testItem]);
        when(() => mockSubscribePriceUpdatesUseCase(any()))
            .thenAnswer((_) => const Stream.empty());
        await provider.loadFavoriteList();

        final updatedItem = testItem.copyWith(targetPrice: 80000);
        when(() => mockUpdateFavoriteItemUseCase(any()))
            .thenAnswer((_) async {});

        // When
        await provider.updateFavoriteItem(updatedItem);

        // Then
        final foundItem = provider.favoriteList
            .firstWhere((i) => i.stockCode == testItem.stockCode);
        expect(foundItem.targetPrice, equals(80000));
        verify(() => mockUpdateFavoriteItemUseCase(updatedItem)).called(1);
      });
    });

    group('실시간 가격 스트림', () {
      test('로드 시 각 종목에 대해 가격 스트림 구독', () async {
        // Given
        final items = [
          testItem,
          FavoriteItem(
            stockCode: '000660',
            stockName: 'SK하이닉스',
            alertType: AlertType.lower,
            createdAt: DateTime.now(),
          ),
        ];
        when(() => mockGetFavoriteListUseCase())
            .thenAnswer((_) async => items);
        when(() => mockSubscribePriceUpdatesUseCase(any()))
            .thenAnswer((_) => const Stream.empty());

        // When
        await provider.loadFavoriteList();

        // Then
        verify(() => mockSubscribePriceUpdatesUseCase('005930')).called(1);
        verify(() => mockSubscribePriceUpdatesUseCase('000660')).called(1);
      });

      test('가격 업데이트 수신 시 상태 반영', () async {
        // Given
        final priceController = StreamController<PriceUpdate>();
        when(() => mockGetFavoriteListUseCase())
            .thenAnswer((_) async => [testItem]);
        when(() => mockSubscribePriceUpdatesUseCase(testItem.stockCode))
            .thenAnswer((_) => priceController.stream);

        await provider.loadFavoriteList();

        final priceUpdate = PriceUpdate(
          stockCode: testItem.stockCode,
          currentPrice: 72000,
          changeRate: 1.5,
          timestamp: DateTime.now(),
        );

        // When
        priceController.add(priceUpdate);
        await Future<void>.delayed(const Duration(milliseconds: 50));

        // Then
        expect(provider.priceUpdates[testItem.stockCode], equals(priceUpdate));

        // Cleanup
        await priceController.close();
      });
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:realtime_stock_monitoring/feature/favorite/domain/entity/favorite_item.dart';
import 'package:realtime_stock_monitoring/feature/favorite/domain/repository/favorite_repository.dart';
import 'package:realtime_stock_monitoring/feature/favorite/domain/usecase/add_favorite_item_usecase.dart';

class MockFavoriteRepository extends Mock implements FavoriteRepository {}

class FakeFavoriteItem extends Fake implements FavoriteItem {}

void main() {
  late AddFavoriteItemUseCase useCase;
  late MockFavoriteRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeFavoriteItem());
  });

  setUp(() {
    mockRepository = MockFavoriteRepository();
    useCase = AddFavoriteItemUseCase(mockRepository);
  });

  group('AddFavoriteItemUseCase', () {
    final testItem = FavoriteItem(
      stockCode: '005930',
      stockName: '삼성전자',
      alertType: AlertType.upper,
      createdAt: DateTime.now(),
    );

    test('새로운 종목 추가 성공', () async {
      // Given
      when(() => mockRepository.getFavoriteItem(testItem.stockCode))
          .thenAnswer((_) async => null);
      when(() => mockRepository.addFavoriteItem(any()))
          .thenAnswer((_) async {});

      // When
      await useCase(testItem);

      // Then
      verify(() => mockRepository.getFavoriteItem(testItem.stockCode)).called(1);
      verify(() => mockRepository.addFavoriteItem(testItem)).called(1);
    });

    test('중복 종목 등록 시 DuplicateFavoriteItemException 발생', () async {
      // Given
      when(() => mockRepository.getFavoriteItem(testItem.stockCode))
          .thenAnswer((_) async => testItem);

      // When & Then
      expect(
        () => useCase(testItem),
        throwsA(isA<DuplicateFavoriteItemException>()),
      );

      verify(() => mockRepository.getFavoriteItem(testItem.stockCode)).called(1);
      verifyNever(() => mockRepository.addFavoriteItem(any()));
    });

    test('중복 예외 메시지에 종목 코드 포함', () {
      final exception = DuplicateFavoriteItemException('005930');

      expect(exception.toString(), contains('005930'));
      expect(exception.stockCode, equals('005930'));
    });
  });
}

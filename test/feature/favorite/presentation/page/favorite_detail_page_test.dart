import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:realtime_stock_monitoring/feature/alert/presentation/provider/alert_provider.dart';
import 'package:realtime_stock_monitoring/feature/alert/presentation/provider/alert_state.dart';
import 'package:realtime_stock_monitoring/feature/favorite/domain/entity/favorite_item.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/page/favorite_detail_page.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/provider/favorite_provider.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/provider/favorite_state.dart';
import 'package:realtime_stock_monitoring/shared/domain/entity/price_update.dart';

class MockFavoriteProvider extends Mock implements FavoriteProvider {}

class MockAlertProvider extends Mock implements AlertProvider {}

void main() {
  late MockFavoriteProvider mockFavoriteProvider;
  late MockAlertProvider mockAlertProvider;

  setUp(() {
    mockFavoriteProvider = MockFavoriteProvider();
    mockAlertProvider = MockAlertProvider();

    // FavoriteProvider 기본 상태 설정
    when(() => mockFavoriteProvider.state).thenReturn(
      const FavoriteState.loaded(favoriteList: [], priceUpdates: {}),
    );
    when(() => mockFavoriteProvider.favoriteList).thenReturn([]);
    when(() => mockFavoriteProvider.priceUpdates).thenReturn({});
    when(() => mockFavoriteProvider.getPriceUpdate(any())).thenReturn(null);
    when(() => mockFavoriteProvider.subscribeToPriceUpdates(any())).thenReturn(null);
    when(() => mockFavoriteProvider.alertProvider).thenReturn(mockAlertProvider);
    when(() => mockFavoriteProvider.addListener(any())).thenReturn(null);
    when(() => mockFavoriteProvider.removeListener(any())).thenReturn(null);

    // AlertProvider 기본 상태 설정
    when(() => mockAlertProvider.state).thenReturn(const AlertState.initial());
    when(() => mockAlertProvider.alertHistory).thenReturn([]);
    when(() => mockAlertProvider.addListener(any())).thenReturn(null);
    when(() => mockAlertProvider.removeListener(any())).thenReturn(null);
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<FavoriteProvider>.value(value: mockFavoriteProvider),
          ChangeNotifierProvider<AlertProvider>.value(value: mockAlertProvider),
        ],
        child: const FavoriteDetailPage(
          stockCode: '005930',
          stockName: '삼성전자',
        ),
      ),
    );
  }

  group('FavoriteDetailPage 스크롤 연동 테스트', () {
    testWidgets('섹션 네비게이션 버튼들이 표시됨', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // 섹션 버튼들 확인
      expect(find.text('가격'), findsOneWidget);
      expect(find.text('요약'), findsOneWidget);
      expect(find.text('입력'), findsOneWidget);
      expect(find.text('확장 패널'), findsOneWidget);
      expect(find.text('뉴스'), findsOneWidget);
      expect(find.text('재무'), findsOneWidget);
      expect(find.text('기타'), findsOneWidget);
    });

    testWidgets('상단 헤더에 종목명이 표시됨', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // 종목명이 화면에 표시됨 (AppBar와 요약 섹션에 표시될 수 있음)
      expect(find.text('삼성전자'), findsAtLeastNWidgets(1));
    });

    testWidgets('섹션 버튼 클릭 시 해당 섹션으로 스크롤', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // '요약' 버튼 탭
      await tester.tap(find.text('요약'));
      await tester.pumpAndSettle();

      // 스크롤이 발생했는지 확인 (요약 섹션이 보여야 함)
      expect(find.text('종목 요약'), findsOneWidget);
    });

    testWidgets('스크롤 후에도 네비게이션 버튼이 pinned 상태 유지', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // 아래로 스크롤
      await tester.drag(
        find.byType(CustomScrollView),
        const Offset(0, -500),
      );
      await tester.pumpAndSettle();

      // 스크롤 후에도 네비게이션 버튼들이 여전히 표시됨 (pinned)
      expect(find.text('가격'), findsOneWidget);
      expect(find.text('요약'), findsOneWidget);
    });

    testWidgets('가격 섹션에 현재가가 표시됨', (tester) async {
      // 가격 데이터 설정
      final priceUpdate = PriceUpdate(
        stockCode: '005930',
        currentPrice: 72500,
        changeRate: 1.25,
        timestamp: DateTime.now(),
      );
      when(() => mockFavoriteProvider.getPriceUpdate('005930')).thenReturn(priceUpdate);
      when(() => mockFavoriteProvider.priceUpdates).thenReturn({'005930': priceUpdate});

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // 가격이 표시되는지 확인
      expect(find.textContaining('72,500'), findsWidgets);
    });

    testWidgets('입력 섹션에 TextField가 있음', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // '입력' 섹션으로 스크롤
      await tester.tap(find.text('입력'));
      await tester.pumpAndSettle();

      // TextField 존재 확인
      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('확장 패널 섹션이 있음', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // '확장 패널' 섹션으로 스크롤
      await tester.tap(find.text('확장 패널'));
      await tester.pumpAndSettle();

      // ExpansionPanelList 존재 확인 (상세 정보 헤더 텍스트로 확인)
      expect(find.text('상세 정보'), findsOneWidget);
    });

    testWidgets('dispose 시 에러 없이 종료됨', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // 위젯 제거
      await tester.pumpWidget(const MaterialApp(home: Scaffold()));
      await tester.pumpAndSettle();

      // 에러 없이 완료되면 성공
      expect(true, isTrue);
    });
  });

  group('FavoriteDetailPage 관심종목 기능 테스트', () {
    testWidgets('관심 종목 버튼이 표시됨', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // 하트 아이콘 확인
      expect(
        find.byIcon(Icons.favorite_border).evaluate().isNotEmpty ||
            find.byIcon(Icons.favorite).evaluate().isNotEmpty,
        isTrue,
      );
    });

    testWidgets('이미 등록된 종목은 채워진 하트 아이콘 표시', (tester) async {
      // 이미 등록된 종목 설정
      final savedItem = FavoriteItem(
        stockCode: '005930',
        stockName: '삼성전자',
        alertType: AlertType.upper,
        createdAt: DateTime.now(),
      );
      when(() => mockFavoriteProvider.favoriteList).thenReturn([savedItem]);

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });
  });
}

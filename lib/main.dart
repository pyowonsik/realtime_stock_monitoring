import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_stock_monitoring/core/constants/app_constants.dart';
import 'package:realtime_stock_monitoring/core/di/injection.dart';
import 'package:realtime_stock_monitoring/core/services/app_lifecycle_service.dart';
import 'package:realtime_stock_monitoring/core/services/notification_service.dart';
import 'package:realtime_stock_monitoring/core/utils/alert_type_extension.dart';
import 'package:realtime_stock_monitoring/core/utils/price_formatter.dart';
import 'package:realtime_stock_monitoring/feature/alert/presentation/page/alert_history_page.dart';
import 'package:realtime_stock_monitoring/feature/alert/presentation/provider/alert_provider.dart';
import 'package:realtime_stock_monitoring/feature/favorite/domain/entity/favorite_item.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/page/favorite_list_page.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/provider/favorite_provider.dart';
import 'package:realtime_stock_monitoring/feature/stock/presentation/page/stock_list_page.dart';
import 'package:realtime_stock_monitoring/feature/stock/presentation/provider/stock_provider.dart';
import 'package:realtime_stock_monitoring/shared/domain/entity/price_update.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 앱 라이프사이클 서비스 초기화
  AppLifecycleService().initialize();

  // 의존성 주입 초기화
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider 생성
    final alertProvider = getIt<AlertProvider>()..loadAlertData();
    final favoriteProvider = getIt<FavoriteProvider>()
      ..alertProvider = alertProvider
      ..loadFavoriteList();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => getIt<StockProvider>()..loadStocks(),
        ),
        ChangeNotifierProvider.value(value: alertProvider),
        ChangeNotifierProvider.value(value: favoriteProvider),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          cardTheme: CardThemeData(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade200),
            ),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}

/// 홈 페이지 - 탭 구조 (전체 종목 / 관심 종목)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  AlertProvider? _alertProvider;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // 목표가 알림 콜백 설정 (앱 전역)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _alertProvider = context.read<AlertProvider>();
      _alertProvider?.onTargetReached = _handleTargetReached;
    });
  }

  @override
  void dispose() {
    // 콜백 해제
    _alertProvider?.onTargetReached = null;
    _tabController.dispose();
    super.dispose();
  }

  /// 목표가 도달 시 알림 처리
  void _handleTargetReached(FavoriteItem item, PriceUpdate priceUpdate) {
    final alertTypeText = item.alertType.breachText;
    final appLifecycle = AppLifecycleService();

    if (appLifecycle.isForeground && mounted) {
      // 포그라운드: AlertDialog 표시
      _showAlertDialog(item, priceUpdate.currentPrice, alertTypeText);
    } else {
      // 백그라운드: 푸시 알림
      getIt<NotificationService>().showTargetPriceAlert(
        stockName: item.stockName,
        stockCode: item.stockCode,
        currentPrice: priceUpdate.currentPrice,
        targetPrice: item.targetPrice ?? 0,
        alertType: alertTypeText,
      );
    }
  }

  /// 포그라운드용 AlertDialog 표시
  void _showAlertDialog(FavoriteItem item, int currentPrice, String alertTypeText) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.notifications_active, color: Colors.orange.shade700),
            const SizedBox(width: 8),
            const Text('목표가 도달'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.stockName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _InfoRow(label: '알림 조건', value: alertTypeText),
            _InfoRow(
              label: '목표가',
              value: '${PriceFormatter.formatPriceWithComma(item.targetPrice ?? 0)}원',
            ),
            _InfoRow(
              label: '현재가',
              value: '${PriceFormatter.formatPriceWithComma(currentPrice)}원',
              valueColor: currentPrice >= (item.targetPrice ?? 0) ? Colors.red : Colors.blue,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '종목 모니터링',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          Consumer<AlertProvider>(
            builder: (context, alertProvider, _) {
              final historyCount = alertProvider.alertHistory.length;
              return IconButton(
                icon: Badge(
                  isLabelVisible: historyCount > 0,
                  label: Text(
                    historyCount > 99 ? '99+' : historyCount.toString(),
                    style: const TextStyle(fontSize: 10),
                  ),
                  child: const Icon(Icons.notifications_outlined),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const AlertHistoryPage(),
                    ),
                  );
                },
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Theme.of(context).primaryColor,
          tabs: const [
            Tab(text: '전체 종목'),
            Tab(text: '관심 종목'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 전체 종목 탭
          StockListPage(
            onAddToFavorite: () {
              // 관심 종목 탭으로 이동
              _tabController.animateTo(1);
            },
          ),
          // 관심 종목 탭
          const FavoriteListPage(),
        ],
      ),
    );
  }
}

/// 알림 다이얼로그용 정보 행 위젯
class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_stock_monitoring/core/constants/app_constants.dart';
import 'package:realtime_stock_monitoring/core/di/injection.dart';
import 'package:realtime_stock_monitoring/core/services/app_lifecycle_service.dart';
import 'package:realtime_stock_monitoring/feature/alert/presentation/page/alert_history_page.dart';
import 'package:realtime_stock_monitoring/feature/alert/presentation/provider/alert_provider.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/page/favorite_list_page.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/provider/favorite_provider.dart';
import 'package:realtime_stock_monitoring/feature/stock/presentation/page/stock_list_page.dart';
import 'package:realtime_stock_monitoring/feature/stock/presentation/provider/stock_provider.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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

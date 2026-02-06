import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_item/core/constants/app_constants.dart';
import 'package:realtime_item/core/di/injection.dart';
import 'package:realtime_item/core/services/app_lifecycle_service.dart';
import 'package:realtime_item/core/services/notification_service.dart';
import 'package:realtime_item/core/utils/alert_type_extension.dart';
import 'package:realtime_item/core/utils/price_formatter.dart';
import 'package:realtime_item/feature/alert/presentation/provider/alert_provider.dart';
import 'package:realtime_item/feature/favorite/domain/entity/favorite_item.dart';
import 'package:realtime_item/feature/favorite/presentation/provider/favorite_provider.dart';
import 'package:realtime_item/feature/favorite/presentation/widget/widget.dart';

/// 섹션 이름 목록
const List<String> _sectionNames = [
  '가격',
  '요약',
  '입력',
  '확장 패널',
  '뉴스',
  '재무',
  '기타',
];

/// 종목 상세 페이지
class FavoriteDetailPage extends StatefulWidget {
  const FavoriteDetailPage({
    required this.stockCode,
    required this.stockName,
    super.key,
    this.logoUrl,
  });

  final String stockCode;
  final String stockName;
  final String? logoUrl;

  @override
  State<FavoriteDetailPage> createState() => _FavoriteDetailPageState();
}

class _FavoriteDetailPageState extends State<FavoriteDetailPage> {
  // 스크롤 컨트롤러
  late ScrollController _scrollController;
  late ScrollController _navScrollController;

  // 각 섹션의 GlobalKey
  final List<GlobalKey> _sectionKeys = List.generate(
    _sectionNames.length,
    (_) => GlobalKey(),
  );

  // 현재 선택된 섹션 인덱스 (ValueNotifier로 불필요한 rebuild 방지)
  final ValueNotifier<int> _selectedSectionIndex = ValueNotifier(0);

  // 입력 섹션 상태
  int? _targetPrice;
  AlertType _alertType = AlertType.upper;
  bool _isSaving = false;

  // 프로그래매틱 스크롤 중인지 여부 (스크롤 이벤트 충돌 방지)
  bool _isProgrammaticScroll = false;

  // AlertProvider 참조 (dispose 시 콜백 해제용)
  AlertProvider? _alertProvider;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _navScrollController = ScrollController();

    // 가격 스트림 구독 및 목표가 알림 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final favoriteProvider = context.read<FavoriteProvider>()
        ..subscribeToPriceUpdates(widget.stockCode);
      _alertProvider = context.read<AlertProvider>();

      // 기존 favorite item 정보 로드
      final existingItem = favoriteProvider.favoriteList
          .where((i) => i.stockCode == widget.stockCode)
          .firstOrNull;
      if (existingItem != null) {
        setState(() {
          _targetPrice = existingItem.targetPrice;
          _alertType = existingItem.alertType;
        });
      }

      // 목표가 도달 시 알림 콜백 설정 (AlertProvider 사용)
      _alertProvider?.onTargetReached = (item, priceUpdate) {
        if (mounted) {
          _showTargetPriceAlert(item, priceUpdate.currentPrice);
        }
      };
    });
  }

  /// 관심 종목 토글 (추가/삭제)
  Future<void> _handleToggleFavorite(
    BuildContext context,
    FavoriteProvider provider,
    FavoriteItem? savedItem,
  ) async {
    try {
      if (savedItem != null) {
        // 관심 종목에서 삭제
        await provider.deleteFavoriteItem(widget.stockCode);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${widget.stockName}을(를) 관심 종목에서 삭제했습니다')),
          );
          // 삭제 후 이전 화면으로 이동
          Navigator.pop(context);
        }
      } else {
        // 관심 종목에 추가
        final item = FavoriteItem(
          stockCode: widget.stockCode,
          stockName: widget.stockName,
          logoUrl: widget.logoUrl,
          alertType: AlertType.both,
          createdAt: DateTime.now(),
        );
        await provider.addFavoriteItem(item);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${widget.stockName}을(를) 관심 종목에 추가했습니다')),
          );
        }
      }
    } on Exception catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('처리 실패: $e')),
        );
      }
    }
  }

  /// 저장된 알림 삭제
  Future<void> _deleteSavedAlert(FavoriteProvider provider) async {
    final existingItem = provider.favoriteList
        .where((i) => i.stockCode == widget.stockCode)
        .firstOrNull;

    if (existingItem == null) return;

    // freezed copyWith는 nullable 필드에 null 설정 가능
    final clearedItem = existingItem.copyWith(
      targetPrice: null,
      alertType: AlertType.upper,
    );

    await provider.updateFavoriteItem(clearedItem);

    setState(() {
      _targetPrice = null;
      _alertType = AlertType.upper;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('알림이 삭제되었습니다')),
      );
    }
  }

  /// 목표가 저장
  Future<void> _saveTargetPrice() async {
    final provider = context.read<FavoriteProvider>();
    final existingItem = provider.favoriteList
        .where((i) => i.stockCode == widget.stockCode)
        .firstOrNull;

    if (existingItem == null) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final updatedItem = existingItem.copyWith(
        targetPrice: _targetPrice,
        alertType: _alertType,
      );
      await provider.updateFavoriteItem(updatedItem);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('목표가가 저장되었습니다')),
        );
      }
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('저장 실패: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  /// 목표가 도달 알림 표시
  /// - 포그라운드: AlertDialog
  /// - 백그라운드: 푸시 알림
  void _showTargetPriceAlert(FavoriteItem item, int currentPrice) {
    final alertTypeText = item.alertType.breachText;
    final appLifecycle = AppLifecycleService();

    if (appLifecycle.isForeground && mounted) {
      // 포그라운드: AlertDialog 표시
      _showAlertDialog(item, currentPrice, alertTypeText);
    } else {
      // 백그라운드: 푸시 알림
      getIt<NotificationService>().showTargetPriceAlert(
        stockName: item.stockName,
        stockCode: item.stockCode,
        currentPrice: currentPrice,
        targetPrice: item.targetPrice ?? 0,
        alertType: alertTypeText,
      );
    }
  }

  /// 포그라운드용 AlertDialog 표시
  void _showAlertDialog(FavoriteItem item, int currentPrice, String alertTypeText) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
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
            InfoRowWidget(label: '알림 조건', value: alertTypeText),
            InfoRowWidget(label: '목표가', value: '${PriceFormatter.formatPriceWithComma(item.targetPrice ?? 0)}원'),
            InfoRowWidget(
              label: '현재가',
              value: '${PriceFormatter.formatPriceWithComma(currentPrice)}원',
              valueColor: currentPrice >= (item.targetPrice ?? 0) ? Colors.red : Colors.blue,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // AlertProvider 콜백 해제 (메모리 누수 방지)
    _alertProvider?.onTargetReached = null;

    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _navScrollController.dispose();
    _selectedSectionIndex.dispose();
    super.dispose();
  }

  /// 스크롤 이벤트 핸들러 - 현재 보이는 섹션 감지
  void _onScroll() {
    if (_isProgrammaticScroll) return;

    int newIndex = 0;

    // 각 섹션의 위치를 확인하여 현재 보이는 섹션 결정
    for (int i = 0; i < _sectionKeys.length; i++) {
      final key = _sectionKeys[i];
      final context = key.currentContext;

      if (context != null) {
        final RenderBox box = context.findRenderObject()! as RenderBox;
        final position = box.localToGlobal(Offset.zero);

        // AppBar + Navigation 높이를 고려한 offset (약 160)
        const headerOffset = 160.0;

        // 섹션이 화면 상단 근처에 있으면 해당 섹션 선택
        if (position.dy <= headerOffset + 50) {
          newIndex = i;
        }
      }
    }

    if (_selectedSectionIndex.value != newIndex) {
      _selectedSectionIndex.value = newIndex;
      _scrollNavToCenter(newIndex);
    }
  }

  /// 네비게이션 버튼을 화면 중앙으로 스크롤
  void _scrollNavToCenter(int index) {
    if (!_navScrollController.hasClients) return;

    // 각 버튼의 대략적인 너비 (padding 포함)
    const buttonWidth = 80.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final targetOffset =
        (index * buttonWidth) - (screenWidth / 2) + (buttonWidth / 2);

    _navScrollController.animateTo(
      targetOffset.clamp(0, _navScrollController.position.maxScrollExtent),
      duration: AppConstants.defaultAnimationDuration,
      curve: Curves.easeInOut,
    );
  }

  /// 섹션 버튼 클릭 시 해당 섹션으로 스크롤
  Future<void> _scrollToSection(int index) async {
    final key = _sectionKeys[index];
    final ctx = key.currentContext;

    if (ctx == null) return;

    _isProgrammaticScroll = true;
    _selectedSectionIndex.value = index;

    // CustomScrollView에서는 Scrollable.ensureVisible이 정상 동작
    await Scrollable.ensureVisible(
      ctx,
      duration: AppConstants.scrollAnimationDuration,
      curve: Curves.easeInOut,
    );

    await Future<void>.delayed(AppConstants.mockDelayShort);
    _isProgrammaticScroll = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FavoriteProvider>(
        builder: (context, provider, child) {
          final priceUpdate = provider.getPriceUpdate(widget.stockCode);
          final currentPrice = priceUpdate?.currentPrice ?? 0;
          final changeRate = priceUpdate?.changeRate ?? 0.0;
          final savedItem = provider.favoriteList
              .where((i) => i.stockCode == widget.stockCode)
              .firstOrNull;

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              // AppBar
              SliverAppBar(
                pinned: true,
                expandedHeight: 80,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                foregroundColor: Colors.black,
                elevation: 0,
                title: Row(
                  children: [
                    // 종목 로고 (placeholder)
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          widget.stockName.isNotEmpty ? widget.stockName[0] : '?',
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // 종목명 & 코드
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.stockName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.stockCode,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      savedItem != null ? Icons.favorite : Icons.favorite_border,
                      color: savedItem != null ? Colors.red : null,
                    ),
                    onPressed: () => _handleToggleFavorite(
                      context,
                      provider,
                      savedItem,
                    ),
                  ),
                ],
              ),
              // 섹션 네비게이션 (Pinned)
              SliverPersistentHeader(
                pinned: true,
                delegate: _SectionNavigationDelegate(
                  child: ValueListenableBuilder<int>(
                    valueListenable: _selectedSectionIndex,
                    builder: (context, selectedIndex, _) {
                      return SectionNavigationWidget(
                        sectionNames: _sectionNames,
                        selectedIndex: selectedIndex,
                        onSectionTap: _scrollToSection,
                        scrollController: _navScrollController,
                      );
                    },
                  ),
                ),
              ),
              // 섹션 0: 가격
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[0],
                  child: PriceChartWidget(
                    currentPrice: currentPrice,
                    changeRate: changeRate,
                  ),
                ),
              ),
              // 섹션 1: 요약
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[1],
                  child: SummarySectionWidget(
                    stockCode: widget.stockCode,
                    stockName: widget.stockName,
                    currentPrice: currentPrice,
                    changeRate: changeRate,
                  ),
                ),
              ),
              // 섹션 2: 입력
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[2],
                  child: InputSectionWidget(
                    currentTargetPrice: _targetPrice,
                    currentAlertType: _alertType,
                    onTargetPriceChanged: (value) {
                      setState(() {
                        _targetPrice = value;
                      });
                    },
                    onAlertTypeChanged: (value) {
                      setState(() {
                        _alertType = value;
                      });
                    },
                    onSave: _saveTargetPrice,
                    isSaving: _isSaving,
                    savedTargetPrice: savedItem?.targetPrice,
                    savedAlertType: savedItem?.alertType,
                    onDeleteSavedAlert: () => _deleteSavedAlert(provider),
                  ),
                ),
              ),
              // 섹션 3: 확장 패널
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[3],
                  child: const ExpansionSectionWidget(),
                ),
              ),
              // 섹션 4: 뉴스
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[4],
                  child: const NewsSectionWidget(),
                ),
              ),
              // 섹션 5: 재무
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[5],
                  child: const FinanceSectionWidget(),
                ),
              ),
              // 섹션 6: 기타
              SliverToBoxAdapter(
                child: Container(
                  key: _sectionKeys[6],
                  child: const OtherSectionWidget(),
                ),
              ),
              // 하단 여백
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// 섹션 네비게이션 Persistent Header Delegate
class _SectionNavigationDelegate extends SliverPersistentHeaderDelegate {
  _SectionNavigationDelegate({required this.child});

  final Widget child;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant _SectionNavigationDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}

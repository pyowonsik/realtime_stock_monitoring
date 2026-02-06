import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_stock_monitoring/core/constants/app_constants.dart';
import 'package:realtime_stock_monitoring/feature/favorite/domain/entity/favorite_item.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/provider/favorite_provider.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/widget/widget.dart';

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

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _navScrollController = ScrollController();

    // 가격 스트림 구독
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final favoriteProvider = context.read<FavoriteProvider>()
        ..subscribeToPriceUpdates(widget.stockCode);

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

  @override
  void dispose() {
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

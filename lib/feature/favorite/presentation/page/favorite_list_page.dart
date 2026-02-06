import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_stock_monitoring/feature/favorite/domain/entity/favorite_item.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/page/favorite_detail_page.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/provider/favorite_provider.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/provider/favorite_state.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/widget/favorite_item_widget.dart';
import 'package:realtime_stock_monitoring/shared/domain/entity/price_update.dart';
import 'package:realtime_stock_monitoring/shared/presentation/widgets/widgets.dart';

/// 관심 종목 목록 페이지
class FavoriteListPage extends StatefulWidget {
  const FavoriteListPage({super.key});

  @override
  State<FavoriteListPage> createState() => _FavoriteListPageState();
}

class _FavoriteListPageState extends State<FavoriteListPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, provider, child) {
        // Switch 패턴 매칭으로 상태 처리
        return switch (provider.state) {
          FavoriteInitial() => const Center(child: CircularProgressIndicator()),
          FavoriteLoading() => const Center(child: CircularProgressIndicator()),
          FavoriteError(message: final message) => ErrorViewWidget(
              message: message,
              onRetry: provider.loadFavoriteList,
            ),
          FavoriteLoaded(
            favoriteList: final favoriteList,
            priceUpdates: final priceUpdates,
          ) =>
            _buildFavoriteList(
              provider: provider,
              favoriteList: favoriteList,
              priceUpdates: priceUpdates,
            ),
        };
      },
    );
  }

  Widget _buildFavoriteList({
    required FavoriteProvider provider,
    required List<FavoriteItem> favoriteList,
    required Map<String, PriceUpdate> priceUpdates,
  }) {
    if (favoriteList.isEmpty) {
      return EmptyStateWidget.noFavorites();
    }

    // 검색어로 필터링
    final filteredFavorites = favoriteList.where((item) {
      if (_searchQuery.isEmpty) return true;
      final query = _searchQuery.toLowerCase();
      return item.stockCode.toLowerCase().contains(query) ||
          item.stockName.toLowerCase().contains(query);
    }).toList();

    return Column(
      children: [
        // 검색바
        Padding(
          padding: const EdgeInsets.all(16),
          child: SearchTextField(
            controller: _searchController,
            hintText: '종목명 또는 종목코드 검색',
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
        // 결과 목록
        Expanded(
          child: filteredFavorites.isEmpty
              ? EmptyStateWidget.noSearchResults()
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredFavorites.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final item = filteredFavorites[index];
                    final priceUpdate =
                        provider.getPriceUpdate(item.stockCode);

                    return FavoriteItemWidget(
                      item: item,
                      currentPrice: priceUpdate?.currentPrice,
                      changeRate: priceUpdate?.changeRate,
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) =>
                                ChangeNotifierProvider.value(
                              value: provider,
                              child: FavoriteDetailPage(
                                stockCode: item.stockCode,
                                stockName: item.stockName,
                                logoUrl: item.logoUrl,
                              ),
                            ),
                          ),
                        );
                      },
                      onDelete: () => _handleDelete(context, provider, item),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Future<void> _handleDelete(
    BuildContext context,
    FavoriteProvider provider,
    FavoriteItem favoriteItem,
  ) async {
    final confirm = await showConfirmDialog(
      context: context,
      title: '관심 종목 삭제',
      content: '${favoriteItem.stockName}을(를) 삭제하시겠습니까?',
      confirmText: '삭제',
      confirmTextColor: Colors.red,
    );

    if (confirm && context.mounted) {
      await provider.deleteFavoriteItem(favoriteItem.stockCode);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${favoriteItem.stockName}을(를) 삭제했습니다')),
        );
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_item/feature/favorite/domain/entity/favorite_item.dart';
import 'package:realtime_item/feature/favorite/presentation/provider/favorite_provider.dart';
import 'package:realtime_item/feature/favorite/presentation/provider/favorite_state.dart';
import 'package:realtime_item/feature/stock/domain/entity/stock.dart';
import 'package:realtime_item/feature/stock/presentation/provider/stock_provider.dart';
import 'package:realtime_item/feature/stock/presentation/provider/stock_state.dart';
import 'package:realtime_item/feature/stock/presentation/widget/stock_list_item_widget.dart';
import 'package:realtime_item/shared/presentation/widgets/widgets.dart';

/// 전체 종목 목록 페이지
class StockListPage extends StatefulWidget {
  const StockListPage({
    super.key,
    this.onAddToFavorite,
  });

  final VoidCallback? onAddToFavorite;

  @override
  State<StockListPage> createState() => _StockListPageState();
}

class _StockListPageState extends State<StockListPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<StockProvider, FavoriteProvider>(
      builder: (context, stockProvider, favoriteProvider, child) {
        // Switch 패턴 매칭으로 상태 처리
        return switch (stockProvider.state) {
          StockInitial() => const Center(child: CircularProgressIndicator()),
          StockLoading() => const Center(child: CircularProgressIndicator()),
          StockError(message: final message) => ErrorViewWidget(
              message: message,
              onRetry: stockProvider.loadStocks,
            ),
          StockLoaded(stocks: final stocks) => _buildStockList(
              stocks: stocks,
              favoriteProvider: favoriteProvider,
            ),
        };
      },
    );
  }

  Widget _buildStockList({
    required List<Stock> stocks,
    required FavoriteProvider favoriteProvider,
  }) {
    // 관심 종목 코드 추출 (switch 패턴 매칭)
    final favoriteCodes = switch (favoriteProvider.state) {
      FavoriteLoaded(favoriteList: final list) =>
        list.map((e) => e.stockCode).toSet(),
      FavoriteError(favoriteList: final list) =>
        list?.map((e) => e.stockCode).toSet() ?? <String>{},
      _ => <String>{},
    };

    // 검색어로 필터링
    final filteredStocks = stocks.where((stock) {
      if (_searchQuery.isEmpty) return true;
      final query = _searchQuery.toLowerCase();
      return stock.stockCode.toLowerCase().contains(query) ||
          stock.stockName.toLowerCase().contains(query);
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
          child: filteredStocks.isEmpty
              ? EmptyStateWidget.noSearchResults()
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredStocks.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final stock = filteredStocks[index];
                    final isInFavorite =
                        favoriteCodes.contains(stock.stockCode);

                    return StockListItemWidget(
                      stock: stock,
                      isInFavorite: isInFavorite,
                      onAddToFavorite: () => _handleToggleFavorite(
                        context,
                        favoriteProvider,
                        stock.stockCode,
                        stock.stockName,
                        isInFavorite,
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Future<void> _handleToggleFavorite(
    BuildContext context,
    FavoriteProvider provider,
    String stockCode,
    String stockName,
    bool isInFavorite,
  ) async {
    try {
      if (isInFavorite) {
        // 관심 종목에서 삭제
        await provider.deleteFavoriteItem(stockCode);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$stockName을(를) 관심 종목에서 삭제했습니다')),
          );
        }
      } else {
        // 관심 종목에 추가
        final item = FavoriteItem(
          stockCode: stockCode,
          stockName: stockName,
          alertType: AlertType.both,
          createdAt: DateTime.now(),
        );
        await provider.addFavoriteItem(item);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$stockName을(를) 관심 종목에 추가했습니다')),
          );
          widget.onAddToFavorite?.call();
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
}

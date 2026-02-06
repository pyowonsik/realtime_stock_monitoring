import 'package:flutter/material.dart';
import 'package:realtime_item/feature/stock/domain/entity/stock.dart';

/// 종목 리스트 아이템 위젯
class StockListItemWidget extends StatelessWidget {
  const StockListItemWidget({
    required this.stock,
    required this.isInFavorite,
    required this.onAddToFavorite,
    super.key,
  });

  final Stock stock;
  final bool isInFavorite;
  final VoidCallback onAddToFavorite;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              stock.stockName.isNotEmpty ? stock.stockName[0] : '?',
              style: TextStyle(
                color: Colors.blue.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        title: Text(
          stock.stockName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          stock.stockCode,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            isInFavorite ? Icons.favorite : Icons.favorite_border,
            color: isInFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: onAddToFavorite,
        ),
      ),
    );
  }
}

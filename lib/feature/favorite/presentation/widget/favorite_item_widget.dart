import 'package:flutter/material.dart';
import 'package:realtime_item/core/utils/price_formatter.dart';
import 'package:realtime_item/feature/favorite/domain/entity/favorite_item.dart';

/// 관심 종목 리스트 아이템 위젯
class FavoriteItemWidget extends StatelessWidget {
  const FavoriteItemWidget({
    required this.item,
    required this.onTap,
    required this.onDelete,
    super.key,
    this.currentPrice,
    this.changeRate,
  });

  final FavoriteItem item;
  final int? currentPrice;
  final double? changeRate;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final isPositive = (changeRate ?? 0) >= 0;

    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              item.stockName.isNotEmpty ? item.stockName[0] : '?',
              style: TextStyle(
                color: Colors.blue.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        title: Text(
          item.stockName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Row(
          children: [
            Text(
              item.stockCode,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
            if (currentPrice != null) ...[
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  '${PriceFormatter.formatPrice(currentPrice!)} ${PriceFormatter.formatChangeRate(changeRate ?? 0)}',
                  style: TextStyle(
                    color: isPositive ? Colors.red : Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.grey),
              onPressed: onDelete,
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

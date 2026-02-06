import 'package:flutter/material.dart';
import 'package:realtime_item/core/utils/alert_type_extension.dart';
import 'package:realtime_item/core/utils/date_formatter.dart';
import 'package:realtime_item/core/utils/price_formatter.dart';
import 'package:realtime_item/feature/alert/domain/entity/alert_history_item.dart';

/// 알림 히스토리 아이템 위젯
class AlertHistoryItemWidget extends StatelessWidget {
  const AlertHistoryItemWidget({
    required this.item,
    required this.onDelete,
    super.key,
  });

  final AlertHistoryItem item;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final alertTypeText = item.alertType.breachText;
    final priceColor =
        item.triggeredPrice >= item.targetPrice ? Colors.red : Colors.blue;

    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onDelete(),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // 종목 아이콘
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.notifications_active,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              // 알림 정보
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          item.stockName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: priceColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            alertTypeText,
                            style: TextStyle(
                              fontSize: 10,
                              color: priceColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '목표가: ${PriceFormatter.formatPriceWithComma(item.targetPrice)}원',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      '도달가: ${PriceFormatter.formatPriceWithComma(item.triggeredPrice)}원',
                      style: TextStyle(
                        fontSize: 13,
                        color: priceColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // 시간
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    DateFormatter.formatDate(item.triggeredAt),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  Text(
                    DateFormatter.formatTime(item.triggeredAt),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}

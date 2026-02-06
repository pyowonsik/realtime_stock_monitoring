import 'package:flutter/material.dart';
import 'package:realtime_item/core/utils/alert_type_extension.dart';
import 'package:realtime_item/core/utils/price_formatter.dart';
import 'package:realtime_item/feature/favorite/domain/entity/favorite_item.dart';

/// 저장된 알림 타일 위젯
class SavedAlertTileWidget extends StatelessWidget {
  const SavedAlertTileWidget({
    required this.targetPrice,
    required this.alertType,
    super.key,
    this.onDelete,
  });

  final int targetPrice;
  final AlertType alertType;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final alertTypeText = alertType.shortText;
    final alertColor = alertType.color;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: alertColor.withAlpha(25),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              alertTypeText,
              style: TextStyle(
                color: alertColor,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '목표가 ${PriceFormatter.formatPrice(targetPrice)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: Colors.grey.shade500,
              size: 20,
            ),
            onPressed: onDelete,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

}

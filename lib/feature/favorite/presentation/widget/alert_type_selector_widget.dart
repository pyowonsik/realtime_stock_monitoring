import 'package:flutter/material.dart';
import 'package:realtime_stock_monitoring/feature/favorite/domain/entity/favorite_item.dart';

/// 알림 조건 선택 위젯
class AlertTypeSelectorWidget extends StatelessWidget {
  const AlertTypeSelectorWidget({
    required this.currentAlertType,
    required this.onAlertTypeChanged,
    super.key,
  });

  final AlertType currentAlertType;
  final ValueChanged<AlertType> onAlertTypeChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AlertTypeChipWidget(
          label: '상한가',
          icon: Icons.trending_up,
          isSelected: currentAlertType == AlertType.upper,
          onTap: () => onAlertTypeChanged(AlertType.upper),
          color: Colors.red,
        ),
        const SizedBox(width: 8),
        AlertTypeChipWidget(
          label: '하한가',
          icon: Icons.trending_down,
          isSelected: currentAlertType == AlertType.lower,
          onTap: () => onAlertTypeChanged(AlertType.lower),
          color: Colors.blue,
        ),
        const SizedBox(width: 8),
        AlertTypeChipWidget(
          label: '양방향',
          icon: Icons.swap_vert,
          isSelected: currentAlertType == AlertType.both,
          onTap: () => onAlertTypeChanged(AlertType.both),
          color: Colors.purple,
        ),
      ],
    );
  }
}

/// 알림 타입 칩 위젯
class AlertTypeChipWidget extends StatelessWidget {
  const AlertTypeChipWidget({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.color,
    super.key,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? color.withAlpha(25) : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? color : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? color : Colors.grey,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? color : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

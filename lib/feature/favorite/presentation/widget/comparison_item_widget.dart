import 'package:flutter/material.dart';

/// 동종 업계 비교 아이템 위젯
class ComparisonItemWidget extends StatelessWidget {
  const ComparisonItemWidget({
    required this.company,
    required this.price,
    required this.change,
    super.key,
  });

  final String company;
  final String price;
  final String change;

  @override
  Widget build(BuildContext context) {
    final isPositive = change.startsWith('+');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              company,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              price,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 60,
            child: Text(
              change,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13,
                color: isPositive ? Colors.red : Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

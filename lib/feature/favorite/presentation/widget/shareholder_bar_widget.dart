import 'package:flutter/material.dart';

/// 주주 데이터 클래스
class ShareholderData {
  const ShareholderData(this.name, this.percentage, this.color);

  final String name;
  final double percentage;
  final Color color;
}

/// 주주 구성 바 위젯
class ShareholderBarWidget extends StatelessWidget {
  const ShareholderBarWidget({
    required this.shareholders,
    super.key,
  });

  final List<ShareholderData> shareholders;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Row(
            children: shareholders.map((s) {
              return Expanded(
                flex: (s.percentage * 10).round(),
                child: Container(
                  height: 24,
                  color: s.color,
                  alignment: Alignment.center,
                  child: Text(
                    '${s.percentage}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: shareholders.map((s) {
            return Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: s.color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  s.name,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}

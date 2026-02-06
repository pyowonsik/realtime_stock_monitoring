import 'package:flutter/material.dart';

/// 빈 상태 위젯 (검색 결과 없음, 데이터 없음 등)
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    required this.icon,
    required this.title,
    super.key,
    this.subtitle,
  });

  /// 검색 결과 없음 팩토리
  factory EmptyStateWidget.noSearchResults() {
    return const EmptyStateWidget(
      icon: Icons.search_off,
      title: '검색 결과가 없습니다',
    );
  }

  /// 관심 종목 없음 팩토리
  factory EmptyStateWidget.noFavorites() {
    return const EmptyStateWidget(
      icon: Icons.favorite_border,
      title: '관심 종목이 없습니다',
      subtitle: '전체 종목 탭에서 추가해주세요',
    );
  }

  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

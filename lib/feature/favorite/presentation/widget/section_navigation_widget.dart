import 'package:flutter/material.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/widget/navigation_button_widget.dart';

/// 섹션 네비게이션 버튼 위젯
class SectionNavigationWidget extends StatelessWidget {
  const SectionNavigationWidget({
    required this.sectionNames,
    required this.selectedIndex,
    required this.onSectionTap,
    super.key,
    this.scrollController,
  });

  final List<String> sectionNames;
  final int selectedIndex;
  final ValueChanged<int> onSectionTap;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: sectionNames.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return NavigationButtonWidget(
            label: sectionNames[index],
            isSelected: isSelected,
            onTap: () => onSectionTap(index),
          );
        },
      ),
    );
  }
}

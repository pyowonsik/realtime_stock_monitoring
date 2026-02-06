import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_item/feature/alert/presentation/provider/alert_provider.dart';
import 'package:realtime_item/feature/alert/presentation/widget/alert_history_item_widget.dart';
import 'package:realtime_item/shared/presentation/widgets/confirm_dialog.dart';

/// 알림 히스토리 페이지
class AlertHistoryPage extends StatelessWidget {
  const AlertHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림 히스토리'),
        actions: [
          Consumer<AlertProvider>(
            builder: (context, provider, _) {
              if (provider.alertHistory.isEmpty) return const SizedBox.shrink();
              return TextButton(
                onPressed: () => _showClearConfirmDialog(context, provider),
                child: const Text(
                  '전체 삭제',
                  style: TextStyle(color: Colors.red),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<AlertProvider>(
        builder: (context, provider, child) {
          final history = provider.alertHistory;

          if (history.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '알림 히스토리가 없습니다',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '목표가에 도달하면 알림이 기록됩니다',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: history.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = history[index];
              return AlertHistoryItemWidget(
                item: item,
                onDelete: () => provider.deleteAlertHistory(item.id),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _showClearConfirmDialog(
    BuildContext context,
    AlertProvider provider,
  ) async {
    final confirm = await showConfirmDialog(
      context: context,
      title: '전체 삭제',
      content: '모든 알림 히스토리를 삭제하시겠습니까?',
      confirmText: '삭제',
      confirmTextColor: Colors.red,
    );

    if (confirm) {
      await provider.clearAlertHistory();
    }
  }
}

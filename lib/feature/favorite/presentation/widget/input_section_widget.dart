import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realtime_stock_monitoring/feature/favorite/domain/entity/favorite_item.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/widget/alert_type_selector_widget.dart';
import 'package:realtime_stock_monitoring/feature/favorite/presentation/widget/saved_alert_tile_widget.dart';

/// 입력 섹션 위젯 (목표가 설정)
class InputSectionWidget extends StatefulWidget {
  const InputSectionWidget({
    required this.currentAlertType,
    required this.onTargetPriceChanged,
    required this.onAlertTypeChanged,
    super.key,
    this.currentTargetPrice,
    this.onSave,
    this.isSaving = false,
    this.savedTargetPrice,
    this.savedAlertType,
    this.onDeleteSavedAlert,
  });

  final int? currentTargetPrice;
  final AlertType currentAlertType;
  final ValueChanged<int?> onTargetPriceChanged;
  final ValueChanged<AlertType> onAlertTypeChanged;
  final VoidCallback? onSave;
  final bool isSaving;
  final int? savedTargetPrice;
  final AlertType? savedAlertType;
  final VoidCallback? onDeleteSavedAlert;

  @override
  State<InputSectionWidget> createState() => _InputSectionWidgetState();
}

class _InputSectionWidgetState extends State<InputSectionWidget> {
  late TextEditingController _targetPriceController;

  @override
  void initState() {
    super.initState();
    _targetPriceController = TextEditingController(
      text: widget.currentTargetPrice?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _targetPriceController.dispose();
    super.dispose();
  }

  String _getAlertDescription() {
    switch (widget.currentAlertType) {
      case AlertType.upper:
        return '현재가가 목표가 이상이 되면 알림을 받습니다.';
      case AlertType.lower:
        return '현재가가 목표가 이하가 되면 알림을 받습니다.';
      case AlertType.both:
        return '현재가가 목표가에 도달하면 알림을 받습니다.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '목표가 설정',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // 목표가 입력
            TextField(
              controller: _targetPriceController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                labelText: '목표가',
                hintText: '목표 가격을 입력하세요',
                suffixText: '원',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.price_change),
              ),
              onChanged: (value) {
                final price = int.tryParse(value);
                widget.onTargetPriceChanged(price);
              },
            ),
            const SizedBox(height: 16),
            // 알림 조건 선택
            const Text(
              '알림 조건',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            AlertTypeSelectorWidget(
              currentAlertType: widget.currentAlertType,
              onAlertTypeChanged: widget.onAlertTypeChanged,
            ),
            const SizedBox(height: 16),
            // 설명
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue.shade700),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _getAlertDescription(),
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // 저장 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.isSaving || widget.currentTargetPrice == null
                    ? null
                    : widget.onSave,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: widget.isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text(
                        '목표가 저장',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            // 저장된 알림 설정
            if (widget.savedTargetPrice != null) ...[
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.notifications,
                    size: 18,
                    color: Colors.green.shade700,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '저장된 알림',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SavedAlertTileWidget(
                targetPrice: widget.savedTargetPrice!,
                alertType: widget.savedAlertType ?? AlertType.upper,
                onDelete: widget.onDeleteSavedAlert,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

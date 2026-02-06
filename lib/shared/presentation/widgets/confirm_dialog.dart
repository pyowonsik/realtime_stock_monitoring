import 'package:flutter/material.dart';

/// 확인 다이얼로그 표시 유틸리티
Future<bool> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  String cancelText = '취소',
  String confirmText = '확인',
  Color? confirmTextColor,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(
            confirmText,
            style: confirmTextColor != null
                ? TextStyle(color: confirmTextColor)
                : null,
          ),
        ),
      ],
    ),
  );

  return result ?? false;
}

/// 날짜/시간 포맷팅 유틸리티
class DateFormatter {
  DateFormatter._();

  /// 날짜 포맷팅 (M/d 형식)
  static String formatDate(DateTime dateTime) {
    return '${dateTime.month}/${dateTime.day}';
  }

  /// 시간 포맷팅 (HH:mm 형식)
  static String formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// 날짜+시간 포맷팅 (M/d HH:mm 형식)
  static String formatDateTime(DateTime dateTime) {
    return '${formatDate(dateTime)} ${formatTime(dateTime)}';
  }
}

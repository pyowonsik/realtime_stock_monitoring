/// 가격 포맷팅 유틸리티
abstract final class PriceFormatter {
  // 정규식 캐싱 (성능 최적화)
  static final RegExp _commaPattern = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

  /// 가격을 콤마와 원화 단위로 포맷팅
  /// 예: 50000 -> "50,000원"
  static String formatPrice(int price) {
    return '${price.toString().replaceAllMapped(
          _commaPattern,
          (Match m) => '${m[1]},',
        )}원';
  }

  /// 가격을 콤마만 포함하여 포맷팅 (원화 단위 없음)
  /// 예: 50000 -> "50,000"
  static String formatPriceWithComma(int price) {
    return price.toString().replaceAllMapped(
          _commaPattern,
          (Match m) => '${m[1]},',
        );
  }

  /// 가격을 축약형으로 포맷팅 (만원 단위)
  /// 예: 50000 -> "5.0만", 5000 -> "5000"
  static String formatPriceShort(int price) {
    if (price >= 10000) {
      return '${(price / 10000).toStringAsFixed(1)}만';
    }
    return price.toString();
  }

  /// 변동률을 포맷팅
  /// 예: 2.5 -> "+2.50%", -1.2 -> "-1.20%"
  static String formatChangeRate(double rate) {
    final prefix = rate >= 0 ? '+' : '';
    return '$prefix${rate.toStringAsFixed(2)}%';
  }
}

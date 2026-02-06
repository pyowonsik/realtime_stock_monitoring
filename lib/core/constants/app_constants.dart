/// 앱에서 사용하는 상수 정의
abstract final class AppConstants {
  /// 앱 이름
  static const String appName = '실시간 종목 모니터링';

  /// 실시간 가격 업데이트 주기
  static const Duration priceUpdateInterval = Duration(seconds: 1);

  /// 기본 애니메이션 지속 시간
  static const Duration defaultAnimationDuration = Duration(milliseconds: 200);

  /// 스크롤 애니메이션 지속 시간
  static const Duration scrollAnimationDuration = Duration(milliseconds: 300);

  /// Mock 데이터 지연 시간
  static const Duration mockDelay = Duration(milliseconds: 100);
  static const Duration mockDelayShort = Duration(milliseconds: 50);
}

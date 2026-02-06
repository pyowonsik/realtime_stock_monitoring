import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:realtime_stock_monitoring/core/utils/price_formatter.dart';

/// 로컬 알림 서비스
class NotificationService {
  factory NotificationService() => _instance;

  NotificationService._internal();

  static final NotificationService _instance = NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  /// 알림 서비스 초기화
  Future<void> initialize() async {
    if (_isInitialized) return;

    // Android 설정
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS 설정
    const iosSettings = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Android 13+ 권한 요청
    await _requestPermissions();

    _isInitialized = true;
  }

  /// 권한 요청
  Future<void> _requestPermissions() async {
    // Android
    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // iOS
    await _notifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  /// 알림 클릭 핸들러
  void _onNotificationTapped(NotificationResponse response) {
    // 필요시 알림 클릭 시 동작 구현
  }

  /// 목표가 도달 알림 표시
  Future<void> showTargetPriceAlert({
    required String stockName,
    required String stockCode,
    required int currentPrice,
    required int targetPrice,
    required String alertType,
  }) async {
    final formattedCurrentPrice = PriceFormatter.formatPrice(currentPrice);
    final formattedTargetPrice = PriceFormatter.formatPrice(targetPrice);

    const androidDetails = AndroidNotificationDetails(
      'target_price_channel',
      '목표가 알림',
      channelDescription: '목표가 도달 시 알림을 받습니다',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      '🔔 목표가 도달: $stockName',
      '현재가 $formattedCurrentPrice | 목표가 $formattedTargetPrice ($alertType)',
      details,
    );
  }
}

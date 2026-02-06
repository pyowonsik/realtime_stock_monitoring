import 'package:flutter/widgets.dart';

/// 앱 라이프사이클 상태 관리 서비스
class AppLifecycleService with WidgetsBindingObserver {
  factory AppLifecycleService() => _instance;

  AppLifecycleService._internal();

  static final AppLifecycleService _instance = AppLifecycleService._internal();

  AppLifecycleState _state = AppLifecycleState.resumed;

  /// 현재 앱 라이프사이클 상태
  AppLifecycleState get state => _state;

  /// 앱이 포그라운드에 있는지 여부
  bool get isForeground => _state == AppLifecycleState.resumed;

  /// 앱이 백그라운드에 있는지 여부
  bool get isBackground =>
      _state == AppLifecycleState.paused ||
      _state == AppLifecycleState.inactive ||
      _state == AppLifecycleState.detached;

  /// 서비스 초기화
  void initialize() {
    WidgetsBinding.instance.addObserver(this);
  }

  /// 서비스 해제
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _state = state;
  }
}

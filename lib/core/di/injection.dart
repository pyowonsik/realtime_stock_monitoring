import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:realtime_item/core/constants/hive_type_ids.dart';
import 'package:realtime_item/core/services/notification_service.dart';
import 'package:realtime_item/feature/alert/data/model/alert_history_model.dart';
import 'package:realtime_item/feature/alert/di/alert_injection.dart';
import 'package:realtime_item/feature/favorite/data/model/favorite_item_model.dart';
import 'package:realtime_item/feature/favorite/di/favorite_injection.dart';
import 'package:realtime_item/feature/stock/di/stock_injection.dart';

final GetIt getIt = GetIt.instance;

/// 앱 초기화 및 의존성 주입 설정
Future<void> initializeDependencies() async {
  try {
    // Hive 초기화
    await Hive.initFlutter();

    // Hive Adapter 등록
    _registerHiveAdapters();

    // 알림 서비스 초기화 및 등록
    final notificationService = NotificationService();
    await notificationService.initialize();
    getIt.registerSingleton<NotificationService>(notificationService);

    // Feature 의존성 등록 (순서 중요: notification -> stock -> favorite)
    registerAlertDependencies(getIt);
    registerStockDependencies(getIt);
    registerFavoriteDependencies(getIt);
  } on Exception catch (e, stackTrace) {
    debugPrint('의존성 초기화 실패: $e');
    debugPrint('$stackTrace');
    rethrow;
  }
}

/// Hive Adapter 등록
void _registerHiveAdapters() {
  try {
    if (!Hive.isAdapterRegistered(HiveTypeIds.favoriteItemModel)) {
      Hive.registerAdapter(FavoriteItemModelAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTypeIds.alertHistoryModel)) {
      Hive.registerAdapter(AlertHistoryModelAdapter());
    }
  } on Exception catch (e) {
    debugPrint('Hive Adapter 등록 실패: $e');
    rethrow;
  }
}

/// 의존성 정리
Future<void> disposeDependencies() async {
  await getIt.reset();
}

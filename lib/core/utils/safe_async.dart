import 'dart:async';

import 'package:flutter/foundation.dart';

/// 비동기 작업을 안전하게 실행하고 에러를 로깅합니다.
/// 에러가 발생해도 앱이 크래시되지 않습니다.
void safeAsync(
  Future<void> Function() action, {
  String? context,
}) {
  unawaited(
    action().catchError((Object error, StackTrace stackTrace) {
      final contextMessage = context != null ? '[$context] ' : '';
      debugPrint('$contextMessage비동기 작업 실패: $error');
      debugPrint('$stackTrace');
    }),
  );
}

/// Future를 안전하게 실행하고 에러를 로깅합니다.
void safeFuture(
  Future<void>? future, {
  String? context,
}) {
  if (future == null) return;

  unawaited(
    future.catchError((Object error, StackTrace stackTrace) {
      final contextMessage = context != null ? '[$context] ' : '';
      debugPrint('$contextMessage비동기 작업 실패: $error');
      debugPrint('$stackTrace');
    }),
  );
}

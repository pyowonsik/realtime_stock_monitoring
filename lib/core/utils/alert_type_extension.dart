import 'package:flutter/material.dart';
import 'package:realtime_item/feature/favorite/domain/entity/favorite_item.dart';

/// AlertType 확장 메서드
extension AlertTypeExtension on AlertType {
  /// 알림 타입 텍스트 (돌파 표현)
  String get breachText => switch (this) {
        AlertType.upper => '상향 돌파',
        AlertType.lower => '하향 돌파',
        AlertType.both => '목표가 도달',
      };

  /// 알림 타입 텍스트 (짧은 표현)
  String get shortText => switch (this) {
        AlertType.upper => '상한가',
        AlertType.lower => '하한가',
        AlertType.both => '양방향',
      };

  /// 알림 타입 색상
  Color get color => switch (this) {
        AlertType.upper => Colors.red,
        AlertType.lower => Colors.blue,
        AlertType.both => Colors.purple,
      };
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alert_history_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AlertHistoryItem _$AlertHistoryItemFromJson(Map<String, dynamic> json) {
  return _AlertHistoryItem.fromJson(json);
}

/// @nodoc
mixin _$AlertHistoryItem {
  String get id => throw _privateConstructorUsedError;
  String get stockCode => throw _privateConstructorUsedError;
  String get stockName => throw _privateConstructorUsedError;
  int get targetPrice => throw _privateConstructorUsedError;
  int get triggeredPrice => throw _privateConstructorUsedError;
  AlertType get alertType => throw _privateConstructorUsedError;
  DateTime get triggeredAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlertHistoryItemCopyWith<AlertHistoryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertHistoryItemCopyWith<$Res> {
  factory $AlertHistoryItemCopyWith(
          AlertHistoryItem value, $Res Function(AlertHistoryItem) then) =
      _$AlertHistoryItemCopyWithImpl<$Res, AlertHistoryItem>;
  @useResult
  $Res call(
      {String id,
      String stockCode,
      String stockName,
      int targetPrice,
      int triggeredPrice,
      AlertType alertType,
      DateTime triggeredAt});
}

/// @nodoc
class _$AlertHistoryItemCopyWithImpl<$Res, $Val extends AlertHistoryItem>
    implements $AlertHistoryItemCopyWith<$Res> {
  _$AlertHistoryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? stockCode = null,
    Object? stockName = null,
    Object? targetPrice = null,
    Object? triggeredPrice = null,
    Object? alertType = null,
    Object? triggeredAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      stockCode: null == stockCode
          ? _value.stockCode
          : stockCode // ignore: cast_nullable_to_non_nullable
              as String,
      stockName: null == stockName
          ? _value.stockName
          : stockName // ignore: cast_nullable_to_non_nullable
              as String,
      targetPrice: null == targetPrice
          ? _value.targetPrice
          : targetPrice // ignore: cast_nullable_to_non_nullable
              as int,
      triggeredPrice: null == triggeredPrice
          ? _value.triggeredPrice
          : triggeredPrice // ignore: cast_nullable_to_non_nullable
              as int,
      alertType: null == alertType
          ? _value.alertType
          : alertType // ignore: cast_nullable_to_non_nullable
              as AlertType,
      triggeredAt: null == triggeredAt
          ? _value.triggeredAt
          : triggeredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlertHistoryItemImplCopyWith<$Res>
    implements $AlertHistoryItemCopyWith<$Res> {
  factory _$$AlertHistoryItemImplCopyWith(_$AlertHistoryItemImpl value,
          $Res Function(_$AlertHistoryItemImpl) then) =
      __$$AlertHistoryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String stockCode,
      String stockName,
      int targetPrice,
      int triggeredPrice,
      AlertType alertType,
      DateTime triggeredAt});
}

/// @nodoc
class __$$AlertHistoryItemImplCopyWithImpl<$Res>
    extends _$AlertHistoryItemCopyWithImpl<$Res, _$AlertHistoryItemImpl>
    implements _$$AlertHistoryItemImplCopyWith<$Res> {
  __$$AlertHistoryItemImplCopyWithImpl(_$AlertHistoryItemImpl _value,
      $Res Function(_$AlertHistoryItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? stockCode = null,
    Object? stockName = null,
    Object? targetPrice = null,
    Object? triggeredPrice = null,
    Object? alertType = null,
    Object? triggeredAt = null,
  }) {
    return _then(_$AlertHistoryItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      stockCode: null == stockCode
          ? _value.stockCode
          : stockCode // ignore: cast_nullable_to_non_nullable
              as String,
      stockName: null == stockName
          ? _value.stockName
          : stockName // ignore: cast_nullable_to_non_nullable
              as String,
      targetPrice: null == targetPrice
          ? _value.targetPrice
          : targetPrice // ignore: cast_nullable_to_non_nullable
              as int,
      triggeredPrice: null == triggeredPrice
          ? _value.triggeredPrice
          : triggeredPrice // ignore: cast_nullable_to_non_nullable
              as int,
      alertType: null == alertType
          ? _value.alertType
          : alertType // ignore: cast_nullable_to_non_nullable
              as AlertType,
      triggeredAt: null == triggeredAt
          ? _value.triggeredAt
          : triggeredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlertHistoryItemImpl implements _AlertHistoryItem {
  const _$AlertHistoryItemImpl(
      {required this.id,
      required this.stockCode,
      required this.stockName,
      required this.targetPrice,
      required this.triggeredPrice,
      required this.alertType,
      required this.triggeredAt});

  factory _$AlertHistoryItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlertHistoryItemImplFromJson(json);

  @override
  final String id;
  @override
  final String stockCode;
  @override
  final String stockName;
  @override
  final int targetPrice;
  @override
  final int triggeredPrice;
  @override
  final AlertType alertType;
  @override
  final DateTime triggeredAt;

  @override
  String toString() {
    return 'AlertHistoryItem(id: $id, stockCode: $stockCode, stockName: $stockName, targetPrice: $targetPrice, triggeredPrice: $triggeredPrice, alertType: $alertType, triggeredAt: $triggeredAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertHistoryItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.stockCode, stockCode) ||
                other.stockCode == stockCode) &&
            (identical(other.stockName, stockName) ||
                other.stockName == stockName) &&
            (identical(other.targetPrice, targetPrice) ||
                other.targetPrice == targetPrice) &&
            (identical(other.triggeredPrice, triggeredPrice) ||
                other.triggeredPrice == triggeredPrice) &&
            (identical(other.alertType, alertType) ||
                other.alertType == alertType) &&
            (identical(other.triggeredAt, triggeredAt) ||
                other.triggeredAt == triggeredAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, stockCode, stockName,
      targetPrice, triggeredPrice, alertType, triggeredAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertHistoryItemImplCopyWith<_$AlertHistoryItemImpl> get copyWith =>
      __$$AlertHistoryItemImplCopyWithImpl<_$AlertHistoryItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlertHistoryItemImplToJson(
      this,
    );
  }
}

abstract class _AlertHistoryItem implements AlertHistoryItem {
  const factory _AlertHistoryItem(
      {required final String id,
      required final String stockCode,
      required final String stockName,
      required final int targetPrice,
      required final int triggeredPrice,
      required final AlertType alertType,
      required final DateTime triggeredAt}) = _$AlertHistoryItemImpl;

  factory _AlertHistoryItem.fromJson(Map<String, dynamic> json) =
      _$AlertHistoryItemImpl.fromJson;

  @override
  String get id;
  @override
  String get stockCode;
  @override
  String get stockName;
  @override
  int get targetPrice;
  @override
  int get triggeredPrice;
  @override
  AlertType get alertType;
  @override
  DateTime get triggeredAt;
  @override
  @JsonKey(ignore: true)
  _$$AlertHistoryItemImplCopyWith<_$AlertHistoryItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

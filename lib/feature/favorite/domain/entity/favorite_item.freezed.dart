// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FavoriteItem _$FavoriteItemFromJson(Map<String, dynamic> json) {
  return _FavoriteItem.fromJson(json);
}

/// @nodoc
mixin _$FavoriteItem {
  String get stockCode => throw _privateConstructorUsedError;
  String get stockName => throw _privateConstructorUsedError;
  AlertType get alertType => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  int? get targetPrice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FavoriteItemCopyWith<FavoriteItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteItemCopyWith<$Res> {
  factory $FavoriteItemCopyWith(
          FavoriteItem value, $Res Function(FavoriteItem) then) =
      _$FavoriteItemCopyWithImpl<$Res, FavoriteItem>;
  @useResult
  $Res call(
      {String stockCode,
      String stockName,
      AlertType alertType,
      DateTime createdAt,
      String? logoUrl,
      int? targetPrice});
}

/// @nodoc
class _$FavoriteItemCopyWithImpl<$Res, $Val extends FavoriteItem>
    implements $FavoriteItemCopyWith<$Res> {
  _$FavoriteItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stockCode = null,
    Object? stockName = null,
    Object? alertType = null,
    Object? createdAt = null,
    Object? logoUrl = freezed,
    Object? targetPrice = freezed,
  }) {
    return _then(_value.copyWith(
      stockCode: null == stockCode
          ? _value.stockCode
          : stockCode // ignore: cast_nullable_to_non_nullable
              as String,
      stockName: null == stockName
          ? _value.stockName
          : stockName // ignore: cast_nullable_to_non_nullable
              as String,
      alertType: null == alertType
          ? _value.alertType
          : alertType // ignore: cast_nullable_to_non_nullable
              as AlertType,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      targetPrice: freezed == targetPrice
          ? _value.targetPrice
          : targetPrice // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FavoriteItemImplCopyWith<$Res>
    implements $FavoriteItemCopyWith<$Res> {
  factory _$$FavoriteItemImplCopyWith(
          _$FavoriteItemImpl value, $Res Function(_$FavoriteItemImpl) then) =
      __$$FavoriteItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String stockCode,
      String stockName,
      AlertType alertType,
      DateTime createdAt,
      String? logoUrl,
      int? targetPrice});
}

/// @nodoc
class __$$FavoriteItemImplCopyWithImpl<$Res>
    extends _$FavoriteItemCopyWithImpl<$Res, _$FavoriteItemImpl>
    implements _$$FavoriteItemImplCopyWith<$Res> {
  __$$FavoriteItemImplCopyWithImpl(
      _$FavoriteItemImpl _value, $Res Function(_$FavoriteItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stockCode = null,
    Object? stockName = null,
    Object? alertType = null,
    Object? createdAt = null,
    Object? logoUrl = freezed,
    Object? targetPrice = freezed,
  }) {
    return _then(_$FavoriteItemImpl(
      stockCode: null == stockCode
          ? _value.stockCode
          : stockCode // ignore: cast_nullable_to_non_nullable
              as String,
      stockName: null == stockName
          ? _value.stockName
          : stockName // ignore: cast_nullable_to_non_nullable
              as String,
      alertType: null == alertType
          ? _value.alertType
          : alertType // ignore: cast_nullable_to_non_nullable
              as AlertType,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      targetPrice: freezed == targetPrice
          ? _value.targetPrice
          : targetPrice // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FavoriteItemImpl implements _FavoriteItem {
  const _$FavoriteItemImpl(
      {required this.stockCode,
      required this.stockName,
      required this.alertType,
      required this.createdAt,
      this.logoUrl,
      this.targetPrice});

  factory _$FavoriteItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$FavoriteItemImplFromJson(json);

  @override
  final String stockCode;
  @override
  final String stockName;
  @override
  final AlertType alertType;
  @override
  final DateTime createdAt;
  @override
  final String? logoUrl;
  @override
  final int? targetPrice;

  @override
  String toString() {
    return 'FavoriteItem(stockCode: $stockCode, stockName: $stockName, alertType: $alertType, createdAt: $createdAt, logoUrl: $logoUrl, targetPrice: $targetPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteItemImpl &&
            (identical(other.stockCode, stockCode) ||
                other.stockCode == stockCode) &&
            (identical(other.stockName, stockName) ||
                other.stockName == stockName) &&
            (identical(other.alertType, alertType) ||
                other.alertType == alertType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.targetPrice, targetPrice) ||
                other.targetPrice == targetPrice));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, stockCode, stockName, alertType,
      createdAt, logoUrl, targetPrice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteItemImplCopyWith<_$FavoriteItemImpl> get copyWith =>
      __$$FavoriteItemImplCopyWithImpl<_$FavoriteItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FavoriteItemImplToJson(
      this,
    );
  }
}

abstract class _FavoriteItem implements FavoriteItem {
  const factory _FavoriteItem(
      {required final String stockCode,
      required final String stockName,
      required final AlertType alertType,
      required final DateTime createdAt,
      final String? logoUrl,
      final int? targetPrice}) = _$FavoriteItemImpl;

  factory _FavoriteItem.fromJson(Map<String, dynamic> json) =
      _$FavoriteItemImpl.fromJson;

  @override
  String get stockCode;
  @override
  String get stockName;
  @override
  AlertType get alertType;
  @override
  DateTime get createdAt;
  @override
  String? get logoUrl;
  @override
  int? get targetPrice;
  @override
  @JsonKey(ignore: true)
  _$$FavoriteItemImplCopyWith<_$FavoriteItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

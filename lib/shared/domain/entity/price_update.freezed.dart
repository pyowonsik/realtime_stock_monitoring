// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price_update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PriceUpdate _$PriceUpdateFromJson(Map<String, dynamic> json) {
  return _PriceUpdate.fromJson(json);
}

/// @nodoc
mixin _$PriceUpdate {
  String get stockCode => throw _privateConstructorUsedError;
  int get currentPrice => throw _privateConstructorUsedError;
  double get changeRate => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PriceUpdateCopyWith<PriceUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceUpdateCopyWith<$Res> {
  factory $PriceUpdateCopyWith(
          PriceUpdate value, $Res Function(PriceUpdate) then) =
      _$PriceUpdateCopyWithImpl<$Res, PriceUpdate>;
  @useResult
  $Res call(
      {String stockCode,
      int currentPrice,
      double changeRate,
      DateTime timestamp});
}

/// @nodoc
class _$PriceUpdateCopyWithImpl<$Res, $Val extends PriceUpdate>
    implements $PriceUpdateCopyWith<$Res> {
  _$PriceUpdateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stockCode = null,
    Object? currentPrice = null,
    Object? changeRate = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      stockCode: null == stockCode
          ? _value.stockCode
          : stockCode // ignore: cast_nullable_to_non_nullable
              as String,
      currentPrice: null == currentPrice
          ? _value.currentPrice
          : currentPrice // ignore: cast_nullable_to_non_nullable
              as int,
      changeRate: null == changeRate
          ? _value.changeRate
          : changeRate // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PriceUpdateImplCopyWith<$Res>
    implements $PriceUpdateCopyWith<$Res> {
  factory _$$PriceUpdateImplCopyWith(
          _$PriceUpdateImpl value, $Res Function(_$PriceUpdateImpl) then) =
      __$$PriceUpdateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String stockCode,
      int currentPrice,
      double changeRate,
      DateTime timestamp});
}

/// @nodoc
class __$$PriceUpdateImplCopyWithImpl<$Res>
    extends _$PriceUpdateCopyWithImpl<$Res, _$PriceUpdateImpl>
    implements _$$PriceUpdateImplCopyWith<$Res> {
  __$$PriceUpdateImplCopyWithImpl(
      _$PriceUpdateImpl _value, $Res Function(_$PriceUpdateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stockCode = null,
    Object? currentPrice = null,
    Object? changeRate = null,
    Object? timestamp = null,
  }) {
    return _then(_$PriceUpdateImpl(
      stockCode: null == stockCode
          ? _value.stockCode
          : stockCode // ignore: cast_nullable_to_non_nullable
              as String,
      currentPrice: null == currentPrice
          ? _value.currentPrice
          : currentPrice // ignore: cast_nullable_to_non_nullable
              as int,
      changeRate: null == changeRate
          ? _value.changeRate
          : changeRate // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceUpdateImpl implements _PriceUpdate {
  const _$PriceUpdateImpl(
      {required this.stockCode,
      required this.currentPrice,
      required this.changeRate,
      required this.timestamp});

  factory _$PriceUpdateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceUpdateImplFromJson(json);

  @override
  final String stockCode;
  @override
  final int currentPrice;
  @override
  final double changeRate;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'PriceUpdate(stockCode: $stockCode, currentPrice: $currentPrice, changeRate: $changeRate, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceUpdateImpl &&
            (identical(other.stockCode, stockCode) ||
                other.stockCode == stockCode) &&
            (identical(other.currentPrice, currentPrice) ||
                other.currentPrice == currentPrice) &&
            (identical(other.changeRate, changeRate) ||
                other.changeRate == changeRate) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, stockCode, currentPrice, changeRate, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceUpdateImplCopyWith<_$PriceUpdateImpl> get copyWith =>
      __$$PriceUpdateImplCopyWithImpl<_$PriceUpdateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceUpdateImplToJson(
      this,
    );
  }
}

abstract class _PriceUpdate implements PriceUpdate {
  const factory _PriceUpdate(
      {required final String stockCode,
      required final int currentPrice,
      required final double changeRate,
      required final DateTime timestamp}) = _$PriceUpdateImpl;

  factory _PriceUpdate.fromJson(Map<String, dynamic> json) =
      _$PriceUpdateImpl.fromJson;

  @override
  String get stockCode;
  @override
  int get currentPrice;
  @override
  double get changeRate;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$PriceUpdateImplCopyWith<_$PriceUpdateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

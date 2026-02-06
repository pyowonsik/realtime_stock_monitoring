// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alert_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AlertState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<AlertHistoryItem> alertHistory, Set<String> alertedStocks)
        loaded,
    required TResult Function(String message,
            List<AlertHistoryItem>? alertHistory, Set<String>? alertedStocks)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<AlertHistoryItem> alertHistory, Set<String> alertedStocks)?
        loaded,
    TResult? Function(String message, List<AlertHistoryItem>? alertHistory,
            Set<String>? alertedStocks)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<AlertHistoryItem> alertHistory, Set<String> alertedStocks)?
        loaded,
    TResult Function(String message, List<AlertHistoryItem>? alertHistory,
            Set<String>? alertedStocks)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AlertInitial value) initial,
    required TResult Function(AlertLoading value) loading,
    required TResult Function(AlertLoaded value) loaded,
    required TResult Function(AlertError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AlertInitial value)? initial,
    TResult? Function(AlertLoading value)? loading,
    TResult? Function(AlertLoaded value)? loaded,
    TResult? Function(AlertError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AlertInitial value)? initial,
    TResult Function(AlertLoading value)? loading,
    TResult Function(AlertLoaded value)? loaded,
    TResult Function(AlertError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertStateCopyWith<$Res> {
  factory $AlertStateCopyWith(
          AlertState value, $Res Function(AlertState) then) =
      _$AlertStateCopyWithImpl<$Res, AlertState>;
}

/// @nodoc
class _$AlertStateCopyWithImpl<$Res, $Val extends AlertState>
    implements $AlertStateCopyWith<$Res> {
  _$AlertStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AlertInitialImplCopyWith<$Res> {
  factory _$$AlertInitialImplCopyWith(
          _$AlertInitialImpl value, $Res Function(_$AlertInitialImpl) then) =
      __$$AlertInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AlertInitialImplCopyWithImpl<$Res>
    extends _$AlertStateCopyWithImpl<$Res, _$AlertInitialImpl>
    implements _$$AlertInitialImplCopyWith<$Res> {
  __$$AlertInitialImplCopyWithImpl(
      _$AlertInitialImpl _value, $Res Function(_$AlertInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AlertInitialImpl implements AlertInitial {
  const _$AlertInitialImpl();

  @override
  String toString() {
    return 'AlertState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AlertInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<AlertHistoryItem> alertHistory, Set<String> alertedStocks)
        loaded,
    required TResult Function(String message,
            List<AlertHistoryItem>? alertHistory, Set<String>? alertedStocks)
        error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<AlertHistoryItem> alertHistory, Set<String> alertedStocks)?
        loaded,
    TResult? Function(String message, List<AlertHistoryItem>? alertHistory,
            Set<String>? alertedStocks)?
        error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<AlertHistoryItem> alertHistory, Set<String> alertedStocks)?
        loaded,
    TResult Function(String message, List<AlertHistoryItem>? alertHistory,
            Set<String>? alertedStocks)?
        error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AlertInitial value) initial,
    required TResult Function(AlertLoading value) loading,
    required TResult Function(AlertLoaded value) loaded,
    required TResult Function(AlertError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AlertInitial value)? initial,
    TResult? Function(AlertLoading value)? loading,
    TResult? Function(AlertLoaded value)? loaded,
    TResult? Function(AlertError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AlertInitial value)? initial,
    TResult Function(AlertLoading value)? loading,
    TResult Function(AlertLoaded value)? loaded,
    TResult Function(AlertError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AlertInitial implements AlertState {
  const factory AlertInitial() = _$AlertInitialImpl;
}

/// @nodoc
abstract class _$$AlertLoadingImplCopyWith<$Res> {
  factory _$$AlertLoadingImplCopyWith(
          _$AlertLoadingImpl value, $Res Function(_$AlertLoadingImpl) then) =
      __$$AlertLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AlertLoadingImplCopyWithImpl<$Res>
    extends _$AlertStateCopyWithImpl<$Res, _$AlertLoadingImpl>
    implements _$$AlertLoadingImplCopyWith<$Res> {
  __$$AlertLoadingImplCopyWithImpl(
      _$AlertLoadingImpl _value, $Res Function(_$AlertLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AlertLoadingImpl implements AlertLoading {
  const _$AlertLoadingImpl();

  @override
  String toString() {
    return 'AlertState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AlertLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<AlertHistoryItem> alertHistory, Set<String> alertedStocks)
        loaded,
    required TResult Function(String message,
            List<AlertHistoryItem>? alertHistory, Set<String>? alertedStocks)
        error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<AlertHistoryItem> alertHistory, Set<String> alertedStocks)?
        loaded,
    TResult? Function(String message, List<AlertHistoryItem>? alertHistory,
            Set<String>? alertedStocks)?
        error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<AlertHistoryItem> alertHistory, Set<String> alertedStocks)?
        loaded,
    TResult Function(String message, List<AlertHistoryItem>? alertHistory,
            Set<String>? alertedStocks)?
        error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AlertInitial value) initial,
    required TResult Function(AlertLoading value) loading,
    required TResult Function(AlertLoaded value) loaded,
    required TResult Function(AlertError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AlertInitial value)? initial,
    TResult? Function(AlertLoading value)? loading,
    TResult? Function(AlertLoaded value)? loaded,
    TResult? Function(AlertError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AlertInitial value)? initial,
    TResult Function(AlertLoading value)? loading,
    TResult Function(AlertLoaded value)? loaded,
    TResult Function(AlertError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AlertLoading implements AlertState {
  const factory AlertLoading() = _$AlertLoadingImpl;
}

/// @nodoc
abstract class _$$AlertLoadedImplCopyWith<$Res> {
  factory _$$AlertLoadedImplCopyWith(
          _$AlertLoadedImpl value, $Res Function(_$AlertLoadedImpl) then) =
      __$$AlertLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<AlertHistoryItem> alertHistory, Set<String> alertedStocks});
}

/// @nodoc
class __$$AlertLoadedImplCopyWithImpl<$Res>
    extends _$AlertStateCopyWithImpl<$Res, _$AlertLoadedImpl>
    implements _$$AlertLoadedImplCopyWith<$Res> {
  __$$AlertLoadedImplCopyWithImpl(
      _$AlertLoadedImpl _value, $Res Function(_$AlertLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alertHistory = null,
    Object? alertedStocks = null,
  }) {
    return _then(_$AlertLoadedImpl(
      alertHistory: null == alertHistory
          ? _value._alertHistory
          : alertHistory // ignore: cast_nullable_to_non_nullable
              as List<AlertHistoryItem>,
      alertedStocks: null == alertedStocks
          ? _value._alertedStocks
          : alertedStocks // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

/// @nodoc

class _$AlertLoadedImpl implements AlertLoaded {
  const _$AlertLoadedImpl(
      {required final List<AlertHistoryItem> alertHistory,
      required final Set<String> alertedStocks})
      : _alertHistory = alertHistory,
        _alertedStocks = alertedStocks;

  final List<AlertHistoryItem> _alertHistory;
  @override
  List<AlertHistoryItem> get alertHistory {
    if (_alertHistory is EqualUnmodifiableListView) return _alertHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alertHistory);
  }

  final Set<String> _alertedStocks;
  @override
  Set<String> get alertedStocks {
    if (_alertedStocks is EqualUnmodifiableSetView) return _alertedStocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_alertedStocks);
  }

  @override
  String toString() {
    return 'AlertState.loaded(alertHistory: $alertHistory, alertedStocks: $alertedStocks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._alertHistory, _alertHistory) &&
            const DeepCollectionEquality()
                .equals(other._alertedStocks, _alertedStocks));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_alertHistory),
      const DeepCollectionEquality().hash(_alertedStocks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertLoadedImplCopyWith<_$AlertLoadedImpl> get copyWith =>
      __$$AlertLoadedImplCopyWithImpl<_$AlertLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<AlertHistoryItem> alertHistory, Set<String> alertedStocks)
        loaded,
    required TResult Function(String message,
            List<AlertHistoryItem>? alertHistory, Set<String>? alertedStocks)
        error,
  }) {
    return loaded(alertHistory, alertedStocks);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<AlertHistoryItem> alertHistory, Set<String> alertedStocks)?
        loaded,
    TResult? Function(String message, List<AlertHistoryItem>? alertHistory,
            Set<String>? alertedStocks)?
        error,
  }) {
    return loaded?.call(alertHistory, alertedStocks);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<AlertHistoryItem> alertHistory, Set<String> alertedStocks)?
        loaded,
    TResult Function(String message, List<AlertHistoryItem>? alertHistory,
            Set<String>? alertedStocks)?
        error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(alertHistory, alertedStocks);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AlertInitial value) initial,
    required TResult Function(AlertLoading value) loading,
    required TResult Function(AlertLoaded value) loaded,
    required TResult Function(AlertError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AlertInitial value)? initial,
    TResult? Function(AlertLoading value)? loading,
    TResult? Function(AlertLoaded value)? loaded,
    TResult? Function(AlertError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AlertInitial value)? initial,
    TResult Function(AlertLoading value)? loading,
    TResult Function(AlertLoaded value)? loaded,
    TResult Function(AlertError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class AlertLoaded implements AlertState {
  const factory AlertLoaded(
      {required final List<AlertHistoryItem> alertHistory,
      required final Set<String> alertedStocks}) = _$AlertLoadedImpl;

  List<AlertHistoryItem> get alertHistory;
  Set<String> get alertedStocks;
  @JsonKey(ignore: true)
  _$$AlertLoadedImplCopyWith<_$AlertLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AlertErrorImplCopyWith<$Res> {
  factory _$$AlertErrorImplCopyWith(
          _$AlertErrorImpl value, $Res Function(_$AlertErrorImpl) then) =
      __$$AlertErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String message,
      List<AlertHistoryItem>? alertHistory,
      Set<String>? alertedStocks});
}

/// @nodoc
class __$$AlertErrorImplCopyWithImpl<$Res>
    extends _$AlertStateCopyWithImpl<$Res, _$AlertErrorImpl>
    implements _$$AlertErrorImplCopyWith<$Res> {
  __$$AlertErrorImplCopyWithImpl(
      _$AlertErrorImpl _value, $Res Function(_$AlertErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? alertHistory = freezed,
    Object? alertedStocks = freezed,
  }) {
    return _then(_$AlertErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      alertHistory: freezed == alertHistory
          ? _value._alertHistory
          : alertHistory // ignore: cast_nullable_to_non_nullable
              as List<AlertHistoryItem>?,
      alertedStocks: freezed == alertedStocks
          ? _value._alertedStocks
          : alertedStocks // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
    ));
  }
}

/// @nodoc

class _$AlertErrorImpl implements AlertError {
  const _$AlertErrorImpl(
      {required this.message,
      final List<AlertHistoryItem>? alertHistory,
      final Set<String>? alertedStocks})
      : _alertHistory = alertHistory,
        _alertedStocks = alertedStocks;

  @override
  final String message;
  final List<AlertHistoryItem>? _alertHistory;
  @override
  List<AlertHistoryItem>? get alertHistory {
    final value = _alertHistory;
    if (value == null) return null;
    if (_alertHistory is EqualUnmodifiableListView) return _alertHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Set<String>? _alertedStocks;
  @override
  Set<String>? get alertedStocks {
    final value = _alertedStocks;
    if (value == null) return null;
    if (_alertedStocks is EqualUnmodifiableSetView) return _alertedStocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(value);
  }

  @override
  String toString() {
    return 'AlertState.error(message: $message, alertHistory: $alertHistory, alertedStocks: $alertedStocks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._alertHistory, _alertHistory) &&
            const DeepCollectionEquality()
                .equals(other._alertedStocks, _alertedStocks));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      message,
      const DeepCollectionEquality().hash(_alertHistory),
      const DeepCollectionEquality().hash(_alertedStocks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertErrorImplCopyWith<_$AlertErrorImpl> get copyWith =>
      __$$AlertErrorImplCopyWithImpl<_$AlertErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<AlertHistoryItem> alertHistory, Set<String> alertedStocks)
        loaded,
    required TResult Function(String message,
            List<AlertHistoryItem>? alertHistory, Set<String>? alertedStocks)
        error,
  }) {
    return error(message, alertHistory, alertedStocks);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<AlertHistoryItem> alertHistory, Set<String> alertedStocks)?
        loaded,
    TResult? Function(String message, List<AlertHistoryItem>? alertHistory,
            Set<String>? alertedStocks)?
        error,
  }) {
    return error?.call(message, alertHistory, alertedStocks);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<AlertHistoryItem> alertHistory, Set<String> alertedStocks)?
        loaded,
    TResult Function(String message, List<AlertHistoryItem>? alertHistory,
            Set<String>? alertedStocks)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, alertHistory, alertedStocks);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AlertInitial value) initial,
    required TResult Function(AlertLoading value) loading,
    required TResult Function(AlertLoaded value) loaded,
    required TResult Function(AlertError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AlertInitial value)? initial,
    TResult? Function(AlertLoading value)? loading,
    TResult? Function(AlertLoaded value)? loaded,
    TResult? Function(AlertError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AlertInitial value)? initial,
    TResult Function(AlertLoading value)? loading,
    TResult Function(AlertLoaded value)? loaded,
    TResult Function(AlertError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AlertError implements AlertState {
  const factory AlertError(
      {required final String message,
      final List<AlertHistoryItem>? alertHistory,
      final Set<String>? alertedStocks}) = _$AlertErrorImpl;

  String get message;
  List<AlertHistoryItem>? get alertHistory;
  Set<String>? get alertedStocks;
  @JsonKey(ignore: true)
  _$$AlertErrorImplCopyWith<_$AlertErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

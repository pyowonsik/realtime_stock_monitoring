// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FavoriteState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<FavoriteItem> favoriteList,
            Map<String, PriceUpdate> priceUpdates)
        loaded,
    required TResult Function(String message, List<FavoriteItem>? favoriteList,
            Map<String, PriceUpdate>? priceUpdates)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<FavoriteItem> favoriteList,
            Map<String, PriceUpdate> priceUpdates)?
        loaded,
    TResult? Function(String message, List<FavoriteItem>? favoriteList,
            Map<String, PriceUpdate>? priceUpdates)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<FavoriteItem> favoriteList,
            Map<String, PriceUpdate> priceUpdates)?
        loaded,
    TResult Function(String message, List<FavoriteItem>? favoriteList,
            Map<String, PriceUpdate>? priceUpdates)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FavoriteInitial value) initial,
    required TResult Function(FavoriteLoading value) loading,
    required TResult Function(FavoriteLoaded value) loaded,
    required TResult Function(FavoriteError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FavoriteInitial value)? initial,
    TResult? Function(FavoriteLoading value)? loading,
    TResult? Function(FavoriteLoaded value)? loaded,
    TResult? Function(FavoriteError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FavoriteInitial value)? initial,
    TResult Function(FavoriteLoading value)? loading,
    TResult Function(FavoriteLoaded value)? loaded,
    TResult Function(FavoriteError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteStateCopyWith<$Res> {
  factory $FavoriteStateCopyWith(
          FavoriteState value, $Res Function(FavoriteState) then) =
      _$FavoriteStateCopyWithImpl<$Res, FavoriteState>;
}

/// @nodoc
class _$FavoriteStateCopyWithImpl<$Res, $Val extends FavoriteState>
    implements $FavoriteStateCopyWith<$Res> {
  _$FavoriteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$FavoriteInitialImplCopyWith<$Res> {
  factory _$$FavoriteInitialImplCopyWith(_$FavoriteInitialImpl value,
          $Res Function(_$FavoriteInitialImpl) then) =
      __$$FavoriteInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FavoriteInitialImplCopyWithImpl<$Res>
    extends _$FavoriteStateCopyWithImpl<$Res, _$FavoriteInitialImpl>
    implements _$$FavoriteInitialImplCopyWith<$Res> {
  __$$FavoriteInitialImplCopyWithImpl(
      _$FavoriteInitialImpl _value, $Res Function(_$FavoriteInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FavoriteInitialImpl implements FavoriteInitial {
  const _$FavoriteInitialImpl();

  @override
  String toString() {
    return 'FavoriteState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FavoriteInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<FavoriteItem> favoriteList,
            Map<String, PriceUpdate> priceUpdates)
        loaded,
    required TResult Function(String message, List<FavoriteItem>? favoriteList,
            Map<String, PriceUpdate>? priceUpdates)
        error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<FavoriteItem> favoriteList,
            Map<String, PriceUpdate> priceUpdates)?
        loaded,
    TResult? Function(String message, List<FavoriteItem>? favoriteList,
            Map<String, PriceUpdate>? priceUpdates)?
        error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<FavoriteItem> favoriteList,
            Map<String, PriceUpdate> priceUpdates)?
        loaded,
    TResult Function(String message, List<FavoriteItem>? favoriteList,
            Map<String, PriceUpdate>? priceUpdates)?
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
    required TResult Function(FavoriteInitial value) initial,
    required TResult Function(FavoriteLoading value) loading,
    required TResult Function(FavoriteLoaded value) loaded,
    required TResult Function(FavoriteError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FavoriteInitial value)? initial,
    TResult? Function(FavoriteLoading value)? loading,
    TResult? Function(FavoriteLoaded value)? loaded,
    TResult? Function(FavoriteError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FavoriteInitial value)? initial,
    TResult Function(FavoriteLoading value)? loading,
    TResult Function(FavoriteLoaded value)? loaded,
    TResult Function(FavoriteError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class FavoriteInitial implements FavoriteState {
  const factory FavoriteInitial() = _$FavoriteInitialImpl;
}

/// @nodoc
abstract class _$$FavoriteLoadingImplCopyWith<$Res> {
  factory _$$FavoriteLoadingImplCopyWith(_$FavoriteLoadingImpl value,
          $Res Function(_$FavoriteLoadingImpl) then) =
      __$$FavoriteLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FavoriteLoadingImplCopyWithImpl<$Res>
    extends _$FavoriteStateCopyWithImpl<$Res, _$FavoriteLoadingImpl>
    implements _$$FavoriteLoadingImplCopyWith<$Res> {
  __$$FavoriteLoadingImplCopyWithImpl(
      _$FavoriteLoadingImpl _value, $Res Function(_$FavoriteLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$FavoriteLoadingImpl implements FavoriteLoading {
  const _$FavoriteLoadingImpl();

  @override
  String toString() {
    return 'FavoriteState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FavoriteLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<FavoriteItem> favoriteList,
            Map<String, PriceUpdate> priceUpdates)
        loaded,
    required TResult Function(String message, List<FavoriteItem>? favoriteList,
            Map<String, PriceUpdate>? priceUpdates)
        error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<FavoriteItem> favoriteList,
            Map<String, PriceUpdate> priceUpdates)?
        loaded,
    TResult? Function(String message, List<FavoriteItem>? favoriteList,
            Map<String, PriceUpdate>? priceUpdates)?
        error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<FavoriteItem> favoriteList,
            Map<String, PriceUpdate> priceUpdates)?
        loaded,
    TResult Function(String message, List<FavoriteItem>? favoriteList,
            Map<String, PriceUpdate>? priceUpdates)?
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
    required TResult Function(FavoriteInitial value) initial,
    required TResult Function(FavoriteLoading value) loading,
    required TResult Function(FavoriteLoaded value) loaded,
    required TResult Function(FavoriteError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FavoriteInitial value)? initial,
    TResult? Function(FavoriteLoading value)? loading,
    TResult? Function(FavoriteLoaded value)? loaded,
    TResult? Function(FavoriteError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FavoriteInitial value)? initial,
    TResult Function(FavoriteLoading value)? loading,
    TResult Function(FavoriteLoaded value)? loaded,
    TResult Function(FavoriteError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class FavoriteLoading implements FavoriteState {
  const factory FavoriteLoading() = _$FavoriteLoadingImpl;
}

/// @nodoc
abstract class _$$FavoriteLoadedImplCopyWith<$Res> {
  factory _$$FavoriteLoadedImplCopyWith(_$FavoriteLoadedImpl value,
          $Res Function(_$FavoriteLoadedImpl) then) =
      __$$FavoriteLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<FavoriteItem> favoriteList, Map<String, PriceUpdate> priceUpdates});
}

/// @nodoc
class __$$FavoriteLoadedImplCopyWithImpl<$Res>
    extends _$FavoriteStateCopyWithImpl<$Res, _$FavoriteLoadedImpl>
    implements _$$FavoriteLoadedImplCopyWith<$Res> {
  __$$FavoriteLoadedImplCopyWithImpl(
      _$FavoriteLoadedImpl _value, $Res Function(_$FavoriteLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favoriteList = null,
    Object? priceUpdates = null,
  }) {
    return _then(_$FavoriteLoadedImpl(
      favoriteList: null == favoriteList
          ? _value._favoriteList
          : favoriteList // ignore: cast_nullable_to_non_nullable
              as List<FavoriteItem>,
      priceUpdates: null == priceUpdates
          ? _value._priceUpdates
          : priceUpdates // ignore: cast_nullable_to_non_nullable
              as Map<String, PriceUpdate>,
    ));
  }
}

/// @nodoc

class _$FavoriteLoadedImpl implements FavoriteLoaded {
  const _$FavoriteLoadedImpl(
      {required final List<FavoriteItem> favoriteList,
      required final Map<String, PriceUpdate> priceUpdates})
      : _favoriteList = favoriteList,
        _priceUpdates = priceUpdates;

  final List<FavoriteItem> _favoriteList;
  @override
  List<FavoriteItem> get favoriteList {
    if (_favoriteList is EqualUnmodifiableListView) return _favoriteList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoriteList);
  }

  final Map<String, PriceUpdate> _priceUpdates;
  @override
  Map<String, PriceUpdate> get priceUpdates {
    if (_priceUpdates is EqualUnmodifiableMapView) return _priceUpdates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_priceUpdates);
  }

  @override
  String toString() {
    return 'FavoriteState.loaded(favoriteList: $favoriteList, priceUpdates: $priceUpdates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._favoriteList, _favoriteList) &&
            const DeepCollectionEquality()
                .equals(other._priceUpdates, _priceUpdates));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_favoriteList),
      const DeepCollectionEquality().hash(_priceUpdates));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteLoadedImplCopyWith<_$FavoriteLoadedImpl> get copyWith =>
      __$$FavoriteLoadedImplCopyWithImpl<_$FavoriteLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<FavoriteItem> favoriteList,
            Map<String, PriceUpdate> priceUpdates)
        loaded,
    required TResult Function(String message, List<FavoriteItem>? favoriteList,
            Map<String, PriceUpdate>? priceUpdates)
        error,
  }) {
    return loaded(favoriteList, priceUpdates);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<FavoriteItem> favoriteList,
            Map<String, PriceUpdate> priceUpdates)?
        loaded,
    TResult? Function(String message, List<FavoriteItem>? favoriteList,
            Map<String, PriceUpdate>? priceUpdates)?
        error,
  }) {
    return loaded?.call(favoriteList, priceUpdates);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<FavoriteItem> favoriteList,
            Map<String, PriceUpdate> priceUpdates)?
        loaded,
    TResult Function(String message, List<FavoriteItem>? favoriteList,
            Map<String, PriceUpdate>? priceUpdates)?
        error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(favoriteList, priceUpdates);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FavoriteInitial value) initial,
    required TResult Function(FavoriteLoading value) loading,
    required TResult Function(FavoriteLoaded value) loaded,
    required TResult Function(FavoriteError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FavoriteInitial value)? initial,
    TResult? Function(FavoriteLoading value)? loading,
    TResult? Function(FavoriteLoaded value)? loaded,
    TResult? Function(FavoriteError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FavoriteInitial value)? initial,
    TResult Function(FavoriteLoading value)? loading,
    TResult Function(FavoriteLoaded value)? loaded,
    TResult Function(FavoriteError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class FavoriteLoaded implements FavoriteState {
  const factory FavoriteLoaded(
          {required final List<FavoriteItem> favoriteList,
          required final Map<String, PriceUpdate> priceUpdates}) =
      _$FavoriteLoadedImpl;

  List<FavoriteItem> get favoriteList;
  Map<String, PriceUpdate> get priceUpdates;
  @JsonKey(ignore: true)
  _$$FavoriteLoadedImplCopyWith<_$FavoriteLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FavoriteErrorImplCopyWith<$Res> {
  factory _$$FavoriteErrorImplCopyWith(
          _$FavoriteErrorImpl value, $Res Function(_$FavoriteErrorImpl) then) =
      __$$FavoriteErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String message,
      List<FavoriteItem>? favoriteList,
      Map<String, PriceUpdate>? priceUpdates});
}

/// @nodoc
class __$$FavoriteErrorImplCopyWithImpl<$Res>
    extends _$FavoriteStateCopyWithImpl<$Res, _$FavoriteErrorImpl>
    implements _$$FavoriteErrorImplCopyWith<$Res> {
  __$$FavoriteErrorImplCopyWithImpl(
      _$FavoriteErrorImpl _value, $Res Function(_$FavoriteErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? favoriteList = freezed,
    Object? priceUpdates = freezed,
  }) {
    return _then(_$FavoriteErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      favoriteList: freezed == favoriteList
          ? _value._favoriteList
          : favoriteList // ignore: cast_nullable_to_non_nullable
              as List<FavoriteItem>?,
      priceUpdates: freezed == priceUpdates
          ? _value._priceUpdates
          : priceUpdates // ignore: cast_nullable_to_non_nullable
              as Map<String, PriceUpdate>?,
    ));
  }
}

/// @nodoc

class _$FavoriteErrorImpl implements FavoriteError {
  const _$FavoriteErrorImpl(
      {required this.message,
      final List<FavoriteItem>? favoriteList,
      final Map<String, PriceUpdate>? priceUpdates})
      : _favoriteList = favoriteList,
        _priceUpdates = priceUpdates;

  @override
  final String message;
  final List<FavoriteItem>? _favoriteList;
  @override
  List<FavoriteItem>? get favoriteList {
    final value = _favoriteList;
    if (value == null) return null;
    if (_favoriteList is EqualUnmodifiableListView) return _favoriteList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, PriceUpdate>? _priceUpdates;
  @override
  Map<String, PriceUpdate>? get priceUpdates {
    final value = _priceUpdates;
    if (value == null) return null;
    if (_priceUpdates is EqualUnmodifiableMapView) return _priceUpdates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'FavoriteState.error(message: $message, favoriteList: $favoriteList, priceUpdates: $priceUpdates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._favoriteList, _favoriteList) &&
            const DeepCollectionEquality()
                .equals(other._priceUpdates, _priceUpdates));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      message,
      const DeepCollectionEquality().hash(_favoriteList),
      const DeepCollectionEquality().hash(_priceUpdates));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteErrorImplCopyWith<_$FavoriteErrorImpl> get copyWith =>
      __$$FavoriteErrorImplCopyWithImpl<_$FavoriteErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<FavoriteItem> favoriteList,
            Map<String, PriceUpdate> priceUpdates)
        loaded,
    required TResult Function(String message, List<FavoriteItem>? favoriteList,
            Map<String, PriceUpdate>? priceUpdates)
        error,
  }) {
    return error(message, favoriteList, priceUpdates);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<FavoriteItem> favoriteList,
            Map<String, PriceUpdate> priceUpdates)?
        loaded,
    TResult? Function(String message, List<FavoriteItem>? favoriteList,
            Map<String, PriceUpdate>? priceUpdates)?
        error,
  }) {
    return error?.call(message, favoriteList, priceUpdates);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<FavoriteItem> favoriteList,
            Map<String, PriceUpdate> priceUpdates)?
        loaded,
    TResult Function(String message, List<FavoriteItem>? favoriteList,
            Map<String, PriceUpdate>? priceUpdates)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, favoriteList, priceUpdates);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FavoriteInitial value) initial,
    required TResult Function(FavoriteLoading value) loading,
    required TResult Function(FavoriteLoaded value) loaded,
    required TResult Function(FavoriteError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FavoriteInitial value)? initial,
    TResult? Function(FavoriteLoading value)? loading,
    TResult? Function(FavoriteLoaded value)? loaded,
    TResult? Function(FavoriteError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FavoriteInitial value)? initial,
    TResult Function(FavoriteLoading value)? loading,
    TResult Function(FavoriteLoaded value)? loaded,
    TResult Function(FavoriteError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class FavoriteError implements FavoriteState {
  const factory FavoriteError(
      {required final String message,
      final List<FavoriteItem>? favoriteList,
      final Map<String, PriceUpdate>? priceUpdates}) = _$FavoriteErrorImpl;

  String get message;
  List<FavoriteItem>? get favoriteList;
  Map<String, PriceUpdate>? get priceUpdates;
  @JsonKey(ignore: true)
  _$$FavoriteErrorImplCopyWith<_$FavoriteErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

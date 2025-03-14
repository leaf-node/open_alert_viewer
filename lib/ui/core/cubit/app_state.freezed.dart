// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AppState {
  Screens get screen => throw _privateConstructorUsedError;
  bool get screenPushed => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  Object? get data => throw _privateConstructorUsedError;
  bool? get darkMode => throw _privateConstructorUsedError;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
  @useResult
  $Res call({
    Screens screen,
    bool screenPushed,
    int timestamp,
    Object? data,
    bool? darkMode,
  });
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? screen = null,
    Object? screenPushed = null,
    Object? timestamp = null,
    Object? data = freezed,
    Object? darkMode = freezed,
  }) {
    return _then(
      _value.copyWith(
            screen:
                null == screen
                    ? _value.screen
                    : screen // ignore: cast_nullable_to_non_nullable
                        as Screens,
            screenPushed:
                null == screenPushed
                    ? _value.screenPushed
                    : screenPushed // ignore: cast_nullable_to_non_nullable
                        as bool,
            timestamp:
                null == timestamp
                    ? _value.timestamp
                    : timestamp // ignore: cast_nullable_to_non_nullable
                        as int,
            data: freezed == data ? _value.data : data,
            darkMode:
                freezed == darkMode
                    ? _value.darkMode
                    : darkMode // ignore: cast_nullable_to_non_nullable
                        as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppStateImplCopyWith<$Res>
    implements $AppStateCopyWith<$Res> {
  factory _$$AppStateImplCopyWith(
    _$AppStateImpl value,
    $Res Function(_$AppStateImpl) then,
  ) = __$$AppStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Screens screen,
    bool screenPushed,
    int timestamp,
    Object? data,
    bool? darkMode,
  });
}

/// @nodoc
class __$$AppStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppStateImpl>
    implements _$$AppStateImplCopyWith<$Res> {
  __$$AppStateImplCopyWithImpl(
    _$AppStateImpl _value,
    $Res Function(_$AppStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? screen = null,
    Object? screenPushed = null,
    Object? timestamp = null,
    Object? data = freezed,
    Object? darkMode = freezed,
  }) {
    return _then(
      _$AppStateImpl(
        screen:
            null == screen
                ? _value.screen
                : screen // ignore: cast_nullable_to_non_nullable
                    as Screens,
        screenPushed:
            null == screenPushed
                ? _value.screenPushed
                : screenPushed // ignore: cast_nullable_to_non_nullable
                    as bool,
        timestamp:
            null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                    as int,
        data: freezed == data ? _value.data : data,
        darkMode:
            freezed == darkMode
                ? _value.darkMode
                : darkMode // ignore: cast_nullable_to_non_nullable
                    as bool?,
      ),
    );
  }
}

/// @nodoc

class _$AppStateImpl implements _AppState {
  const _$AppStateImpl({
    required this.screen,
    required this.screenPushed,
    required this.timestamp,
    this.data,
    this.darkMode,
  });

  @override
  final Screens screen;
  @override
  final bool screenPushed;
  @override
  final int timestamp;
  @override
  final Object? data;
  @override
  final bool? darkMode;

  @override
  String toString() {
    return 'AppState(screen: $screen, screenPushed: $screenPushed, timestamp: $timestamp, data: $data, darkMode: $darkMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppStateImpl &&
            (identical(other.screen, screen) || other.screen == screen) &&
            (identical(other.screenPushed, screenPushed) ||
                other.screenPushed == screenPushed) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.darkMode, darkMode) ||
                other.darkMode == darkMode));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    screen,
    screenPushed,
    timestamp,
    const DeepCollectionEquality().hash(data),
    darkMode,
  );

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      __$$AppStateImplCopyWithImpl<_$AppStateImpl>(this, _$identity);
}

abstract class _AppState implements AppState {
  const factory _AppState({
    required final Screens screen,
    required final bool screenPushed,
    required final int timestamp,
    final Object? data,
    final bool? darkMode,
  }) = _$AppStateImpl;

  @override
  Screens get screen;
  @override
  bool get screenPushed;
  @override
  int get timestamp;
  @override
  Object? get data;
  @override
  bool? get darkMode;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

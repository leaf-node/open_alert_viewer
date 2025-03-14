// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_settings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AccountSettingsState {
  bool get globalNotificationsEnabled => throw _privateConstructorUsedError;
  AlertSourceData? get source => throw _privateConstructorUsedError;

  /// Create a copy of AccountSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountSettingsStateCopyWith<AccountSettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountSettingsStateCopyWith<$Res> {
  factory $AccountSettingsStateCopyWith(
    AccountSettingsState value,
    $Res Function(AccountSettingsState) then,
  ) = _$AccountSettingsStateCopyWithImpl<$Res, AccountSettingsState>;
  @useResult
  $Res call({bool globalNotificationsEnabled, AlertSourceData? source});

  $AlertSourceDataCopyWith<$Res>? get source;
}

/// @nodoc
class _$AccountSettingsStateCopyWithImpl<
  $Res,
  $Val extends AccountSettingsState
>
    implements $AccountSettingsStateCopyWith<$Res> {
  _$AccountSettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? globalNotificationsEnabled = null,
    Object? source = freezed,
  }) {
    return _then(
      _value.copyWith(
            globalNotificationsEnabled:
                null == globalNotificationsEnabled
                    ? _value.globalNotificationsEnabled
                    : globalNotificationsEnabled // ignore: cast_nullable_to_non_nullable
                        as bool,
            source:
                freezed == source
                    ? _value.source
                    : source // ignore: cast_nullable_to_non_nullable
                        as AlertSourceData?,
          )
          as $Val,
    );
  }

  /// Create a copy of AccountSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AlertSourceDataCopyWith<$Res>? get source {
    if (_value.source == null) {
      return null;
    }

    return $AlertSourceDataCopyWith<$Res>(_value.source!, (value) {
      return _then(_value.copyWith(source: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AccountSettingsStateImplCopyWith<$Res>
    implements $AccountSettingsStateCopyWith<$Res> {
  factory _$$AccountSettingsStateImplCopyWith(
    _$AccountSettingsStateImpl value,
    $Res Function(_$AccountSettingsStateImpl) then,
  ) = __$$AccountSettingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool globalNotificationsEnabled, AlertSourceData? source});

  @override
  $AlertSourceDataCopyWith<$Res>? get source;
}

/// @nodoc
class __$$AccountSettingsStateImplCopyWithImpl<$Res>
    extends _$AccountSettingsStateCopyWithImpl<$Res, _$AccountSettingsStateImpl>
    implements _$$AccountSettingsStateImplCopyWith<$Res> {
  __$$AccountSettingsStateImplCopyWithImpl(
    _$AccountSettingsStateImpl _value,
    $Res Function(_$AccountSettingsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? globalNotificationsEnabled = null,
    Object? source = freezed,
  }) {
    return _then(
      _$AccountSettingsStateImpl(
        globalNotificationsEnabled:
            null == globalNotificationsEnabled
                ? _value.globalNotificationsEnabled
                : globalNotificationsEnabled // ignore: cast_nullable_to_non_nullable
                    as bool,
        source:
            freezed == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                    as AlertSourceData?,
      ),
    );
  }
}

/// @nodoc

class _$AccountSettingsStateImpl implements _AccountSettingsState {
  const _$AccountSettingsStateImpl({
    required this.globalNotificationsEnabled,
    required this.source,
  });

  @override
  final bool globalNotificationsEnabled;
  @override
  final AlertSourceData? source;

  @override
  String toString() {
    return 'AccountSettingsState(globalNotificationsEnabled: $globalNotificationsEnabled, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountSettingsStateImpl &&
            (identical(
                  other.globalNotificationsEnabled,
                  globalNotificationsEnabled,
                ) ||
                other.globalNotificationsEnabled ==
                    globalNotificationsEnabled) &&
            (identical(other.source, source) || other.source == source));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, globalNotificationsEnabled, source);

  /// Create a copy of AccountSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountSettingsStateImplCopyWith<_$AccountSettingsStateImpl>
  get copyWith =>
      __$$AccountSettingsStateImplCopyWithImpl<_$AccountSettingsStateImpl>(
        this,
        _$identity,
      );
}

abstract class _AccountSettingsState implements AccountSettingsState {
  const factory _AccountSettingsState({
    required final bool globalNotificationsEnabled,
    required final AlertSourceData? source,
  }) = _$AccountSettingsStateImpl;

  @override
  bool get globalNotificationsEnabled;
  @override
  AlertSourceData? get source;

  /// Create a copy of AccountSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountSettingsStateImplCopyWith<_$AccountSettingsStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}

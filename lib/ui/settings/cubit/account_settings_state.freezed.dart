// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccountSettingsState {
  AlertSourceData? get sourceData => throw _privateConstructorUsedError;
  bool get needsCheck => throw _privateConstructorUsedError;
  bool get checkingNow => throw _privateConstructorUsedError;
  bool get responded => throw _privateConstructorUsedError;

  /// Create a copy of AccountSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountSettingsStateCopyWith<AccountSettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountSettingsStateCopyWith<$Res> {
  factory $AccountSettingsStateCopyWith(AccountSettingsState value,
          $Res Function(AccountSettingsState) then) =
      _$AccountSettingsStateCopyWithImpl<$Res, AccountSettingsState>;
  @useResult
  $Res call(
      {AlertSourceData? sourceData,
      bool needsCheck,
      bool checkingNow,
      bool responded});

  $AlertSourceDataCopyWith<$Res>? get sourceData;
}

/// @nodoc
class _$AccountSettingsStateCopyWithImpl<$Res,
        $Val extends AccountSettingsState>
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
    Object? sourceData = freezed,
    Object? needsCheck = null,
    Object? checkingNow = null,
    Object? responded = null,
  }) {
    return _then(_value.copyWith(
      sourceData: freezed == sourceData
          ? _value.sourceData
          : sourceData // ignore: cast_nullable_to_non_nullable
              as AlertSourceData?,
      needsCheck: null == needsCheck
          ? _value.needsCheck
          : needsCheck // ignore: cast_nullable_to_non_nullable
              as bool,
      checkingNow: null == checkingNow
          ? _value.checkingNow
          : checkingNow // ignore: cast_nullable_to_non_nullable
              as bool,
      responded: null == responded
          ? _value.responded
          : responded // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of AccountSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AlertSourceDataCopyWith<$Res>? get sourceData {
    if (_value.sourceData == null) {
      return null;
    }

    return $AlertSourceDataCopyWith<$Res>(_value.sourceData!, (value) {
      return _then(_value.copyWith(sourceData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AccountSettingsStateImplCopyWith<$Res>
    implements $AccountSettingsStateCopyWith<$Res> {
  factory _$$AccountSettingsStateImplCopyWith(_$AccountSettingsStateImpl value,
          $Res Function(_$AccountSettingsStateImpl) then) =
      __$$AccountSettingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AlertSourceData? sourceData,
      bool needsCheck,
      bool checkingNow,
      bool responded});

  @override
  $AlertSourceDataCopyWith<$Res>? get sourceData;
}

/// @nodoc
class __$$AccountSettingsStateImplCopyWithImpl<$Res>
    extends _$AccountSettingsStateCopyWithImpl<$Res, _$AccountSettingsStateImpl>
    implements _$$AccountSettingsStateImplCopyWith<$Res> {
  __$$AccountSettingsStateImplCopyWithImpl(_$AccountSettingsStateImpl _value,
      $Res Function(_$AccountSettingsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceData = freezed,
    Object? needsCheck = null,
    Object? checkingNow = null,
    Object? responded = null,
  }) {
    return _then(_$AccountSettingsStateImpl(
      sourceData: freezed == sourceData
          ? _value.sourceData
          : sourceData // ignore: cast_nullable_to_non_nullable
              as AlertSourceData?,
      needsCheck: null == needsCheck
          ? _value.needsCheck
          : needsCheck // ignore: cast_nullable_to_non_nullable
              as bool,
      checkingNow: null == checkingNow
          ? _value.checkingNow
          : checkingNow // ignore: cast_nullable_to_non_nullable
              as bool,
      responded: null == responded
          ? _value.responded
          : responded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AccountSettingsStateImpl implements _AccountSettingsState {
  const _$AccountSettingsStateImpl(
      {required this.sourceData,
      required this.needsCheck,
      required this.checkingNow,
      required this.responded});

  @override
  final AlertSourceData? sourceData;
  @override
  final bool needsCheck;
  @override
  final bool checkingNow;
  @override
  final bool responded;

  @override
  String toString() {
    return 'AccountSettingsState(sourceData: $sourceData, needsCheck: $needsCheck, checkingNow: $checkingNow, responded: $responded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountSettingsStateImpl &&
            (identical(other.sourceData, sourceData) ||
                other.sourceData == sourceData) &&
            (identical(other.needsCheck, needsCheck) ||
                other.needsCheck == needsCheck) &&
            (identical(other.checkingNow, checkingNow) ||
                other.checkingNow == checkingNow) &&
            (identical(other.responded, responded) ||
                other.responded == responded));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, sourceData, needsCheck, checkingNow, responded);

  /// Create a copy of AccountSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountSettingsStateImplCopyWith<_$AccountSettingsStateImpl>
      get copyWith =>
          __$$AccountSettingsStateImplCopyWithImpl<_$AccountSettingsStateImpl>(
              this, _$identity);
}

abstract class _AccountSettingsState implements AccountSettingsState {
  const factory _AccountSettingsState(
      {required final AlertSourceData? sourceData,
      required final bool needsCheck,
      required final bool checkingNow,
      required final bool responded}) = _$AccountSettingsStateImpl;

  @override
  AlertSourceData? get sourceData;
  @override
  bool get needsCheck;
  @override
  bool get checkingNow;
  @override
  bool get responded;

  /// Create a copy of AccountSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountSettingsStateImplCopyWith<_$AccountSettingsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_settings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountSettingsState {

 bool get globalNotificationsEnabled; AlertSourceData? get source;
/// Create a copy of AccountSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountSettingsStateCopyWith<AccountSettingsState> get copyWith => _$AccountSettingsStateCopyWithImpl<AccountSettingsState>(this as AccountSettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountSettingsState&&(identical(other.globalNotificationsEnabled, globalNotificationsEnabled) || other.globalNotificationsEnabled == globalNotificationsEnabled)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,globalNotificationsEnabled,source);

@override
String toString() {
  return 'AccountSettingsState(globalNotificationsEnabled: $globalNotificationsEnabled, source: $source)';
}


}

/// @nodoc
abstract mixin class $AccountSettingsStateCopyWith<$Res>  {
  factory $AccountSettingsStateCopyWith(AccountSettingsState value, $Res Function(AccountSettingsState) _then) = _$AccountSettingsStateCopyWithImpl;
@useResult
$Res call({
 bool globalNotificationsEnabled, AlertSourceData? source
});


$AlertSourceDataCopyWith<$Res>? get source;

}
/// @nodoc
class _$AccountSettingsStateCopyWithImpl<$Res>
    implements $AccountSettingsStateCopyWith<$Res> {
  _$AccountSettingsStateCopyWithImpl(this._self, this._then);

  final AccountSettingsState _self;
  final $Res Function(AccountSettingsState) _then;

/// Create a copy of AccountSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? globalNotificationsEnabled = null,Object? source = freezed,}) {
  return _then(_self.copyWith(
globalNotificationsEnabled: null == globalNotificationsEnabled ? _self.globalNotificationsEnabled : globalNotificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as AlertSourceData?,
  ));
}
/// Create a copy of AccountSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AlertSourceDataCopyWith<$Res>? get source {
    if (_self.source == null) {
    return null;
  }

  return $AlertSourceDataCopyWith<$Res>(_self.source!, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}


/// @nodoc


class _AccountSettingsState implements AccountSettingsState {
  const _AccountSettingsState({required this.globalNotificationsEnabled, required this.source});
  

@override final  bool globalNotificationsEnabled;
@override final  AlertSourceData? source;

/// Create a copy of AccountSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountSettingsStateCopyWith<_AccountSettingsState> get copyWith => __$AccountSettingsStateCopyWithImpl<_AccountSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountSettingsState&&(identical(other.globalNotificationsEnabled, globalNotificationsEnabled) || other.globalNotificationsEnabled == globalNotificationsEnabled)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,globalNotificationsEnabled,source);

@override
String toString() {
  return 'AccountSettingsState(globalNotificationsEnabled: $globalNotificationsEnabled, source: $source)';
}


}

/// @nodoc
abstract mixin class _$AccountSettingsStateCopyWith<$Res> implements $AccountSettingsStateCopyWith<$Res> {
  factory _$AccountSettingsStateCopyWith(_AccountSettingsState value, $Res Function(_AccountSettingsState) _then) = __$AccountSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 bool globalNotificationsEnabled, AlertSourceData? source
});


@override $AlertSourceDataCopyWith<$Res>? get source;

}
/// @nodoc
class __$AccountSettingsStateCopyWithImpl<$Res>
    implements _$AccountSettingsStateCopyWith<$Res> {
  __$AccountSettingsStateCopyWithImpl(this._self, this._then);

  final _AccountSettingsState _self;
  final $Res Function(_AccountSettingsState) _then;

/// Create a copy of AccountSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? globalNotificationsEnabled = null,Object? source = freezed,}) {
  return _then(_AccountSettingsState(
globalNotificationsEnabled: null == globalNotificationsEnabled ? _self.globalNotificationsEnabled : globalNotificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as AlertSourceData?,
  ));
}

/// Create a copy of AccountSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AlertSourceDataCopyWith<$Res>? get source {
    if (_self.source == null) {
    return null;
  }

  return $AlertSourceDataCopyWith<$Res>(_self.source!, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}

// dart format on

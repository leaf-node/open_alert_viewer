// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'general_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GeneralSettingsCubitState {

 Map<String, Object> get settings; String get refreshIntervalSubtitle; String get syncTimeoutSubtitle; String get darkModeSubtitle; String get notificationsEnabledSubtitle; String get batteryPermissionSubtitle; String get soundEnabledSubtitle;
/// Create a copy of GeneralSettingsCubitState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeneralSettingsCubitStateCopyWith<GeneralSettingsCubitState> get copyWith => _$GeneralSettingsCubitStateCopyWithImpl<GeneralSettingsCubitState>(this as GeneralSettingsCubitState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeneralSettingsCubitState&&const DeepCollectionEquality().equals(other.settings, settings)&&(identical(other.refreshIntervalSubtitle, refreshIntervalSubtitle) || other.refreshIntervalSubtitle == refreshIntervalSubtitle)&&(identical(other.syncTimeoutSubtitle, syncTimeoutSubtitle) || other.syncTimeoutSubtitle == syncTimeoutSubtitle)&&(identical(other.darkModeSubtitle, darkModeSubtitle) || other.darkModeSubtitle == darkModeSubtitle)&&(identical(other.notificationsEnabledSubtitle, notificationsEnabledSubtitle) || other.notificationsEnabledSubtitle == notificationsEnabledSubtitle)&&(identical(other.batteryPermissionSubtitle, batteryPermissionSubtitle) || other.batteryPermissionSubtitle == batteryPermissionSubtitle)&&(identical(other.soundEnabledSubtitle, soundEnabledSubtitle) || other.soundEnabledSubtitle == soundEnabledSubtitle));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(settings),refreshIntervalSubtitle,syncTimeoutSubtitle,darkModeSubtitle,notificationsEnabledSubtitle,batteryPermissionSubtitle,soundEnabledSubtitle);

@override
String toString() {
  return 'GeneralSettingsCubitState(settings: $settings, refreshIntervalSubtitle: $refreshIntervalSubtitle, syncTimeoutSubtitle: $syncTimeoutSubtitle, darkModeSubtitle: $darkModeSubtitle, notificationsEnabledSubtitle: $notificationsEnabledSubtitle, batteryPermissionSubtitle: $batteryPermissionSubtitle, soundEnabledSubtitle: $soundEnabledSubtitle)';
}


}

/// @nodoc
abstract mixin class $GeneralSettingsCubitStateCopyWith<$Res>  {
  factory $GeneralSettingsCubitStateCopyWith(GeneralSettingsCubitState value, $Res Function(GeneralSettingsCubitState) _then) = _$GeneralSettingsCubitStateCopyWithImpl;
@useResult
$Res call({
 Map<String, Object> settings, String refreshIntervalSubtitle, String syncTimeoutSubtitle, String darkModeSubtitle, String notificationsEnabledSubtitle, String batteryPermissionSubtitle, String soundEnabledSubtitle
});




}
/// @nodoc
class _$GeneralSettingsCubitStateCopyWithImpl<$Res>
    implements $GeneralSettingsCubitStateCopyWith<$Res> {
  _$GeneralSettingsCubitStateCopyWithImpl(this._self, this._then);

  final GeneralSettingsCubitState _self;
  final $Res Function(GeneralSettingsCubitState) _then;

/// Create a copy of GeneralSettingsCubitState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? settings = null,Object? refreshIntervalSubtitle = null,Object? syncTimeoutSubtitle = null,Object? darkModeSubtitle = null,Object? notificationsEnabledSubtitle = null,Object? batteryPermissionSubtitle = null,Object? soundEnabledSubtitle = null,}) {
  return _then(_self.copyWith(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as Map<String, Object>,refreshIntervalSubtitle: null == refreshIntervalSubtitle ? _self.refreshIntervalSubtitle : refreshIntervalSubtitle // ignore: cast_nullable_to_non_nullable
as String,syncTimeoutSubtitle: null == syncTimeoutSubtitle ? _self.syncTimeoutSubtitle : syncTimeoutSubtitle // ignore: cast_nullable_to_non_nullable
as String,darkModeSubtitle: null == darkModeSubtitle ? _self.darkModeSubtitle : darkModeSubtitle // ignore: cast_nullable_to_non_nullable
as String,notificationsEnabledSubtitle: null == notificationsEnabledSubtitle ? _self.notificationsEnabledSubtitle : notificationsEnabledSubtitle // ignore: cast_nullable_to_non_nullable
as String,batteryPermissionSubtitle: null == batteryPermissionSubtitle ? _self.batteryPermissionSubtitle : batteryPermissionSubtitle // ignore: cast_nullable_to_non_nullable
as String,soundEnabledSubtitle: null == soundEnabledSubtitle ? _self.soundEnabledSubtitle : soundEnabledSubtitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _GeneralSettingsCubitState implements GeneralSettingsCubitState {
  const _GeneralSettingsCubitState({required final  Map<String, Object> settings, required this.refreshIntervalSubtitle, required this.syncTimeoutSubtitle, required this.darkModeSubtitle, required this.notificationsEnabledSubtitle, required this.batteryPermissionSubtitle, required this.soundEnabledSubtitle}): _settings = settings;
  

 final  Map<String, Object> _settings;
@override Map<String, Object> get settings {
  if (_settings is EqualUnmodifiableMapView) return _settings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_settings);
}

@override final  String refreshIntervalSubtitle;
@override final  String syncTimeoutSubtitle;
@override final  String darkModeSubtitle;
@override final  String notificationsEnabledSubtitle;
@override final  String batteryPermissionSubtitle;
@override final  String soundEnabledSubtitle;

/// Create a copy of GeneralSettingsCubitState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeneralSettingsCubitStateCopyWith<_GeneralSettingsCubitState> get copyWith => __$GeneralSettingsCubitStateCopyWithImpl<_GeneralSettingsCubitState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeneralSettingsCubitState&&const DeepCollectionEquality().equals(other._settings, _settings)&&(identical(other.refreshIntervalSubtitle, refreshIntervalSubtitle) || other.refreshIntervalSubtitle == refreshIntervalSubtitle)&&(identical(other.syncTimeoutSubtitle, syncTimeoutSubtitle) || other.syncTimeoutSubtitle == syncTimeoutSubtitle)&&(identical(other.darkModeSubtitle, darkModeSubtitle) || other.darkModeSubtitle == darkModeSubtitle)&&(identical(other.notificationsEnabledSubtitle, notificationsEnabledSubtitle) || other.notificationsEnabledSubtitle == notificationsEnabledSubtitle)&&(identical(other.batteryPermissionSubtitle, batteryPermissionSubtitle) || other.batteryPermissionSubtitle == batteryPermissionSubtitle)&&(identical(other.soundEnabledSubtitle, soundEnabledSubtitle) || other.soundEnabledSubtitle == soundEnabledSubtitle));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_settings),refreshIntervalSubtitle,syncTimeoutSubtitle,darkModeSubtitle,notificationsEnabledSubtitle,batteryPermissionSubtitle,soundEnabledSubtitle);

@override
String toString() {
  return 'GeneralSettingsCubitState(settings: $settings, refreshIntervalSubtitle: $refreshIntervalSubtitle, syncTimeoutSubtitle: $syncTimeoutSubtitle, darkModeSubtitle: $darkModeSubtitle, notificationsEnabledSubtitle: $notificationsEnabledSubtitle, batteryPermissionSubtitle: $batteryPermissionSubtitle, soundEnabledSubtitle: $soundEnabledSubtitle)';
}


}

/// @nodoc
abstract mixin class _$GeneralSettingsCubitStateCopyWith<$Res> implements $GeneralSettingsCubitStateCopyWith<$Res> {
  factory _$GeneralSettingsCubitStateCopyWith(_GeneralSettingsCubitState value, $Res Function(_GeneralSettingsCubitState) _then) = __$GeneralSettingsCubitStateCopyWithImpl;
@override @useResult
$Res call({
 Map<String, Object> settings, String refreshIntervalSubtitle, String syncTimeoutSubtitle, String darkModeSubtitle, String notificationsEnabledSubtitle, String batteryPermissionSubtitle, String soundEnabledSubtitle
});




}
/// @nodoc
class __$GeneralSettingsCubitStateCopyWithImpl<$Res>
    implements _$GeneralSettingsCubitStateCopyWith<$Res> {
  __$GeneralSettingsCubitStateCopyWithImpl(this._self, this._then);

  final _GeneralSettingsCubitState _self;
  final $Res Function(_GeneralSettingsCubitState) _then;

/// Create a copy of GeneralSettingsCubitState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? settings = null,Object? refreshIntervalSubtitle = null,Object? syncTimeoutSubtitle = null,Object? darkModeSubtitle = null,Object? notificationsEnabledSubtitle = null,Object? batteryPermissionSubtitle = null,Object? soundEnabledSubtitle = null,}) {
  return _then(_GeneralSettingsCubitState(
settings: null == settings ? _self._settings : settings // ignore: cast_nullable_to_non_nullable
as Map<String, Object>,refreshIntervalSubtitle: null == refreshIntervalSubtitle ? _self.refreshIntervalSubtitle : refreshIntervalSubtitle // ignore: cast_nullable_to_non_nullable
as String,syncTimeoutSubtitle: null == syncTimeoutSubtitle ? _self.syncTimeoutSubtitle : syncTimeoutSubtitle // ignore: cast_nullable_to_non_nullable
as String,darkModeSubtitle: null == darkModeSubtitle ? _self.darkModeSubtitle : darkModeSubtitle // ignore: cast_nullable_to_non_nullable
as String,notificationsEnabledSubtitle: null == notificationsEnabledSubtitle ? _self.notificationsEnabledSubtitle : notificationsEnabledSubtitle // ignore: cast_nullable_to_non_nullable
as String,batteryPermissionSubtitle: null == batteryPermissionSubtitle ? _self.batteryPermissionSubtitle : batteryPermissionSubtitle // ignore: cast_nullable_to_non_nullable
as String,soundEnabledSubtitle: null == soundEnabledSubtitle ? _self.soundEnabledSubtitle : soundEnabledSubtitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

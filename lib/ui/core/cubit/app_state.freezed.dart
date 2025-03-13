// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppState {

 Screens get screen; bool get screenPushed; int get timestamp; Object? get data; bool? get darkMode;
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStateCopyWith<AppState> get copyWith => _$AppStateCopyWithImpl<AppState>(this as AppState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppState&&(identical(other.screen, screen) || other.screen == screen)&&(identical(other.screenPushed, screenPushed) || other.screenPushed == screenPushed)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.darkMode, darkMode) || other.darkMode == darkMode));
}


@override
int get hashCode => Object.hash(runtimeType,screen,screenPushed,timestamp,const DeepCollectionEquality().hash(data),darkMode);

@override
String toString() {
  return 'AppState(screen: $screen, screenPushed: $screenPushed, timestamp: $timestamp, data: $data, darkMode: $darkMode)';
}


}

/// @nodoc
abstract mixin class $AppStateCopyWith<$Res>  {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) _then) = _$AppStateCopyWithImpl;
@useResult
$Res call({
 Screens screen, bool screenPushed, int timestamp, Object? data, bool? darkMode
});




}
/// @nodoc
class _$AppStateCopyWithImpl<$Res>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._self, this._then);

  final AppState _self;
  final $Res Function(AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? screen = null,Object? screenPushed = null,Object? timestamp = null,Object? data = freezed,Object? darkMode = freezed,}) {
  return _then(_self.copyWith(
screen: null == screen ? _self.screen : screen // ignore: cast_nullable_to_non_nullable
as Screens,screenPushed: null == screenPushed ? _self.screenPushed : screenPushed // ignore: cast_nullable_to_non_nullable
as bool,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,data: freezed == data ? _self.data : data ,darkMode: freezed == darkMode ? _self.darkMode : darkMode // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// @nodoc


class _AppState implements AppState {
  const _AppState({required this.screen, required this.screenPushed, required this.timestamp, this.data, this.darkMode});
  

@override final  Screens screen;
@override final  bool screenPushed;
@override final  int timestamp;
@override final  Object? data;
@override final  bool? darkMode;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppStateCopyWith<_AppState> get copyWith => __$AppStateCopyWithImpl<_AppState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppState&&(identical(other.screen, screen) || other.screen == screen)&&(identical(other.screenPushed, screenPushed) || other.screenPushed == screenPushed)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.darkMode, darkMode) || other.darkMode == darkMode));
}


@override
int get hashCode => Object.hash(runtimeType,screen,screenPushed,timestamp,const DeepCollectionEquality().hash(data),darkMode);

@override
String toString() {
  return 'AppState(screen: $screen, screenPushed: $screenPushed, timestamp: $timestamp, data: $data, darkMode: $darkMode)';
}


}

/// @nodoc
abstract mixin class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) _then) = __$AppStateCopyWithImpl;
@override @useResult
$Res call({
 Screens screen, bool screenPushed, int timestamp, Object? data, bool? darkMode
});




}
/// @nodoc
class __$AppStateCopyWithImpl<$Res>
    implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(this._self, this._then);

  final _AppState _self;
  final $Res Function(_AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? screen = null,Object? screenPushed = null,Object? timestamp = null,Object? data = freezed,Object? darkMode = freezed,}) {
  return _then(_AppState(
screen: null == screen ? _self.screen : screen // ignore: cast_nullable_to_non_nullable
as Screens,screenPushed: null == screenPushed ? _self.screenPushed : screenPushed // ignore: cast_nullable_to_non_nullable
as bool,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,data: freezed == data ? _self.data : data ,darkMode: freezed == darkMode ? _self.darkMode : darkMode // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on

// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'root_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RootSettingsCubitState {

 List<AlertSourceData> get sources; bool? get accountUpdated;
/// Create a copy of RootSettingsCubitState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RootSettingsCubitStateCopyWith<RootSettingsCubitState> get copyWith => _$RootSettingsCubitStateCopyWithImpl<RootSettingsCubitState>(this as RootSettingsCubitState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RootSettingsCubitState&&const DeepCollectionEquality().equals(other.sources, sources)&&(identical(other.accountUpdated, accountUpdated) || other.accountUpdated == accountUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sources),accountUpdated);

@override
String toString() {
  return 'RootSettingsCubitState(sources: $sources, accountUpdated: $accountUpdated)';
}


}

/// @nodoc
abstract mixin class $RootSettingsCubitStateCopyWith<$Res>  {
  factory $RootSettingsCubitStateCopyWith(RootSettingsCubitState value, $Res Function(RootSettingsCubitState) _then) = _$RootSettingsCubitStateCopyWithImpl;
@useResult
$Res call({
 List<AlertSourceData> sources, bool? accountUpdated
});




}
/// @nodoc
class _$RootSettingsCubitStateCopyWithImpl<$Res>
    implements $RootSettingsCubitStateCopyWith<$Res> {
  _$RootSettingsCubitStateCopyWithImpl(this._self, this._then);

  final RootSettingsCubitState _self;
  final $Res Function(RootSettingsCubitState) _then;

/// Create a copy of RootSettingsCubitState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sources = null,Object? accountUpdated = freezed,}) {
  return _then(_self.copyWith(
sources: null == sources ? _self.sources : sources // ignore: cast_nullable_to_non_nullable
as List<AlertSourceData>,accountUpdated: freezed == accountUpdated ? _self.accountUpdated : accountUpdated // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// @nodoc


class _RootSettingsState implements RootSettingsCubitState {
  const _RootSettingsState({required final  List<AlertSourceData> sources, required this.accountUpdated}): _sources = sources;
  

 final  List<AlertSourceData> _sources;
@override List<AlertSourceData> get sources {
  if (_sources is EqualUnmodifiableListView) return _sources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sources);
}

@override final  bool? accountUpdated;

/// Create a copy of RootSettingsCubitState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RootSettingsStateCopyWith<_RootSettingsState> get copyWith => __$RootSettingsStateCopyWithImpl<_RootSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RootSettingsState&&const DeepCollectionEquality().equals(other._sources, _sources)&&(identical(other.accountUpdated, accountUpdated) || other.accountUpdated == accountUpdated));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sources),accountUpdated);

@override
String toString() {
  return 'RootSettingsCubitState(sources: $sources, accountUpdated: $accountUpdated)';
}


}

/// @nodoc
abstract mixin class _$RootSettingsStateCopyWith<$Res> implements $RootSettingsCubitStateCopyWith<$Res> {
  factory _$RootSettingsStateCopyWith(_RootSettingsState value, $Res Function(_RootSettingsState) _then) = __$RootSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 List<AlertSourceData> sources, bool? accountUpdated
});




}
/// @nodoc
class __$RootSettingsStateCopyWithImpl<$Res>
    implements _$RootSettingsStateCopyWith<$Res> {
  __$RootSettingsStateCopyWithImpl(this._self, this._then);

  final _RootSettingsState _self;
  final $Res Function(_RootSettingsState) _then;

/// Create a copy of RootSettingsCubitState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sources = null,Object? accountUpdated = freezed,}) {
  return _then(_RootSettingsState(
sources: null == sources ? _self._sources : sources // ignore: cast_nullable_to_non_nullable
as List<AlertSourceData>,accountUpdated: freezed == accountUpdated ? _self.accountUpdated : accountUpdated // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on

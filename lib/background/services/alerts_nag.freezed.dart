// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alerts_nag.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NagAlertsData {

 NagDataSection? get data;
/// Create a copy of NagAlertsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NagAlertsDataCopyWith<NagAlertsData> get copyWith => _$NagAlertsDataCopyWithImpl<NagAlertsData>(this as NagAlertsData, _$identity);

  /// Serializes this NagAlertsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NagAlertsData&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'NagAlertsData(data: $data)';
}


}

/// @nodoc
abstract mixin class $NagAlertsDataCopyWith<$Res>  {
  factory $NagAlertsDataCopyWith(NagAlertsData value, $Res Function(NagAlertsData) _then) = _$NagAlertsDataCopyWithImpl;
@useResult
$Res call({
 NagDataSection? data
});


$NagDataSectionCopyWith<$Res>? get data;

}
/// @nodoc
class _$NagAlertsDataCopyWithImpl<$Res>
    implements $NagAlertsDataCopyWith<$Res> {
  _$NagAlertsDataCopyWithImpl(this._self, this._then);

  final NagAlertsData _self;
  final $Res Function(NagAlertsData) _then;

/// Create a copy of NagAlertsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = freezed,}) {
  return _then(_self.copyWith(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as NagDataSection?,
  ));
}
/// Create a copy of NagAlertsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NagDataSectionCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $NagDataSectionCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _NagAlertsData implements NagAlertsData {
  const _NagAlertsData({this.data});
  factory _NagAlertsData.fromJson(Map<String, dynamic> json) => _$NagAlertsDataFromJson(json);

@override final  NagDataSection? data;

/// Create a copy of NagAlertsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NagAlertsDataCopyWith<_NagAlertsData> get copyWith => __$NagAlertsDataCopyWithImpl<_NagAlertsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NagAlertsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NagAlertsData&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'NagAlertsData(data: $data)';
}


}

/// @nodoc
abstract mixin class _$NagAlertsDataCopyWith<$Res> implements $NagAlertsDataCopyWith<$Res> {
  factory _$NagAlertsDataCopyWith(_NagAlertsData value, $Res Function(_NagAlertsData) _then) = __$NagAlertsDataCopyWithImpl;
@override @useResult
$Res call({
 NagDataSection? data
});


@override $NagDataSectionCopyWith<$Res>? get data;

}
/// @nodoc
class __$NagAlertsDataCopyWithImpl<$Res>
    implements _$NagAlertsDataCopyWith<$Res> {
  __$NagAlertsDataCopyWithImpl(this._self, this._then);

  final _NagAlertsData _self;
  final $Res Function(_NagAlertsData) _then;

/// Create a copy of NagAlertsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(_NagAlertsData(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as NagDataSection?,
  ));
}

/// Create a copy of NagAlertsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NagDataSectionCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $NagDataSectionCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$NagDataSection {

 Map<String, NagAlertData?>? get hostlist; Map<String, Map<String, NagAlertData?>?>? get servicelist;
/// Create a copy of NagDataSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NagDataSectionCopyWith<NagDataSection> get copyWith => _$NagDataSectionCopyWithImpl<NagDataSection>(this as NagDataSection, _$identity);

  /// Serializes this NagDataSection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NagDataSection&&const DeepCollectionEquality().equals(other.hostlist, hostlist)&&const DeepCollectionEquality().equals(other.servicelist, servicelist));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(hostlist),const DeepCollectionEquality().hash(servicelist));

@override
String toString() {
  return 'NagDataSection(hostlist: $hostlist, servicelist: $servicelist)';
}


}

/// @nodoc
abstract mixin class $NagDataSectionCopyWith<$Res>  {
  factory $NagDataSectionCopyWith(NagDataSection value, $Res Function(NagDataSection) _then) = _$NagDataSectionCopyWithImpl;
@useResult
$Res call({
 Map<String, NagAlertData?>? hostlist, Map<String, Map<String, NagAlertData?>?>? servicelist
});




}
/// @nodoc
class _$NagDataSectionCopyWithImpl<$Res>
    implements $NagDataSectionCopyWith<$Res> {
  _$NagDataSectionCopyWithImpl(this._self, this._then);

  final NagDataSection _self;
  final $Res Function(NagDataSection) _then;

/// Create a copy of NagDataSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hostlist = freezed,Object? servicelist = freezed,}) {
  return _then(_self.copyWith(
hostlist: freezed == hostlist ? _self.hostlist : hostlist // ignore: cast_nullable_to_non_nullable
as Map<String, NagAlertData?>?,servicelist: freezed == servicelist ? _self.servicelist : servicelist // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, NagAlertData?>?>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _NagDataSection implements NagDataSection {
  const _NagDataSection({final  Map<String, NagAlertData?>? hostlist, final  Map<String, Map<String, NagAlertData?>?>? servicelist}): _hostlist = hostlist,_servicelist = servicelist;
  factory _NagDataSection.fromJson(Map<String, dynamic> json) => _$NagDataSectionFromJson(json);

 final  Map<String, NagAlertData?>? _hostlist;
@override Map<String, NagAlertData?>? get hostlist {
  final value = _hostlist;
  if (value == null) return null;
  if (_hostlist is EqualUnmodifiableMapView) return _hostlist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, Map<String, NagAlertData?>?>? _servicelist;
@override Map<String, Map<String, NagAlertData?>?>? get servicelist {
  final value = _servicelist;
  if (value == null) return null;
  if (_servicelist is EqualUnmodifiableMapView) return _servicelist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of NagDataSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NagDataSectionCopyWith<_NagDataSection> get copyWith => __$NagDataSectionCopyWithImpl<_NagDataSection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NagDataSectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NagDataSection&&const DeepCollectionEquality().equals(other._hostlist, _hostlist)&&const DeepCollectionEquality().equals(other._servicelist, _servicelist));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_hostlist),const DeepCollectionEquality().hash(_servicelist));

@override
String toString() {
  return 'NagDataSection(hostlist: $hostlist, servicelist: $servicelist)';
}


}

/// @nodoc
abstract mixin class _$NagDataSectionCopyWith<$Res> implements $NagDataSectionCopyWith<$Res> {
  factory _$NagDataSectionCopyWith(_NagDataSection value, $Res Function(_NagDataSection) _then) = __$NagDataSectionCopyWithImpl;
@override @useResult
$Res call({
 Map<String, NagAlertData?>? hostlist, Map<String, Map<String, NagAlertData?>?>? servicelist
});




}
/// @nodoc
class __$NagDataSectionCopyWithImpl<$Res>
    implements _$NagDataSectionCopyWith<$Res> {
  __$NagDataSectionCopyWithImpl(this._self, this._then);

  final _NagDataSection _self;
  final $Res Function(_NagDataSection) _then;

/// Create a copy of NagDataSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hostlist = freezed,Object? servicelist = freezed,}) {
  return _then(_NagDataSection(
hostlist: freezed == hostlist ? _self._hostlist : hostlist // ignore: cast_nullable_to_non_nullable
as Map<String, NagAlertData?>?,servicelist: freezed == servicelist ? _self._servicelist : servicelist // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, NagAlertData?>?>?,
  ));
}


}


/// @nodoc
mixin _$NagAlertData {

 String? get description; int? get status;// ignore: non_constant_identifier_names
 int? get scheduled_downtime_depth;// ignore: non_constant_identifier_names
 bool? get problem_has_been_acknowledged;// ignore: non_constant_identifier_names
 int? get last_state_change;// ignore: non_constant_identifier_names
 int? get last_hard_state_change;// ignore: non_constant_identifier_names
 int? get last_check;// ignore: non_constant_identifier_names
 int? get state_type;// ignore: non_constant_identifier_names
 String? get plugin_output;
/// Create a copy of NagAlertData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NagAlertDataCopyWith<NagAlertData> get copyWith => _$NagAlertDataCopyWithImpl<NagAlertData>(this as NagAlertData, _$identity);

  /// Serializes this NagAlertData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NagAlertData&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.scheduled_downtime_depth, scheduled_downtime_depth) || other.scheduled_downtime_depth == scheduled_downtime_depth)&&(identical(other.problem_has_been_acknowledged, problem_has_been_acknowledged) || other.problem_has_been_acknowledged == problem_has_been_acknowledged)&&(identical(other.last_state_change, last_state_change) || other.last_state_change == last_state_change)&&(identical(other.last_hard_state_change, last_hard_state_change) || other.last_hard_state_change == last_hard_state_change)&&(identical(other.last_check, last_check) || other.last_check == last_check)&&(identical(other.state_type, state_type) || other.state_type == state_type)&&(identical(other.plugin_output, plugin_output) || other.plugin_output == plugin_output));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,status,scheduled_downtime_depth,problem_has_been_acknowledged,last_state_change,last_hard_state_change,last_check,state_type,plugin_output);

@override
String toString() {
  return 'NagAlertData(description: $description, status: $status, scheduled_downtime_depth: $scheduled_downtime_depth, problem_has_been_acknowledged: $problem_has_been_acknowledged, last_state_change: $last_state_change, last_hard_state_change: $last_hard_state_change, last_check: $last_check, state_type: $state_type, plugin_output: $plugin_output)';
}


}

/// @nodoc
abstract mixin class $NagAlertDataCopyWith<$Res>  {
  factory $NagAlertDataCopyWith(NagAlertData value, $Res Function(NagAlertData) _then) = _$NagAlertDataCopyWithImpl;
@useResult
$Res call({
 String? description, int? status, int? scheduled_downtime_depth, bool? problem_has_been_acknowledged, int? last_state_change, int? last_hard_state_change, int? last_check, int? state_type, String? plugin_output
});




}
/// @nodoc
class _$NagAlertDataCopyWithImpl<$Res>
    implements $NagAlertDataCopyWith<$Res> {
  _$NagAlertDataCopyWithImpl(this._self, this._then);

  final NagAlertData _self;
  final $Res Function(NagAlertData) _then;

/// Create a copy of NagAlertData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? description = freezed,Object? status = freezed,Object? scheduled_downtime_depth = freezed,Object? problem_has_been_acknowledged = freezed,Object? last_state_change = freezed,Object? last_hard_state_change = freezed,Object? last_check = freezed,Object? state_type = freezed,Object? plugin_output = freezed,}) {
  return _then(_self.copyWith(
description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,scheduled_downtime_depth: freezed == scheduled_downtime_depth ? _self.scheduled_downtime_depth : scheduled_downtime_depth // ignore: cast_nullable_to_non_nullable
as int?,problem_has_been_acknowledged: freezed == problem_has_been_acknowledged ? _self.problem_has_been_acknowledged : problem_has_been_acknowledged // ignore: cast_nullable_to_non_nullable
as bool?,last_state_change: freezed == last_state_change ? _self.last_state_change : last_state_change // ignore: cast_nullable_to_non_nullable
as int?,last_hard_state_change: freezed == last_hard_state_change ? _self.last_hard_state_change : last_hard_state_change // ignore: cast_nullable_to_non_nullable
as int?,last_check: freezed == last_check ? _self.last_check : last_check // ignore: cast_nullable_to_non_nullable
as int?,state_type: freezed == state_type ? _self.state_type : state_type // ignore: cast_nullable_to_non_nullable
as int?,plugin_output: freezed == plugin_output ? _self.plugin_output : plugin_output // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _NagAlertData implements NagAlertData {
  const _NagAlertData({this.description, this.status, this.scheduled_downtime_depth, this.problem_has_been_acknowledged, this.last_state_change, this.last_hard_state_change, this.last_check, this.state_type, this.plugin_output});
  factory _NagAlertData.fromJson(Map<String, dynamic> json) => _$NagAlertDataFromJson(json);

@override final  String? description;
@override final  int? status;
// ignore: non_constant_identifier_names
@override final  int? scheduled_downtime_depth;
// ignore: non_constant_identifier_names
@override final  bool? problem_has_been_acknowledged;
// ignore: non_constant_identifier_names
@override final  int? last_state_change;
// ignore: non_constant_identifier_names
@override final  int? last_hard_state_change;
// ignore: non_constant_identifier_names
@override final  int? last_check;
// ignore: non_constant_identifier_names
@override final  int? state_type;
// ignore: non_constant_identifier_names
@override final  String? plugin_output;

/// Create a copy of NagAlertData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NagAlertDataCopyWith<_NagAlertData> get copyWith => __$NagAlertDataCopyWithImpl<_NagAlertData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NagAlertDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NagAlertData&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.scheduled_downtime_depth, scheduled_downtime_depth) || other.scheduled_downtime_depth == scheduled_downtime_depth)&&(identical(other.problem_has_been_acknowledged, problem_has_been_acknowledged) || other.problem_has_been_acknowledged == problem_has_been_acknowledged)&&(identical(other.last_state_change, last_state_change) || other.last_state_change == last_state_change)&&(identical(other.last_hard_state_change, last_hard_state_change) || other.last_hard_state_change == last_hard_state_change)&&(identical(other.last_check, last_check) || other.last_check == last_check)&&(identical(other.state_type, state_type) || other.state_type == state_type)&&(identical(other.plugin_output, plugin_output) || other.plugin_output == plugin_output));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,status,scheduled_downtime_depth,problem_has_been_acknowledged,last_state_change,last_hard_state_change,last_check,state_type,plugin_output);

@override
String toString() {
  return 'NagAlertData(description: $description, status: $status, scheduled_downtime_depth: $scheduled_downtime_depth, problem_has_been_acknowledged: $problem_has_been_acknowledged, last_state_change: $last_state_change, last_hard_state_change: $last_hard_state_change, last_check: $last_check, state_type: $state_type, plugin_output: $plugin_output)';
}


}

/// @nodoc
abstract mixin class _$NagAlertDataCopyWith<$Res> implements $NagAlertDataCopyWith<$Res> {
  factory _$NagAlertDataCopyWith(_NagAlertData value, $Res Function(_NagAlertData) _then) = __$NagAlertDataCopyWithImpl;
@override @useResult
$Res call({
 String? description, int? status, int? scheduled_downtime_depth, bool? problem_has_been_acknowledged, int? last_state_change, int? last_hard_state_change, int? last_check, int? state_type, String? plugin_output
});




}
/// @nodoc
class __$NagAlertDataCopyWithImpl<$Res>
    implements _$NagAlertDataCopyWith<$Res> {
  __$NagAlertDataCopyWithImpl(this._self, this._then);

  final _NagAlertData _self;
  final $Res Function(_NagAlertData) _then;

/// Create a copy of NagAlertData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? description = freezed,Object? status = freezed,Object? scheduled_downtime_depth = freezed,Object? problem_has_been_acknowledged = freezed,Object? last_state_change = freezed,Object? last_hard_state_change = freezed,Object? last_check = freezed,Object? state_type = freezed,Object? plugin_output = freezed,}) {
  return _then(_NagAlertData(
description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as int?,scheduled_downtime_depth: freezed == scheduled_downtime_depth ? _self.scheduled_downtime_depth : scheduled_downtime_depth // ignore: cast_nullable_to_non_nullable
as int?,problem_has_been_acknowledged: freezed == problem_has_been_acknowledged ? _self.problem_has_been_acknowledged : problem_has_been_acknowledged // ignore: cast_nullable_to_non_nullable
as bool?,last_state_change: freezed == last_state_change ? _self.last_state_change : last_state_change // ignore: cast_nullable_to_non_nullable
as int?,last_hard_state_change: freezed == last_hard_state_change ? _self.last_hard_state_change : last_hard_state_change // ignore: cast_nullable_to_non_nullable
as int?,last_check: freezed == last_check ? _self.last_check : last_check // ignore: cast_nullable_to_non_nullable
as int?,state_type: freezed == state_type ? _self.state_type : state_type // ignore: cast_nullable_to_non_nullable
as int?,plugin_output: freezed == plugin_output ? _self.plugin_output : plugin_output // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

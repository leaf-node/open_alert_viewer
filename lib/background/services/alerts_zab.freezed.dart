// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alerts_zab.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ZabAlertsData {

 List<ZabAlertData>? get result;
/// Create a copy of ZabAlertsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZabAlertsDataCopyWith<ZabAlertsData> get copyWith => _$ZabAlertsDataCopyWithImpl<ZabAlertsData>(this as ZabAlertsData, _$identity);

  /// Serializes this ZabAlertsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZabAlertsData&&const DeepCollectionEquality().equals(other.result, result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(result));

@override
String toString() {
  return 'ZabAlertsData(result: $result)';
}


}

/// @nodoc
abstract mixin class $ZabAlertsDataCopyWith<$Res>  {
  factory $ZabAlertsDataCopyWith(ZabAlertsData value, $Res Function(ZabAlertsData) _then) = _$ZabAlertsDataCopyWithImpl;
@useResult
$Res call({
 List<ZabAlertData>? result
});




}
/// @nodoc
class _$ZabAlertsDataCopyWithImpl<$Res>
    implements $ZabAlertsDataCopyWith<$Res> {
  _$ZabAlertsDataCopyWithImpl(this._self, this._then);

  final ZabAlertsData _self;
  final $Res Function(ZabAlertsData) _then;

/// Create a copy of ZabAlertsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? result = freezed,}) {
  return _then(_self.copyWith(
result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as List<ZabAlertData>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ZabAlertsData implements ZabAlertsData {
  const _ZabAlertsData({final  List<ZabAlertData>? result}): _result = result;
  factory _ZabAlertsData.fromJson(Map<String, dynamic> json) => _$ZabAlertsDataFromJson(json);

 final  List<ZabAlertData>? _result;
@override List<ZabAlertData>? get result {
  final value = _result;
  if (value == null) return null;
  if (_result is EqualUnmodifiableListView) return _result;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ZabAlertsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZabAlertsDataCopyWith<_ZabAlertsData> get copyWith => __$ZabAlertsDataCopyWithImpl<_ZabAlertsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ZabAlertsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZabAlertsData&&const DeepCollectionEquality().equals(other._result, _result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_result));

@override
String toString() {
  return 'ZabAlertsData(result: $result)';
}


}

/// @nodoc
abstract mixin class _$ZabAlertsDataCopyWith<$Res> implements $ZabAlertsDataCopyWith<$Res> {
  factory _$ZabAlertsDataCopyWith(_ZabAlertsData value, $Res Function(_ZabAlertsData) _then) = __$ZabAlertsDataCopyWithImpl;
@override @useResult
$Res call({
 List<ZabAlertData>? result
});




}
/// @nodoc
class __$ZabAlertsDataCopyWithImpl<$Res>
    implements _$ZabAlertsDataCopyWith<$Res> {
  __$ZabAlertsDataCopyWithImpl(this._self, this._then);

  final _ZabAlertsData _self;
  final $Res Function(_ZabAlertsData) _then;

/// Create a copy of ZabAlertsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? result = freezed,}) {
  return _then(_ZabAlertsData(
result: freezed == result ? _self._result : result // ignore: cast_nullable_to_non_nullable
as List<ZabAlertData>?,
  ));
}


}


/// @nodoc
mixin _$ZabAlertData {

 String? get name; String? get clock; String? get opdata; String? get severity; String? get suppressed; String? get acknowledged; List<ZabHostsData>? get hosts;
/// Create a copy of ZabAlertData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZabAlertDataCopyWith<ZabAlertData> get copyWith => _$ZabAlertDataCopyWithImpl<ZabAlertData>(this as ZabAlertData, _$identity);

  /// Serializes this ZabAlertData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZabAlertData&&(identical(other.name, name) || other.name == name)&&(identical(other.clock, clock) || other.clock == clock)&&(identical(other.opdata, opdata) || other.opdata == opdata)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.suppressed, suppressed) || other.suppressed == suppressed)&&(identical(other.acknowledged, acknowledged) || other.acknowledged == acknowledged)&&const DeepCollectionEquality().equals(other.hosts, hosts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,clock,opdata,severity,suppressed,acknowledged,const DeepCollectionEquality().hash(hosts));

@override
String toString() {
  return 'ZabAlertData(name: $name, clock: $clock, opdata: $opdata, severity: $severity, suppressed: $suppressed, acknowledged: $acknowledged, hosts: $hosts)';
}


}

/// @nodoc
abstract mixin class $ZabAlertDataCopyWith<$Res>  {
  factory $ZabAlertDataCopyWith(ZabAlertData value, $Res Function(ZabAlertData) _then) = _$ZabAlertDataCopyWithImpl;
@useResult
$Res call({
 String? name, String? clock, String? opdata, String? severity, String? suppressed, String? acknowledged, List<ZabHostsData>? hosts
});




}
/// @nodoc
class _$ZabAlertDataCopyWithImpl<$Res>
    implements $ZabAlertDataCopyWith<$Res> {
  _$ZabAlertDataCopyWithImpl(this._self, this._then);

  final ZabAlertData _self;
  final $Res Function(ZabAlertData) _then;

/// Create a copy of ZabAlertData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? clock = freezed,Object? opdata = freezed,Object? severity = freezed,Object? suppressed = freezed,Object? acknowledged = freezed,Object? hosts = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,clock: freezed == clock ? _self.clock : clock // ignore: cast_nullable_to_non_nullable
as String?,opdata: freezed == opdata ? _self.opdata : opdata // ignore: cast_nullable_to_non_nullable
as String?,severity: freezed == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String?,suppressed: freezed == suppressed ? _self.suppressed : suppressed // ignore: cast_nullable_to_non_nullable
as String?,acknowledged: freezed == acknowledged ? _self.acknowledged : acknowledged // ignore: cast_nullable_to_non_nullable
as String?,hosts: freezed == hosts ? _self.hosts : hosts // ignore: cast_nullable_to_non_nullable
as List<ZabHostsData>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ZabAlertData implements ZabAlertData {
  const _ZabAlertData({this.name, this.clock, this.opdata, this.severity, this.suppressed, this.acknowledged, final  List<ZabHostsData>? hosts}): _hosts = hosts;
  factory _ZabAlertData.fromJson(Map<String, dynamic> json) => _$ZabAlertDataFromJson(json);

@override final  String? name;
@override final  String? clock;
@override final  String? opdata;
@override final  String? severity;
@override final  String? suppressed;
@override final  String? acknowledged;
 final  List<ZabHostsData>? _hosts;
@override List<ZabHostsData>? get hosts {
  final value = _hosts;
  if (value == null) return null;
  if (_hosts is EqualUnmodifiableListView) return _hosts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ZabAlertData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZabAlertDataCopyWith<_ZabAlertData> get copyWith => __$ZabAlertDataCopyWithImpl<_ZabAlertData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ZabAlertDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZabAlertData&&(identical(other.name, name) || other.name == name)&&(identical(other.clock, clock) || other.clock == clock)&&(identical(other.opdata, opdata) || other.opdata == opdata)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.suppressed, suppressed) || other.suppressed == suppressed)&&(identical(other.acknowledged, acknowledged) || other.acknowledged == acknowledged)&&const DeepCollectionEquality().equals(other._hosts, _hosts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,clock,opdata,severity,suppressed,acknowledged,const DeepCollectionEquality().hash(_hosts));

@override
String toString() {
  return 'ZabAlertData(name: $name, clock: $clock, opdata: $opdata, severity: $severity, suppressed: $suppressed, acknowledged: $acknowledged, hosts: $hosts)';
}


}

/// @nodoc
abstract mixin class _$ZabAlertDataCopyWith<$Res> implements $ZabAlertDataCopyWith<$Res> {
  factory _$ZabAlertDataCopyWith(_ZabAlertData value, $Res Function(_ZabAlertData) _then) = __$ZabAlertDataCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? clock, String? opdata, String? severity, String? suppressed, String? acknowledged, List<ZabHostsData>? hosts
});




}
/// @nodoc
class __$ZabAlertDataCopyWithImpl<$Res>
    implements _$ZabAlertDataCopyWith<$Res> {
  __$ZabAlertDataCopyWithImpl(this._self, this._then);

  final _ZabAlertData _self;
  final $Res Function(_ZabAlertData) _then;

/// Create a copy of ZabAlertData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? clock = freezed,Object? opdata = freezed,Object? severity = freezed,Object? suppressed = freezed,Object? acknowledged = freezed,Object? hosts = freezed,}) {
  return _then(_ZabAlertData(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,clock: freezed == clock ? _self.clock : clock // ignore: cast_nullable_to_non_nullable
as String?,opdata: freezed == opdata ? _self.opdata : opdata // ignore: cast_nullable_to_non_nullable
as String?,severity: freezed == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String?,suppressed: freezed == suppressed ? _self.suppressed : suppressed // ignore: cast_nullable_to_non_nullable
as String?,acknowledged: freezed == acknowledged ? _self.acknowledged : acknowledged // ignore: cast_nullable_to_non_nullable
as String?,hosts: freezed == hosts ? _self._hosts : hosts // ignore: cast_nullable_to_non_nullable
as List<ZabHostsData>?,
  ));
}


}


/// @nodoc
mixin _$ZabHostsData {

 String? get host; String? get name;
/// Create a copy of ZabHostsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZabHostsDataCopyWith<ZabHostsData> get copyWith => _$ZabHostsDataCopyWithImpl<ZabHostsData>(this as ZabHostsData, _$identity);

  /// Serializes this ZabHostsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZabHostsData&&(identical(other.host, host) || other.host == host)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,host,name);

@override
String toString() {
  return 'ZabHostsData(host: $host, name: $name)';
}


}

/// @nodoc
abstract mixin class $ZabHostsDataCopyWith<$Res>  {
  factory $ZabHostsDataCopyWith(ZabHostsData value, $Res Function(ZabHostsData) _then) = _$ZabHostsDataCopyWithImpl;
@useResult
$Res call({
 String? host, String? name
});




}
/// @nodoc
class _$ZabHostsDataCopyWithImpl<$Res>
    implements $ZabHostsDataCopyWith<$Res> {
  _$ZabHostsDataCopyWithImpl(this._self, this._then);

  final ZabHostsData _self;
  final $Res Function(ZabHostsData) _then;

/// Create a copy of ZabHostsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? host = freezed,Object? name = freezed,}) {
  return _then(_self.copyWith(
host: freezed == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ZabHostsData implements ZabHostsData {
  const _ZabHostsData({this.host, this.name});
  factory _ZabHostsData.fromJson(Map<String, dynamic> json) => _$ZabHostsDataFromJson(json);

@override final  String? host;
@override final  String? name;

/// Create a copy of ZabHostsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZabHostsDataCopyWith<_ZabHostsData> get copyWith => __$ZabHostsDataCopyWithImpl<_ZabHostsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ZabHostsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZabHostsData&&(identical(other.host, host) || other.host == host)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,host,name);

@override
String toString() {
  return 'ZabHostsData(host: $host, name: $name)';
}


}

/// @nodoc
abstract mixin class _$ZabHostsDataCopyWith<$Res> implements $ZabHostsDataCopyWith<$Res> {
  factory _$ZabHostsDataCopyWith(_ZabHostsData value, $Res Function(_ZabHostsData) _then) = __$ZabHostsDataCopyWithImpl;
@override @useResult
$Res call({
 String? host, String? name
});




}
/// @nodoc
class __$ZabHostsDataCopyWithImpl<$Res>
    implements _$ZabHostsDataCopyWith<$Res> {
  __$ZabHostsDataCopyWithImpl(this._self, this._then);

  final _ZabHostsData _self;
  final $Res Function(_ZabHostsData) _then;

/// Create a copy of ZabHostsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? host = freezed,Object? name = freezed,}) {
  return _then(_ZabHostsData(
host: freezed == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

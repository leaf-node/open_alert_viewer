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
mixin _$ZabEventsData {

 List<ZabEventData>? get result; ZabErrorData? get error;
/// Create a copy of ZabEventsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZabEventsDataCopyWith<ZabEventsData> get copyWith => _$ZabEventsDataCopyWithImpl<ZabEventsData>(this as ZabEventsData, _$identity);

  /// Serializes this ZabEventsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZabEventsData&&const DeepCollectionEquality().equals(other.result, result)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(result),error);

@override
String toString() {
  return 'ZabEventsData(result: $result, error: $error)';
}


}

/// @nodoc
abstract mixin class $ZabEventsDataCopyWith<$Res>  {
  factory $ZabEventsDataCopyWith(ZabEventsData value, $Res Function(ZabEventsData) _then) = _$ZabEventsDataCopyWithImpl;
@useResult
$Res call({
 List<ZabEventData>? result, ZabErrorData? error
});


$ZabErrorDataCopyWith<$Res>? get error;

}
/// @nodoc
class _$ZabEventsDataCopyWithImpl<$Res>
    implements $ZabEventsDataCopyWith<$Res> {
  _$ZabEventsDataCopyWithImpl(this._self, this._then);

  final ZabEventsData _self;
  final $Res Function(ZabEventsData) _then;

/// Create a copy of ZabEventsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? result = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as List<ZabEventData>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ZabErrorData?,
  ));
}
/// Create a copy of ZabEventsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZabErrorDataCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $ZabErrorDataCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _ZabEventsData implements ZabEventsData {
  const _ZabEventsData({final  List<ZabEventData>? result, this.error}): _result = result;
  factory _ZabEventsData.fromJson(Map<String, dynamic> json) => _$ZabEventsDataFromJson(json);

 final  List<ZabEventData>? _result;
@override List<ZabEventData>? get result {
  final value = _result;
  if (value == null) return null;
  if (_result is EqualUnmodifiableListView) return _result;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  ZabErrorData? error;

/// Create a copy of ZabEventsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZabEventsDataCopyWith<_ZabEventsData> get copyWith => __$ZabEventsDataCopyWithImpl<_ZabEventsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ZabEventsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZabEventsData&&const DeepCollectionEquality().equals(other._result, _result)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_result),error);

@override
String toString() {
  return 'ZabEventsData(result: $result, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ZabEventsDataCopyWith<$Res> implements $ZabEventsDataCopyWith<$Res> {
  factory _$ZabEventsDataCopyWith(_ZabEventsData value, $Res Function(_ZabEventsData) _then) = __$ZabEventsDataCopyWithImpl;
@override @useResult
$Res call({
 List<ZabEventData>? result, ZabErrorData? error
});


@override $ZabErrorDataCopyWith<$Res>? get error;

}
/// @nodoc
class __$ZabEventsDataCopyWithImpl<$Res>
    implements _$ZabEventsDataCopyWith<$Res> {
  __$ZabEventsDataCopyWithImpl(this._self, this._then);

  final _ZabEventsData _self;
  final $Res Function(_ZabEventsData) _then;

/// Create a copy of ZabEventsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? result = freezed,Object? error = freezed,}) {
  return _then(_ZabEventsData(
result: freezed == result ? _self._result : result // ignore: cast_nullable_to_non_nullable
as List<ZabEventData>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ZabErrorData?,
  ));
}

/// Create a copy of ZabEventsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZabErrorDataCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $ZabErrorDataCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// @nodoc
mixin _$ZabEventData {

 String? get name; String? get clock; String? get opdata; String? get severity; String? get objectid; String? get suppressed; String? get acknowledged; List<ZabHostData>? get hosts;
/// Create a copy of ZabEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZabEventDataCopyWith<ZabEventData> get copyWith => _$ZabEventDataCopyWithImpl<ZabEventData>(this as ZabEventData, _$identity);

  /// Serializes this ZabEventData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZabEventData&&(identical(other.name, name) || other.name == name)&&(identical(other.clock, clock) || other.clock == clock)&&(identical(other.opdata, opdata) || other.opdata == opdata)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.objectid, objectid) || other.objectid == objectid)&&(identical(other.suppressed, suppressed) || other.suppressed == suppressed)&&(identical(other.acknowledged, acknowledged) || other.acknowledged == acknowledged)&&const DeepCollectionEquality().equals(other.hosts, hosts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,clock,opdata,severity,objectid,suppressed,acknowledged,const DeepCollectionEquality().hash(hosts));

@override
String toString() {
  return 'ZabEventData(name: $name, clock: $clock, opdata: $opdata, severity: $severity, objectid: $objectid, suppressed: $suppressed, acknowledged: $acknowledged, hosts: $hosts)';
}


}

/// @nodoc
abstract mixin class $ZabEventDataCopyWith<$Res>  {
  factory $ZabEventDataCopyWith(ZabEventData value, $Res Function(ZabEventData) _then) = _$ZabEventDataCopyWithImpl;
@useResult
$Res call({
 String? name, String? clock, String? opdata, String? severity, String? objectid, String? suppressed, String? acknowledged, List<ZabHostData>? hosts
});




}
/// @nodoc
class _$ZabEventDataCopyWithImpl<$Res>
    implements $ZabEventDataCopyWith<$Res> {
  _$ZabEventDataCopyWithImpl(this._self, this._then);

  final ZabEventData _self;
  final $Res Function(ZabEventData) _then;

/// Create a copy of ZabEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? clock = freezed,Object? opdata = freezed,Object? severity = freezed,Object? objectid = freezed,Object? suppressed = freezed,Object? acknowledged = freezed,Object? hosts = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,clock: freezed == clock ? _self.clock : clock // ignore: cast_nullable_to_non_nullable
as String?,opdata: freezed == opdata ? _self.opdata : opdata // ignore: cast_nullable_to_non_nullable
as String?,severity: freezed == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String?,objectid: freezed == objectid ? _self.objectid : objectid // ignore: cast_nullable_to_non_nullable
as String?,suppressed: freezed == suppressed ? _self.suppressed : suppressed // ignore: cast_nullable_to_non_nullable
as String?,acknowledged: freezed == acknowledged ? _self.acknowledged : acknowledged // ignore: cast_nullable_to_non_nullable
as String?,hosts: freezed == hosts ? _self.hosts : hosts // ignore: cast_nullable_to_non_nullable
as List<ZabHostData>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ZabEventData implements ZabEventData {
  const _ZabEventData({this.name, this.clock, this.opdata, this.severity, this.objectid, this.suppressed, this.acknowledged, final  List<ZabHostData>? hosts}): _hosts = hosts;
  factory _ZabEventData.fromJson(Map<String, dynamic> json) => _$ZabEventDataFromJson(json);

@override final  String? name;
@override final  String? clock;
@override final  String? opdata;
@override final  String? severity;
@override final  String? objectid;
@override final  String? suppressed;
@override final  String? acknowledged;
 final  List<ZabHostData>? _hosts;
@override List<ZabHostData>? get hosts {
  final value = _hosts;
  if (value == null) return null;
  if (_hosts is EqualUnmodifiableListView) return _hosts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ZabEventData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZabEventDataCopyWith<_ZabEventData> get copyWith => __$ZabEventDataCopyWithImpl<_ZabEventData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ZabEventDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZabEventData&&(identical(other.name, name) || other.name == name)&&(identical(other.clock, clock) || other.clock == clock)&&(identical(other.opdata, opdata) || other.opdata == opdata)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.objectid, objectid) || other.objectid == objectid)&&(identical(other.suppressed, suppressed) || other.suppressed == suppressed)&&(identical(other.acknowledged, acknowledged) || other.acknowledged == acknowledged)&&const DeepCollectionEquality().equals(other._hosts, _hosts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,clock,opdata,severity,objectid,suppressed,acknowledged,const DeepCollectionEquality().hash(_hosts));

@override
String toString() {
  return 'ZabEventData(name: $name, clock: $clock, opdata: $opdata, severity: $severity, objectid: $objectid, suppressed: $suppressed, acknowledged: $acknowledged, hosts: $hosts)';
}


}

/// @nodoc
abstract mixin class _$ZabEventDataCopyWith<$Res> implements $ZabEventDataCopyWith<$Res> {
  factory _$ZabEventDataCopyWith(_ZabEventData value, $Res Function(_ZabEventData) _then) = __$ZabEventDataCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? clock, String? opdata, String? severity, String? objectid, String? suppressed, String? acknowledged, List<ZabHostData>? hosts
});




}
/// @nodoc
class __$ZabEventDataCopyWithImpl<$Res>
    implements _$ZabEventDataCopyWith<$Res> {
  __$ZabEventDataCopyWithImpl(this._self, this._then);

  final _ZabEventData _self;
  final $Res Function(_ZabEventData) _then;

/// Create a copy of ZabEventData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? clock = freezed,Object? opdata = freezed,Object? severity = freezed,Object? objectid = freezed,Object? suppressed = freezed,Object? acknowledged = freezed,Object? hosts = freezed,}) {
  return _then(_ZabEventData(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,clock: freezed == clock ? _self.clock : clock // ignore: cast_nullable_to_non_nullable
as String?,opdata: freezed == opdata ? _self.opdata : opdata // ignore: cast_nullable_to_non_nullable
as String?,severity: freezed == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String?,objectid: freezed == objectid ? _self.objectid : objectid // ignore: cast_nullable_to_non_nullable
as String?,suppressed: freezed == suppressed ? _self.suppressed : suppressed // ignore: cast_nullable_to_non_nullable
as String?,acknowledged: freezed == acknowledged ? _self.acknowledged : acknowledged // ignore: cast_nullable_to_non_nullable
as String?,hosts: freezed == hosts ? _self._hosts : hosts // ignore: cast_nullable_to_non_nullable
as List<ZabHostData>?,
  ));
}


}


/// @nodoc
mixin _$ZabHostData {

 String? get host; String? get name; String? get status;
/// Create a copy of ZabHostData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZabHostDataCopyWith<ZabHostData> get copyWith => _$ZabHostDataCopyWithImpl<ZabHostData>(this as ZabHostData, _$identity);

  /// Serializes this ZabHostData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZabHostData&&(identical(other.host, host) || other.host == host)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,host,name,status);

@override
String toString() {
  return 'ZabHostData(host: $host, name: $name, status: $status)';
}


}

/// @nodoc
abstract mixin class $ZabHostDataCopyWith<$Res>  {
  factory $ZabHostDataCopyWith(ZabHostData value, $Res Function(ZabHostData) _then) = _$ZabHostDataCopyWithImpl;
@useResult
$Res call({
 String? host, String? name, String? status
});




}
/// @nodoc
class _$ZabHostDataCopyWithImpl<$Res>
    implements $ZabHostDataCopyWith<$Res> {
  _$ZabHostDataCopyWithImpl(this._self, this._then);

  final ZabHostData _self;
  final $Res Function(ZabHostData) _then;

/// Create a copy of ZabHostData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? host = freezed,Object? name = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
host: freezed == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ZabHostData implements ZabHostData {
  const _ZabHostData({this.host, this.name, this.status});
  factory _ZabHostData.fromJson(Map<String, dynamic> json) => _$ZabHostDataFromJson(json);

@override final  String? host;
@override final  String? name;
@override final  String? status;

/// Create a copy of ZabHostData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZabHostDataCopyWith<_ZabHostData> get copyWith => __$ZabHostDataCopyWithImpl<_ZabHostData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ZabHostDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZabHostData&&(identical(other.host, host) || other.host == host)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,host,name,status);

@override
String toString() {
  return 'ZabHostData(host: $host, name: $name, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ZabHostDataCopyWith<$Res> implements $ZabHostDataCopyWith<$Res> {
  factory _$ZabHostDataCopyWith(_ZabHostData value, $Res Function(_ZabHostData) _then) = __$ZabHostDataCopyWithImpl;
@override @useResult
$Res call({
 String? host, String? name, String? status
});




}
/// @nodoc
class __$ZabHostDataCopyWithImpl<$Res>
    implements _$ZabHostDataCopyWith<$Res> {
  __$ZabHostDataCopyWithImpl(this._self, this._then);

  final _ZabHostData _self;
  final $Res Function(_ZabHostData) _then;

/// Create a copy of ZabHostData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? host = freezed,Object? name = freezed,Object? status = freezed,}) {
  return _then(_ZabHostData(
host: freezed == host ? _self.host : host // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ZabErrorData {

 String? get message; String? get data;
/// Create a copy of ZabErrorData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZabErrorDataCopyWith<ZabErrorData> get copyWith => _$ZabErrorDataCopyWithImpl<ZabErrorData>(this as ZabErrorData, _$identity);

  /// Serializes this ZabErrorData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZabErrorData&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,data);

@override
String toString() {
  return 'ZabErrorData(message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $ZabErrorDataCopyWith<$Res>  {
  factory $ZabErrorDataCopyWith(ZabErrorData value, $Res Function(ZabErrorData) _then) = _$ZabErrorDataCopyWithImpl;
@useResult
$Res call({
 String? message, String? data
});




}
/// @nodoc
class _$ZabErrorDataCopyWithImpl<$Res>
    implements $ZabErrorDataCopyWith<$Res> {
  _$ZabErrorDataCopyWithImpl(this._self, this._then);

  final ZabErrorData _self;
  final $Res Function(ZabErrorData) _then;

/// Create a copy of ZabErrorData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ZabErrorData implements ZabErrorData {
  const _ZabErrorData({this.message, this.data});
  factory _ZabErrorData.fromJson(Map<String, dynamic> json) => _$ZabErrorDataFromJson(json);

@override final  String? message;
@override final  String? data;

/// Create a copy of ZabErrorData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZabErrorDataCopyWith<_ZabErrorData> get copyWith => __$ZabErrorDataCopyWithImpl<_ZabErrorData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ZabErrorDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZabErrorData&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,data);

@override
String toString() {
  return 'ZabErrorData(message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ZabErrorDataCopyWith<$Res> implements $ZabErrorDataCopyWith<$Res> {
  factory _$ZabErrorDataCopyWith(_ZabErrorData value, $Res Function(_ZabErrorData) _then) = __$ZabErrorDataCopyWithImpl;
@override @useResult
$Res call({
 String? message, String? data
});




}
/// @nodoc
class __$ZabErrorDataCopyWithImpl<$Res>
    implements _$ZabErrorDataCopyWith<$Res> {
  __$ZabErrorDataCopyWithImpl(this._self, this._then);

  final _ZabErrorData _self;
  final $Res Function(_ZabErrorData) _then;

/// Create a copy of ZabErrorData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,Object? data = freezed,}) {
  return _then(_ZabErrorData(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ZabVersionData {

 String? get result;
/// Create a copy of ZabVersionData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZabVersionDataCopyWith<ZabVersionData> get copyWith => _$ZabVersionDataCopyWithImpl<ZabVersionData>(this as ZabVersionData, _$identity);

  /// Serializes this ZabVersionData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZabVersionData&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,result);

@override
String toString() {
  return 'ZabVersionData(result: $result)';
}


}

/// @nodoc
abstract mixin class $ZabVersionDataCopyWith<$Res>  {
  factory $ZabVersionDataCopyWith(ZabVersionData value, $Res Function(ZabVersionData) _then) = _$ZabVersionDataCopyWithImpl;
@useResult
$Res call({
 String? result
});




}
/// @nodoc
class _$ZabVersionDataCopyWithImpl<$Res>
    implements $ZabVersionDataCopyWith<$Res> {
  _$ZabVersionDataCopyWithImpl(this._self, this._then);

  final ZabVersionData _self;
  final $Res Function(ZabVersionData) _then;

/// Create a copy of ZabVersionData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? result = freezed,}) {
  return _then(_self.copyWith(
result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ZabVersionData implements ZabVersionData {
  const _ZabVersionData({this.result});
  factory _ZabVersionData.fromJson(Map<String, dynamic> json) => _$ZabVersionDataFromJson(json);

@override final  String? result;

/// Create a copy of ZabVersionData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZabVersionDataCopyWith<_ZabVersionData> get copyWith => __$ZabVersionDataCopyWithImpl<_ZabVersionData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ZabVersionDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZabVersionData&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,result);

@override
String toString() {
  return 'ZabVersionData(result: $result)';
}


}

/// @nodoc
abstract mixin class _$ZabVersionDataCopyWith<$Res> implements $ZabVersionDataCopyWith<$Res> {
  factory _$ZabVersionDataCopyWith(_ZabVersionData value, $Res Function(_ZabVersionData) _then) = __$ZabVersionDataCopyWithImpl;
@override @useResult
$Res call({
 String? result
});




}
/// @nodoc
class __$ZabVersionDataCopyWithImpl<$Res>
    implements _$ZabVersionDataCopyWith<$Res> {
  __$ZabVersionDataCopyWithImpl(this._self, this._then);

  final _ZabVersionData _self;
  final $Res Function(_ZabVersionData) _then;

/// Create a copy of ZabVersionData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? result = freezed,}) {
  return _then(_ZabVersionData(
result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ZabProblemsData {

 List<ZabProblemData>? get result; ZabErrorData? get error;
/// Create a copy of ZabProblemsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZabProblemsDataCopyWith<ZabProblemsData> get copyWith => _$ZabProblemsDataCopyWithImpl<ZabProblemsData>(this as ZabProblemsData, _$identity);

  /// Serializes this ZabProblemsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZabProblemsData&&const DeepCollectionEquality().equals(other.result, result)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(result),error);

@override
String toString() {
  return 'ZabProblemsData(result: $result, error: $error)';
}


}

/// @nodoc
abstract mixin class $ZabProblemsDataCopyWith<$Res>  {
  factory $ZabProblemsDataCopyWith(ZabProblemsData value, $Res Function(ZabProblemsData) _then) = _$ZabProblemsDataCopyWithImpl;
@useResult
$Res call({
 List<ZabProblemData>? result, ZabErrorData? error
});


$ZabErrorDataCopyWith<$Res>? get error;

}
/// @nodoc
class _$ZabProblemsDataCopyWithImpl<$Res>
    implements $ZabProblemsDataCopyWith<$Res> {
  _$ZabProblemsDataCopyWithImpl(this._self, this._then);

  final ZabProblemsData _self;
  final $Res Function(ZabProblemsData) _then;

/// Create a copy of ZabProblemsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? result = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as List<ZabProblemData>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ZabErrorData?,
  ));
}
/// Create a copy of ZabProblemsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZabErrorDataCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $ZabErrorDataCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _ZabProblemsData implements ZabProblemsData {
  const _ZabProblemsData({final  List<ZabProblemData>? result, this.error}): _result = result;
  factory _ZabProblemsData.fromJson(Map<String, dynamic> json) => _$ZabProblemsDataFromJson(json);

 final  List<ZabProblemData>? _result;
@override List<ZabProblemData>? get result {
  final value = _result;
  if (value == null) return null;
  if (_result is EqualUnmodifiableListView) return _result;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  ZabErrorData? error;

/// Create a copy of ZabProblemsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZabProblemsDataCopyWith<_ZabProblemsData> get copyWith => __$ZabProblemsDataCopyWithImpl<_ZabProblemsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ZabProblemsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZabProblemsData&&const DeepCollectionEquality().equals(other._result, _result)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_result),error);

@override
String toString() {
  return 'ZabProblemsData(result: $result, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ZabProblemsDataCopyWith<$Res> implements $ZabProblemsDataCopyWith<$Res> {
  factory _$ZabProblemsDataCopyWith(_ZabProblemsData value, $Res Function(_ZabProblemsData) _then) = __$ZabProblemsDataCopyWithImpl;
@override @useResult
$Res call({
 List<ZabProblemData>? result, ZabErrorData? error
});


@override $ZabErrorDataCopyWith<$Res>? get error;

}
/// @nodoc
class __$ZabProblemsDataCopyWithImpl<$Res>
    implements _$ZabProblemsDataCopyWith<$Res> {
  __$ZabProblemsDataCopyWithImpl(this._self, this._then);

  final _ZabProblemsData _self;
  final $Res Function(_ZabProblemsData) _then;

/// Create a copy of ZabProblemsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? result = freezed,Object? error = freezed,}) {
  return _then(_ZabProblemsData(
result: freezed == result ? _self._result : result // ignore: cast_nullable_to_non_nullable
as List<ZabProblemData>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ZabErrorData?,
  ));
}

/// Create a copy of ZabProblemsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZabErrorDataCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $ZabErrorDataCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// @nodoc
mixin _$ZabProblemData {

 String? get eventid; String? get objectid;
/// Create a copy of ZabProblemData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZabProblemDataCopyWith<ZabProblemData> get copyWith => _$ZabProblemDataCopyWithImpl<ZabProblemData>(this as ZabProblemData, _$identity);

  /// Serializes this ZabProblemData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZabProblemData&&(identical(other.eventid, eventid) || other.eventid == eventid)&&(identical(other.objectid, objectid) || other.objectid == objectid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventid,objectid);

@override
String toString() {
  return 'ZabProblemData(eventid: $eventid, objectid: $objectid)';
}


}

/// @nodoc
abstract mixin class $ZabProblemDataCopyWith<$Res>  {
  factory $ZabProblemDataCopyWith(ZabProblemData value, $Res Function(ZabProblemData) _then) = _$ZabProblemDataCopyWithImpl;
@useResult
$Res call({
 String? eventid, String? objectid
});




}
/// @nodoc
class _$ZabProblemDataCopyWithImpl<$Res>
    implements $ZabProblemDataCopyWith<$Res> {
  _$ZabProblemDataCopyWithImpl(this._self, this._then);

  final ZabProblemData _self;
  final $Res Function(ZabProblemData) _then;

/// Create a copy of ZabProblemData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventid = freezed,Object? objectid = freezed,}) {
  return _then(_self.copyWith(
eventid: freezed == eventid ? _self.eventid : eventid // ignore: cast_nullable_to_non_nullable
as String?,objectid: freezed == objectid ? _self.objectid : objectid // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ZabProblemData implements ZabProblemData {
  const _ZabProblemData({this.eventid, this.objectid});
  factory _ZabProblemData.fromJson(Map<String, dynamic> json) => _$ZabProblemDataFromJson(json);

@override final  String? eventid;
@override final  String? objectid;

/// Create a copy of ZabProblemData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZabProblemDataCopyWith<_ZabProblemData> get copyWith => __$ZabProblemDataCopyWithImpl<_ZabProblemData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ZabProblemDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZabProblemData&&(identical(other.eventid, eventid) || other.eventid == eventid)&&(identical(other.objectid, objectid) || other.objectid == objectid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventid,objectid);

@override
String toString() {
  return 'ZabProblemData(eventid: $eventid, objectid: $objectid)';
}


}

/// @nodoc
abstract mixin class _$ZabProblemDataCopyWith<$Res> implements $ZabProblemDataCopyWith<$Res> {
  factory _$ZabProblemDataCopyWith(_ZabProblemData value, $Res Function(_ZabProblemData) _then) = __$ZabProblemDataCopyWithImpl;
@override @useResult
$Res call({
 String? eventid, String? objectid
});




}
/// @nodoc
class __$ZabProblemDataCopyWithImpl<$Res>
    implements _$ZabProblemDataCopyWith<$Res> {
  __$ZabProblemDataCopyWithImpl(this._self, this._then);

  final _ZabProblemData _self;
  final $Res Function(_ZabProblemData) _then;

/// Create a copy of ZabProblemData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventid = freezed,Object? objectid = freezed,}) {
  return _then(_ZabProblemData(
eventid: freezed == eventid ? _self.eventid : eventid // ignore: cast_nullable_to_non_nullable
as String?,objectid: freezed == objectid ? _self.objectid : objectid // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ZabTriggersData {

 List<ZabTriggerData>? get result; ZabErrorData? get error;
/// Create a copy of ZabTriggersData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZabTriggersDataCopyWith<ZabTriggersData> get copyWith => _$ZabTriggersDataCopyWithImpl<ZabTriggersData>(this as ZabTriggersData, _$identity);

  /// Serializes this ZabTriggersData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZabTriggersData&&const DeepCollectionEquality().equals(other.result, result)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(result),error);

@override
String toString() {
  return 'ZabTriggersData(result: $result, error: $error)';
}


}

/// @nodoc
abstract mixin class $ZabTriggersDataCopyWith<$Res>  {
  factory $ZabTriggersDataCopyWith(ZabTriggersData value, $Res Function(ZabTriggersData) _then) = _$ZabTriggersDataCopyWithImpl;
@useResult
$Res call({
 List<ZabTriggerData>? result, ZabErrorData? error
});


$ZabErrorDataCopyWith<$Res>? get error;

}
/// @nodoc
class _$ZabTriggersDataCopyWithImpl<$Res>
    implements $ZabTriggersDataCopyWith<$Res> {
  _$ZabTriggersDataCopyWithImpl(this._self, this._then);

  final ZabTriggersData _self;
  final $Res Function(ZabTriggersData) _then;

/// Create a copy of ZabTriggersData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? result = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as List<ZabTriggerData>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ZabErrorData?,
  ));
}
/// Create a copy of ZabTriggersData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZabErrorDataCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $ZabErrorDataCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _ZabTriggersData implements ZabTriggersData {
  const _ZabTriggersData({final  List<ZabTriggerData>? result, this.error}): _result = result;
  factory _ZabTriggersData.fromJson(Map<String, dynamic> json) => _$ZabTriggersDataFromJson(json);

 final  List<ZabTriggerData>? _result;
@override List<ZabTriggerData>? get result {
  final value = _result;
  if (value == null) return null;
  if (_result is EqualUnmodifiableListView) return _result;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  ZabErrorData? error;

/// Create a copy of ZabTriggersData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZabTriggersDataCopyWith<_ZabTriggersData> get copyWith => __$ZabTriggersDataCopyWithImpl<_ZabTriggersData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ZabTriggersDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZabTriggersData&&const DeepCollectionEquality().equals(other._result, _result)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_result),error);

@override
String toString() {
  return 'ZabTriggersData(result: $result, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ZabTriggersDataCopyWith<$Res> implements $ZabTriggersDataCopyWith<$Res> {
  factory _$ZabTriggersDataCopyWith(_ZabTriggersData value, $Res Function(_ZabTriggersData) _then) = __$ZabTriggersDataCopyWithImpl;
@override @useResult
$Res call({
 List<ZabTriggerData>? result, ZabErrorData? error
});


@override $ZabErrorDataCopyWith<$Res>? get error;

}
/// @nodoc
class __$ZabTriggersDataCopyWithImpl<$Res>
    implements _$ZabTriggersDataCopyWith<$Res> {
  __$ZabTriggersDataCopyWithImpl(this._self, this._then);

  final _ZabTriggersData _self;
  final $Res Function(_ZabTriggersData) _then;

/// Create a copy of ZabTriggersData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? result = freezed,Object? error = freezed,}) {
  return _then(_ZabTriggersData(
result: freezed == result ? _self._result : result // ignore: cast_nullable_to_non_nullable
as List<ZabTriggerData>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ZabErrorData?,
  ));
}

/// Create a copy of ZabTriggersData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZabErrorDataCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $ZabErrorDataCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// @nodoc
mixin _$ZabTriggerData {

 String? get triggerid; String? get status;
/// Create a copy of ZabTriggerData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZabTriggerDataCopyWith<ZabTriggerData> get copyWith => _$ZabTriggerDataCopyWithImpl<ZabTriggerData>(this as ZabTriggerData, _$identity);

  /// Serializes this ZabTriggerData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZabTriggerData&&(identical(other.triggerid, triggerid) || other.triggerid == triggerid)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,triggerid,status);

@override
String toString() {
  return 'ZabTriggerData(triggerid: $triggerid, status: $status)';
}


}

/// @nodoc
abstract mixin class $ZabTriggerDataCopyWith<$Res>  {
  factory $ZabTriggerDataCopyWith(ZabTriggerData value, $Res Function(ZabTriggerData) _then) = _$ZabTriggerDataCopyWithImpl;
@useResult
$Res call({
 String? triggerid, String? status
});




}
/// @nodoc
class _$ZabTriggerDataCopyWithImpl<$Res>
    implements $ZabTriggerDataCopyWith<$Res> {
  _$ZabTriggerDataCopyWithImpl(this._self, this._then);

  final ZabTriggerData _self;
  final $Res Function(ZabTriggerData) _then;

/// Create a copy of ZabTriggerData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? triggerid = freezed,Object? status = freezed,}) {
  return _then(_self.copyWith(
triggerid: freezed == triggerid ? _self.triggerid : triggerid // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ZabTriggerData implements ZabTriggerData {
  const _ZabTriggerData({this.triggerid, this.status});
  factory _ZabTriggerData.fromJson(Map<String, dynamic> json) => _$ZabTriggerDataFromJson(json);

@override final  String? triggerid;
@override final  String? status;

/// Create a copy of ZabTriggerData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZabTriggerDataCopyWith<_ZabTriggerData> get copyWith => __$ZabTriggerDataCopyWithImpl<_ZabTriggerData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ZabTriggerDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZabTriggerData&&(identical(other.triggerid, triggerid) || other.triggerid == triggerid)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,triggerid,status);

@override
String toString() {
  return 'ZabTriggerData(triggerid: $triggerid, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ZabTriggerDataCopyWith<$Res> implements $ZabTriggerDataCopyWith<$Res> {
  factory _$ZabTriggerDataCopyWith(_ZabTriggerData value, $Res Function(_ZabTriggerData) _then) = __$ZabTriggerDataCopyWithImpl;
@override @useResult
$Res call({
 String? triggerid, String? status
});




}
/// @nodoc
class __$ZabTriggerDataCopyWithImpl<$Res>
    implements _$ZabTriggerDataCopyWith<$Res> {
  __$ZabTriggerDataCopyWithImpl(this._self, this._then);

  final _ZabTriggerData _self;
  final $Res Function(_ZabTriggerData) _then;

/// Create a copy of ZabTriggerData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? triggerid = freezed,Object? status = freezed,}) {
  return _then(_ZabTriggerData(
triggerid: freezed == triggerid ? _self.triggerid : triggerid // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

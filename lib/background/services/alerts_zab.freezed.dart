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

 List<ZabAlertData>? get result; ZabErrorData? get error;
/// Create a copy of ZabAlertsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZabAlertsDataCopyWith<ZabAlertsData> get copyWith => _$ZabAlertsDataCopyWithImpl<ZabAlertsData>(this as ZabAlertsData, _$identity);

  /// Serializes this ZabAlertsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZabAlertsData&&const DeepCollectionEquality().equals(other.result, result)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(result),error);

@override
String toString() {
  return 'ZabAlertsData(result: $result, error: $error)';
}


}

/// @nodoc
abstract mixin class $ZabAlertsDataCopyWith<$Res>  {
  factory $ZabAlertsDataCopyWith(ZabAlertsData value, $Res Function(ZabAlertsData) _then) = _$ZabAlertsDataCopyWithImpl;
@useResult
$Res call({
 List<ZabAlertData>? result, ZabErrorData? error
});


$ZabErrorDataCopyWith<$Res>? get error;

}
/// @nodoc
class _$ZabAlertsDataCopyWithImpl<$Res>
    implements $ZabAlertsDataCopyWith<$Res> {
  _$ZabAlertsDataCopyWithImpl(this._self, this._then);

  final ZabAlertsData _self;
  final $Res Function(ZabAlertsData) _then;

/// Create a copy of ZabAlertsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? result = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as List<ZabAlertData>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ZabErrorData?,
  ));
}
/// Create a copy of ZabAlertsData
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

class _ZabAlertsData implements ZabAlertsData {
  const _ZabAlertsData({final  List<ZabAlertData>? result, this.error}): _result = result;
  factory _ZabAlertsData.fromJson(Map<String, dynamic> json) => _$ZabAlertsDataFromJson(json);

 final  List<ZabAlertData>? _result;
@override List<ZabAlertData>? get result {
  final value = _result;
  if (value == null) return null;
  if (_result is EqualUnmodifiableListView) return _result;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  ZabErrorData? error;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZabAlertsData&&const DeepCollectionEquality().equals(other._result, _result)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_result),error);

@override
String toString() {
  return 'ZabAlertsData(result: $result, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ZabAlertsDataCopyWith<$Res> implements $ZabAlertsDataCopyWith<$Res> {
  factory _$ZabAlertsDataCopyWith(_ZabAlertsData value, $Res Function(_ZabAlertsData) _then) = __$ZabAlertsDataCopyWithImpl;
@override @useResult
$Res call({
 List<ZabAlertData>? result, ZabErrorData? error
});


@override $ZabErrorDataCopyWith<$Res>? get error;

}
/// @nodoc
class __$ZabAlertsDataCopyWithImpl<$Res>
    implements _$ZabAlertsDataCopyWith<$Res> {
  __$ZabAlertsDataCopyWithImpl(this._self, this._then);

  final _ZabAlertsData _self;
  final $Res Function(_ZabAlertsData) _then;

/// Create a copy of ZabAlertsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? result = freezed,Object? error = freezed,}) {
  return _then(_ZabAlertsData(
result: freezed == result ? _self._result : result // ignore: cast_nullable_to_non_nullable
as List<ZabAlertData>?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ZabErrorData?,
  ));
}

/// Create a copy of ZabAlertsData
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

 String? get eventid;
/// Create a copy of ZabProblemData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZabProblemDataCopyWith<ZabProblemData> get copyWith => _$ZabProblemDataCopyWithImpl<ZabProblemData>(this as ZabProblemData, _$identity);

  /// Serializes this ZabProblemData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZabProblemData&&(identical(other.eventid, eventid) || other.eventid == eventid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventid);

@override
String toString() {
  return 'ZabProblemData(eventid: $eventid)';
}


}

/// @nodoc
abstract mixin class $ZabProblemDataCopyWith<$Res>  {
  factory $ZabProblemDataCopyWith(ZabProblemData value, $Res Function(ZabProblemData) _then) = _$ZabProblemDataCopyWithImpl;
@useResult
$Res call({
 String? eventid
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
@pragma('vm:prefer-inline') @override $Res call({Object? eventid = freezed,}) {
  return _then(_self.copyWith(
eventid: freezed == eventid ? _self.eventid : eventid // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ZabProblemData implements ZabProblemData {
  const _ZabProblemData({this.eventid});
  factory _ZabProblemData.fromJson(Map<String, dynamic> json) => _$ZabProblemDataFromJson(json);

@override final  String? eventid;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZabProblemData&&(identical(other.eventid, eventid) || other.eventid == eventid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventid);

@override
String toString() {
  return 'ZabProblemData(eventid: $eventid)';
}


}

/// @nodoc
abstract mixin class _$ZabProblemDataCopyWith<$Res> implements $ZabProblemDataCopyWith<$Res> {
  factory _$ZabProblemDataCopyWith(_ZabProblemData value, $Res Function(_ZabProblemData) _then) = __$ZabProblemDataCopyWithImpl;
@override @useResult
$Res call({
 String? eventid
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
@override @pragma('vm:prefer-inline') $Res call({Object? eventid = freezed,}) {
  return _then(_ZabProblemData(
eventid: freezed == eventid ? _self.eventid : eventid // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

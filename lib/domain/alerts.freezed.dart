// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alerts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Alert {

 int get source; AlertType get kind; String get hostname; String get service; String get message; String get serviceUrl; String get monitorUrl; Duration get age; bool get downtimeScheduled; bool get silenced; bool get active;
/// Create a copy of Alert
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlertCopyWith<Alert> get copyWith => _$AlertCopyWithImpl<Alert>(this as Alert, _$identity);

  /// Serializes this Alert to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Alert&&(identical(other.source, source) || other.source == source)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.hostname, hostname) || other.hostname == hostname)&&(identical(other.service, service) || other.service == service)&&(identical(other.message, message) || other.message == message)&&(identical(other.serviceUrl, serviceUrl) || other.serviceUrl == serviceUrl)&&(identical(other.monitorUrl, monitorUrl) || other.monitorUrl == monitorUrl)&&(identical(other.age, age) || other.age == age)&&(identical(other.downtimeScheduled, downtimeScheduled) || other.downtimeScheduled == downtimeScheduled)&&(identical(other.silenced, silenced) || other.silenced == silenced)&&(identical(other.active, active) || other.active == active));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,source,kind,hostname,service,message,serviceUrl,monitorUrl,age,downtimeScheduled,silenced,active);

@override
String toString() {
  return 'Alert(source: $source, kind: $kind, hostname: $hostname, service: $service, message: $message, serviceUrl: $serviceUrl, monitorUrl: $monitorUrl, age: $age, downtimeScheduled: $downtimeScheduled, silenced: $silenced, active: $active)';
}


}

/// @nodoc
abstract mixin class $AlertCopyWith<$Res>  {
  factory $AlertCopyWith(Alert value, $Res Function(Alert) _then) = _$AlertCopyWithImpl;
@useResult
$Res call({
 int source, AlertType kind, String hostname, String service, String message, String serviceUrl, String monitorUrl, Duration age, bool downtimeScheduled, bool silenced, bool active
});




}
/// @nodoc
class _$AlertCopyWithImpl<$Res>
    implements $AlertCopyWith<$Res> {
  _$AlertCopyWithImpl(this._self, this._then);

  final Alert _self;
  final $Res Function(Alert) _then;

/// Create a copy of Alert
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? source = null,Object? kind = null,Object? hostname = null,Object? service = null,Object? message = null,Object? serviceUrl = null,Object? monitorUrl = null,Object? age = null,Object? downtimeScheduled = null,Object? silenced = null,Object? active = null,}) {
  return _then(_self.copyWith(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as AlertType,hostname: null == hostname ? _self.hostname : hostname // ignore: cast_nullable_to_non_nullable
as String,service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,serviceUrl: null == serviceUrl ? _self.serviceUrl : serviceUrl // ignore: cast_nullable_to_non_nullable
as String,monitorUrl: null == monitorUrl ? _self.monitorUrl : monitorUrl // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as Duration,downtimeScheduled: null == downtimeScheduled ? _self.downtimeScheduled : downtimeScheduled // ignore: cast_nullable_to_non_nullable
as bool,silenced: null == silenced ? _self.silenced : silenced // ignore: cast_nullable_to_non_nullable
as bool,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Alert implements Alert {
  const _Alert({required this.source, required this.kind, required this.hostname, required this.service, required this.message, required this.serviceUrl, required this.monitorUrl, required this.age, required this.downtimeScheduled, required this.silenced, required this.active});
  factory _Alert.fromJson(Map<String, dynamic> json) => _$AlertFromJson(json);

@override final  int source;
@override final  AlertType kind;
@override final  String hostname;
@override final  String service;
@override final  String message;
@override final  String serviceUrl;
@override final  String monitorUrl;
@override final  Duration age;
@override final  bool downtimeScheduled;
@override final  bool silenced;
@override final  bool active;

/// Create a copy of Alert
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlertCopyWith<_Alert> get copyWith => __$AlertCopyWithImpl<_Alert>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlertToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Alert&&(identical(other.source, source) || other.source == source)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.hostname, hostname) || other.hostname == hostname)&&(identical(other.service, service) || other.service == service)&&(identical(other.message, message) || other.message == message)&&(identical(other.serviceUrl, serviceUrl) || other.serviceUrl == serviceUrl)&&(identical(other.monitorUrl, monitorUrl) || other.monitorUrl == monitorUrl)&&(identical(other.age, age) || other.age == age)&&(identical(other.downtimeScheduled, downtimeScheduled) || other.downtimeScheduled == downtimeScheduled)&&(identical(other.silenced, silenced) || other.silenced == silenced)&&(identical(other.active, active) || other.active == active));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,source,kind,hostname,service,message,serviceUrl,monitorUrl,age,downtimeScheduled,silenced,active);

@override
String toString() {
  return 'Alert(source: $source, kind: $kind, hostname: $hostname, service: $service, message: $message, serviceUrl: $serviceUrl, monitorUrl: $monitorUrl, age: $age, downtimeScheduled: $downtimeScheduled, silenced: $silenced, active: $active)';
}


}

/// @nodoc
abstract mixin class _$AlertCopyWith<$Res> implements $AlertCopyWith<$Res> {
  factory _$AlertCopyWith(_Alert value, $Res Function(_Alert) _then) = __$AlertCopyWithImpl;
@override @useResult
$Res call({
 int source, AlertType kind, String hostname, String service, String message, String serviceUrl, String monitorUrl, Duration age, bool downtimeScheduled, bool silenced, bool active
});




}
/// @nodoc
class __$AlertCopyWithImpl<$Res>
    implements _$AlertCopyWith<$Res> {
  __$AlertCopyWithImpl(this._self, this._then);

  final _Alert _self;
  final $Res Function(_Alert) _then;

/// Create a copy of Alert
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? source = null,Object? kind = null,Object? hostname = null,Object? service = null,Object? message = null,Object? serviceUrl = null,Object? monitorUrl = null,Object? age = null,Object? downtimeScheduled = null,Object? silenced = null,Object? active = null,}) {
  return _then(_Alert(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as AlertType,hostname: null == hostname ? _self.hostname : hostname // ignore: cast_nullable_to_non_nullable
as String,service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,serviceUrl: null == serviceUrl ? _self.serviceUrl : serviceUrl // ignore: cast_nullable_to_non_nullable
as String,monitorUrl: null == monitorUrl ? _self.monitorUrl : monitorUrl // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as Duration,downtimeScheduled: null == downtimeScheduled ? _self.downtimeScheduled : downtimeScheduled // ignore: cast_nullable_to_non_nullable
as bool,silenced: null == silenced ? _self.silenced : silenced // ignore: cast_nullable_to_non_nullable
as bool,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$AlertSourceData {

 int? get id; String get name; int get type; int get authType; String get baseURL; String get username; String get password; bool get failing; DateTime get lastSeen; DateTime get priorFetch; DateTime get lastFetch; String get errorMessage; bool? get isValid; String get accessToken; bool get visible; bool get notifications; int? get serial;
/// Create a copy of AlertSourceData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlertSourceDataCopyWith<AlertSourceData> get copyWith => _$AlertSourceDataCopyWithImpl<AlertSourceData>(this as AlertSourceData, _$identity);

  /// Serializes this AlertSourceData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlertSourceData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.authType, authType) || other.authType == authType)&&(identical(other.baseURL, baseURL) || other.baseURL == baseURL)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.failing, failing) || other.failing == failing)&&(identical(other.lastSeen, lastSeen) || other.lastSeen == lastSeen)&&(identical(other.priorFetch, priorFetch) || other.priorFetch == priorFetch)&&(identical(other.lastFetch, lastFetch) || other.lastFetch == lastFetch)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isValid, isValid) || other.isValid == isValid)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.visible, visible) || other.visible == visible)&&(identical(other.notifications, notifications) || other.notifications == notifications)&&(identical(other.serial, serial) || other.serial == serial));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,authType,baseURL,username,password,failing,lastSeen,priorFetch,lastFetch,errorMessage,isValid,accessToken,visible,notifications,serial);

@override
String toString() {
  return 'AlertSourceData(id: $id, name: $name, type: $type, authType: $authType, baseURL: $baseURL, username: $username, password: $password, failing: $failing, lastSeen: $lastSeen, priorFetch: $priorFetch, lastFetch: $lastFetch, errorMessage: $errorMessage, isValid: $isValid, accessToken: $accessToken, visible: $visible, notifications: $notifications, serial: $serial)';
}


}

/// @nodoc
abstract mixin class $AlertSourceDataCopyWith<$Res>  {
  factory $AlertSourceDataCopyWith(AlertSourceData value, $Res Function(AlertSourceData) _then) = _$AlertSourceDataCopyWithImpl;
@useResult
$Res call({
 int? id, String name, int type, int authType, String baseURL, String username, String password, bool failing, DateTime lastSeen, DateTime priorFetch, DateTime lastFetch, String errorMessage, bool? isValid, String accessToken, bool visible, bool notifications, int? serial
});




}
/// @nodoc
class _$AlertSourceDataCopyWithImpl<$Res>
    implements $AlertSourceDataCopyWith<$Res> {
  _$AlertSourceDataCopyWithImpl(this._self, this._then);

  final AlertSourceData _self;
  final $Res Function(AlertSourceData) _then;

/// Create a copy of AlertSourceData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? type = null,Object? authType = null,Object? baseURL = null,Object? username = null,Object? password = null,Object? failing = null,Object? lastSeen = null,Object? priorFetch = null,Object? lastFetch = null,Object? errorMessage = null,Object? isValid = freezed,Object? accessToken = null,Object? visible = null,Object? notifications = null,Object? serial = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,authType: null == authType ? _self.authType : authType // ignore: cast_nullable_to_non_nullable
as int,baseURL: null == baseURL ? _self.baseURL : baseURL // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,failing: null == failing ? _self.failing : failing // ignore: cast_nullable_to_non_nullable
as bool,lastSeen: null == lastSeen ? _self.lastSeen : lastSeen // ignore: cast_nullable_to_non_nullable
as DateTime,priorFetch: null == priorFetch ? _self.priorFetch : priorFetch // ignore: cast_nullable_to_non_nullable
as DateTime,lastFetch: null == lastFetch ? _self.lastFetch : lastFetch // ignore: cast_nullable_to_non_nullable
as DateTime,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,isValid: freezed == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool?,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,visible: null == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool,notifications: null == notifications ? _self.notifications : notifications // ignore: cast_nullable_to_non_nullable
as bool,serial: freezed == serial ? _self.serial : serial // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AlertSourceData implements AlertSourceData {
  const _AlertSourceData({required this.id, required this.name, required this.type, required this.authType, required this.baseURL, required this.username, required this.password, required this.failing, required this.lastSeen, required this.priorFetch, required this.lastFetch, required this.errorMessage, this.isValid, required this.accessToken, required this.visible, required this.notifications, this.serial});
  factory _AlertSourceData.fromJson(Map<String, dynamic> json) => _$AlertSourceDataFromJson(json);

@override final  int? id;
@override final  String name;
@override final  int type;
@override final  int authType;
@override final  String baseURL;
@override final  String username;
@override final  String password;
@override final  bool failing;
@override final  DateTime lastSeen;
@override final  DateTime priorFetch;
@override final  DateTime lastFetch;
@override final  String errorMessage;
@override final  bool? isValid;
@override final  String accessToken;
@override final  bool visible;
@override final  bool notifications;
@override final  int? serial;

/// Create a copy of AlertSourceData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlertSourceDataCopyWith<_AlertSourceData> get copyWith => __$AlertSourceDataCopyWithImpl<_AlertSourceData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlertSourceDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlertSourceData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.authType, authType) || other.authType == authType)&&(identical(other.baseURL, baseURL) || other.baseURL == baseURL)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.failing, failing) || other.failing == failing)&&(identical(other.lastSeen, lastSeen) || other.lastSeen == lastSeen)&&(identical(other.priorFetch, priorFetch) || other.priorFetch == priorFetch)&&(identical(other.lastFetch, lastFetch) || other.lastFetch == lastFetch)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isValid, isValid) || other.isValid == isValid)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.visible, visible) || other.visible == visible)&&(identical(other.notifications, notifications) || other.notifications == notifications)&&(identical(other.serial, serial) || other.serial == serial));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,authType,baseURL,username,password,failing,lastSeen,priorFetch,lastFetch,errorMessage,isValid,accessToken,visible,notifications,serial);

@override
String toString() {
  return 'AlertSourceData(id: $id, name: $name, type: $type, authType: $authType, baseURL: $baseURL, username: $username, password: $password, failing: $failing, lastSeen: $lastSeen, priorFetch: $priorFetch, lastFetch: $lastFetch, errorMessage: $errorMessage, isValid: $isValid, accessToken: $accessToken, visible: $visible, notifications: $notifications, serial: $serial)';
}


}

/// @nodoc
abstract mixin class _$AlertSourceDataCopyWith<$Res> implements $AlertSourceDataCopyWith<$Res> {
  factory _$AlertSourceDataCopyWith(_AlertSourceData value, $Res Function(_AlertSourceData) _then) = __$AlertSourceDataCopyWithImpl;
@override @useResult
$Res call({
 int? id, String name, int type, int authType, String baseURL, String username, String password, bool failing, DateTime lastSeen, DateTime priorFetch, DateTime lastFetch, String errorMessage, bool? isValid, String accessToken, bool visible, bool notifications, int? serial
});




}
/// @nodoc
class __$AlertSourceDataCopyWithImpl<$Res>
    implements _$AlertSourceDataCopyWith<$Res> {
  __$AlertSourceDataCopyWithImpl(this._self, this._then);

  final _AlertSourceData _self;
  final $Res Function(_AlertSourceData) _then;

/// Create a copy of AlertSourceData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? type = null,Object? authType = null,Object? baseURL = null,Object? username = null,Object? password = null,Object? failing = null,Object? lastSeen = null,Object? priorFetch = null,Object? lastFetch = null,Object? errorMessage = null,Object? isValid = freezed,Object? accessToken = null,Object? visible = null,Object? notifications = null,Object? serial = freezed,}) {
  return _then(_AlertSourceData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,authType: null == authType ? _self.authType : authType // ignore: cast_nullable_to_non_nullable
as int,baseURL: null == baseURL ? _self.baseURL : baseURL // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,failing: null == failing ? _self.failing : failing // ignore: cast_nullable_to_non_nullable
as bool,lastSeen: null == lastSeen ? _self.lastSeen : lastSeen // ignore: cast_nullable_to_non_nullable
as DateTime,priorFetch: null == priorFetch ? _self.priorFetch : priorFetch // ignore: cast_nullable_to_non_nullable
as DateTime,lastFetch: null == lastFetch ? _self.lastFetch : lastFetch // ignore: cast_nullable_to_non_nullable
as DateTime,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,isValid: freezed == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool?,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,visible: null == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool,notifications: null == notifications ? _self.notifications : notifications // ignore: cast_nullable_to_non_nullable
as bool,serial: freezed == serial ? _self.serial : serial // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$AlertSourceDataUpdate {

 int? get id; String get name; int get type; int get authType; String get baseURL; String get username; String get password; String get errorMessage; bool? get isValid; String get accessToken; int? get serial;
/// Create a copy of AlertSourceDataUpdate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlertSourceDataUpdateCopyWith<AlertSourceDataUpdate> get copyWith => _$AlertSourceDataUpdateCopyWithImpl<AlertSourceDataUpdate>(this as AlertSourceDataUpdate, _$identity);

  /// Serializes this AlertSourceDataUpdate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlertSourceDataUpdate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.authType, authType) || other.authType == authType)&&(identical(other.baseURL, baseURL) || other.baseURL == baseURL)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isValid, isValid) || other.isValid == isValid)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.serial, serial) || other.serial == serial));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,authType,baseURL,username,password,errorMessage,isValid,accessToken,serial);

@override
String toString() {
  return 'AlertSourceDataUpdate(id: $id, name: $name, type: $type, authType: $authType, baseURL: $baseURL, username: $username, password: $password, errorMessage: $errorMessage, isValid: $isValid, accessToken: $accessToken, serial: $serial)';
}


}

/// @nodoc
abstract mixin class $AlertSourceDataUpdateCopyWith<$Res>  {
  factory $AlertSourceDataUpdateCopyWith(AlertSourceDataUpdate value, $Res Function(AlertSourceDataUpdate) _then) = _$AlertSourceDataUpdateCopyWithImpl;
@useResult
$Res call({
 int? id, String name, int type, int authType, String baseURL, String username, String password, String errorMessage, bool? isValid, String accessToken, int? serial
});




}
/// @nodoc
class _$AlertSourceDataUpdateCopyWithImpl<$Res>
    implements $AlertSourceDataUpdateCopyWith<$Res> {
  _$AlertSourceDataUpdateCopyWithImpl(this._self, this._then);

  final AlertSourceDataUpdate _self;
  final $Res Function(AlertSourceDataUpdate) _then;

/// Create a copy of AlertSourceDataUpdate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? type = null,Object? authType = null,Object? baseURL = null,Object? username = null,Object? password = null,Object? errorMessage = null,Object? isValid = freezed,Object? accessToken = null,Object? serial = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,authType: null == authType ? _self.authType : authType // ignore: cast_nullable_to_non_nullable
as int,baseURL: null == baseURL ? _self.baseURL : baseURL // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,isValid: freezed == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool?,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,serial: freezed == serial ? _self.serial : serial // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AlertSourceDataUpdate implements AlertSourceDataUpdate {
  const _AlertSourceDataUpdate({required this.id, required this.name, required this.type, required this.authType, required this.baseURL, required this.username, required this.password, required this.errorMessage, this.isValid, required this.accessToken, this.serial});
  factory _AlertSourceDataUpdate.fromJson(Map<String, dynamic> json) => _$AlertSourceDataUpdateFromJson(json);

@override final  int? id;
@override final  String name;
@override final  int type;
@override final  int authType;
@override final  String baseURL;
@override final  String username;
@override final  String password;
@override final  String errorMessage;
@override final  bool? isValid;
@override final  String accessToken;
@override final  int? serial;

/// Create a copy of AlertSourceDataUpdate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlertSourceDataUpdateCopyWith<_AlertSourceDataUpdate> get copyWith => __$AlertSourceDataUpdateCopyWithImpl<_AlertSourceDataUpdate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlertSourceDataUpdateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlertSourceDataUpdate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.authType, authType) || other.authType == authType)&&(identical(other.baseURL, baseURL) || other.baseURL == baseURL)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isValid, isValid) || other.isValid == isValid)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.serial, serial) || other.serial == serial));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,authType,baseURL,username,password,errorMessage,isValid,accessToken,serial);

@override
String toString() {
  return 'AlertSourceDataUpdate(id: $id, name: $name, type: $type, authType: $authType, baseURL: $baseURL, username: $username, password: $password, errorMessage: $errorMessage, isValid: $isValid, accessToken: $accessToken, serial: $serial)';
}


}

/// @nodoc
abstract mixin class _$AlertSourceDataUpdateCopyWith<$Res> implements $AlertSourceDataUpdateCopyWith<$Res> {
  factory _$AlertSourceDataUpdateCopyWith(_AlertSourceDataUpdate value, $Res Function(_AlertSourceDataUpdate) _then) = __$AlertSourceDataUpdateCopyWithImpl;
@override @useResult
$Res call({
 int? id, String name, int type, int authType, String baseURL, String username, String password, String errorMessage, bool? isValid, String accessToken, int? serial
});




}
/// @nodoc
class __$AlertSourceDataUpdateCopyWithImpl<$Res>
    implements _$AlertSourceDataUpdateCopyWith<$Res> {
  __$AlertSourceDataUpdateCopyWithImpl(this._self, this._then);

  final _AlertSourceDataUpdate _self;
  final $Res Function(_AlertSourceDataUpdate) _then;

/// Create a copy of AlertSourceDataUpdate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = null,Object? type = null,Object? authType = null,Object? baseURL = null,Object? username = null,Object? password = null,Object? errorMessage = null,Object? isValid = freezed,Object? accessToken = null,Object? serial = freezed,}) {
  return _then(_AlertSourceDataUpdate(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,authType: null == authType ? _self.authType : authType // ignore: cast_nullable_to_non_nullable
as int,baseURL: null == baseURL ? _self.baseURL : baseURL // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,isValid: freezed == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool?,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,serial: freezed == serial ? _self.serial : serial // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on

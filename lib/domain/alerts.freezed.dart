// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alerts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Alert _$AlertFromJson(Map<String, dynamic> json) {
  return _Alert.fromJson(json);
}

/// @nodoc
mixin _$Alert {
  int get source => throw _privateConstructorUsedError;
  AlertType get kind => throw _privateConstructorUsedError;
  String get hostname => throw _privateConstructorUsedError;
  String get service => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get serviceUrl => throw _privateConstructorUsedError;
  String get monitorUrl => throw _privateConstructorUsedError;
  Duration get age => throw _privateConstructorUsedError;
  bool get downtimeScheduled => throw _privateConstructorUsedError;
  bool get silenced => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;

  /// Serializes this Alert to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlertCopyWith<Alert> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertCopyWith<$Res> {
  factory $AlertCopyWith(Alert value, $Res Function(Alert) then) =
      _$AlertCopyWithImpl<$Res, Alert>;
  @useResult
  $Res call(
      {int source,
      AlertType kind,
      String hostname,
      String service,
      String message,
      String serviceUrl,
      String monitorUrl,
      Duration age,
      bool downtimeScheduled,
      bool silenced,
      bool active});
}

/// @nodoc
class _$AlertCopyWithImpl<$Res, $Val extends Alert>
    implements $AlertCopyWith<$Res> {
  _$AlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? kind = null,
    Object? hostname = null,
    Object? service = null,
    Object? message = null,
    Object? serviceUrl = null,
    Object? monitorUrl = null,
    Object? age = null,
    Object? downtimeScheduled = null,
    Object? silenced = null,
    Object? active = null,
  }) {
    return _then(_value.copyWith(
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as int,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as AlertType,
      hostname: null == hostname
          ? _value.hostname
          : hostname // ignore: cast_nullable_to_non_nullable
              as String,
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      serviceUrl: null == serviceUrl
          ? _value.serviceUrl
          : serviceUrl // ignore: cast_nullable_to_non_nullable
              as String,
      monitorUrl: null == monitorUrl
          ? _value.monitorUrl
          : monitorUrl // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as Duration,
      downtimeScheduled: null == downtimeScheduled
          ? _value.downtimeScheduled
          : downtimeScheduled // ignore: cast_nullable_to_non_nullable
              as bool,
      silenced: null == silenced
          ? _value.silenced
          : silenced // ignore: cast_nullable_to_non_nullable
              as bool,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlertImplCopyWith<$Res> implements $AlertCopyWith<$Res> {
  factory _$$AlertImplCopyWith(
          _$AlertImpl value, $Res Function(_$AlertImpl) then) =
      __$$AlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int source,
      AlertType kind,
      String hostname,
      String service,
      String message,
      String serviceUrl,
      String monitorUrl,
      Duration age,
      bool downtimeScheduled,
      bool silenced,
      bool active});
}

/// @nodoc
class __$$AlertImplCopyWithImpl<$Res>
    extends _$AlertCopyWithImpl<$Res, _$AlertImpl>
    implements _$$AlertImplCopyWith<$Res> {
  __$$AlertImplCopyWithImpl(
      _$AlertImpl _value, $Res Function(_$AlertImpl) _then)
      : super(_value, _then);

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? kind = null,
    Object? hostname = null,
    Object? service = null,
    Object? message = null,
    Object? serviceUrl = null,
    Object? monitorUrl = null,
    Object? age = null,
    Object? downtimeScheduled = null,
    Object? silenced = null,
    Object? active = null,
  }) {
    return _then(_$AlertImpl(
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as int,
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as AlertType,
      hostname: null == hostname
          ? _value.hostname
          : hostname // ignore: cast_nullable_to_non_nullable
              as String,
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      serviceUrl: null == serviceUrl
          ? _value.serviceUrl
          : serviceUrl // ignore: cast_nullable_to_non_nullable
              as String,
      monitorUrl: null == monitorUrl
          ? _value.monitorUrl
          : monitorUrl // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as Duration,
      downtimeScheduled: null == downtimeScheduled
          ? _value.downtimeScheduled
          : downtimeScheduled // ignore: cast_nullable_to_non_nullable
              as bool,
      silenced: null == silenced
          ? _value.silenced
          : silenced // ignore: cast_nullable_to_non_nullable
              as bool,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlertImpl implements _Alert {
  const _$AlertImpl(
      {required this.source,
      required this.kind,
      required this.hostname,
      required this.service,
      required this.message,
      required this.serviceUrl,
      required this.monitorUrl,
      required this.age,
      required this.downtimeScheduled,
      required this.silenced,
      required this.active});

  factory _$AlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlertImplFromJson(json);

  @override
  final int source;
  @override
  final AlertType kind;
  @override
  final String hostname;
  @override
  final String service;
  @override
  final String message;
  @override
  final String serviceUrl;
  @override
  final String monitorUrl;
  @override
  final Duration age;
  @override
  final bool downtimeScheduled;
  @override
  final bool silenced;
  @override
  final bool active;

  @override
  String toString() {
    return 'Alert(source: $source, kind: $kind, hostname: $hostname, service: $service, message: $message, serviceUrl: $serviceUrl, monitorUrl: $monitorUrl, age: $age, downtimeScheduled: $downtimeScheduled, silenced: $silenced, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertImpl &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.hostname, hostname) ||
                other.hostname == hostname) &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.serviceUrl, serviceUrl) ||
                other.serviceUrl == serviceUrl) &&
            (identical(other.monitorUrl, monitorUrl) ||
                other.monitorUrl == monitorUrl) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.downtimeScheduled, downtimeScheduled) ||
                other.downtimeScheduled == downtimeScheduled) &&
            (identical(other.silenced, silenced) ||
                other.silenced == silenced) &&
            (identical(other.active, active) || other.active == active));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      source,
      kind,
      hostname,
      service,
      message,
      serviceUrl,
      monitorUrl,
      age,
      downtimeScheduled,
      silenced,
      active);

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertImplCopyWith<_$AlertImpl> get copyWith =>
      __$$AlertImplCopyWithImpl<_$AlertImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlertImplToJson(
      this,
    );
  }
}

abstract class _Alert implements Alert {
  const factory _Alert(
      {required final int source,
      required final AlertType kind,
      required final String hostname,
      required final String service,
      required final String message,
      required final String serviceUrl,
      required final String monitorUrl,
      required final Duration age,
      required final bool downtimeScheduled,
      required final bool silenced,
      required final bool active}) = _$AlertImpl;

  factory _Alert.fromJson(Map<String, dynamic> json) = _$AlertImpl.fromJson;

  @override
  int get source;
  @override
  AlertType get kind;
  @override
  String get hostname;
  @override
  String get service;
  @override
  String get message;
  @override
  String get serviceUrl;
  @override
  String get monitorUrl;
  @override
  Duration get age;
  @override
  bool get downtimeScheduled;
  @override
  bool get silenced;
  @override
  bool get active;

  /// Create a copy of Alert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlertImplCopyWith<_$AlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AlertSourceData _$AlertSourceDataFromJson(Map<String, dynamic> json) {
  return _AlertSourceData.fromJson(json);
}

/// @nodoc
mixin _$AlertSourceData {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError;
  int get authType => throw _privateConstructorUsedError;
  String get baseURL => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  bool get failing => throw _privateConstructorUsedError;
  DateTime get lastSeen => throw _privateConstructorUsedError;
  DateTime get priorFetch => throw _privateConstructorUsedError;
  DateTime get lastFetch => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  bool? get isValid => throw _privateConstructorUsedError;
  String get accessToken => throw _privateConstructorUsedError;
  bool get visible => throw _privateConstructorUsedError;
  bool get notifications => throw _privateConstructorUsedError;
  int? get serial => throw _privateConstructorUsedError;

  /// Serializes this AlertSourceData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AlertSourceData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlertSourceDataCopyWith<AlertSourceData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertSourceDataCopyWith<$Res> {
  factory $AlertSourceDataCopyWith(
          AlertSourceData value, $Res Function(AlertSourceData) then) =
      _$AlertSourceDataCopyWithImpl<$Res, AlertSourceData>;
  @useResult
  $Res call(
      {int? id,
      String name,
      int type,
      int authType,
      String baseURL,
      String username,
      String password,
      bool failing,
      DateTime lastSeen,
      DateTime priorFetch,
      DateTime lastFetch,
      String errorMessage,
      bool? isValid,
      String accessToken,
      bool visible,
      bool notifications,
      int? serial});
}

/// @nodoc
class _$AlertSourceDataCopyWithImpl<$Res, $Val extends AlertSourceData>
    implements $AlertSourceDataCopyWith<$Res> {
  _$AlertSourceDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AlertSourceData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? type = null,
    Object? authType = null,
    Object? baseURL = null,
    Object? username = null,
    Object? password = null,
    Object? failing = null,
    Object? lastSeen = null,
    Object? priorFetch = null,
    Object? lastFetch = null,
    Object? errorMessage = null,
    Object? isValid = freezed,
    Object? accessToken = null,
    Object? visible = null,
    Object? notifications = null,
    Object? serial = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      authType: null == authType
          ? _value.authType
          : authType // ignore: cast_nullable_to_non_nullable
              as int,
      baseURL: null == baseURL
          ? _value.baseURL
          : baseURL // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      failing: null == failing
          ? _value.failing
          : failing // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeen: null == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime,
      priorFetch: null == priorFetch
          ? _value.priorFetch
          : priorFetch // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastFetch: null == lastFetch
          ? _value.lastFetch
          : lastFetch // ignore: cast_nullable_to_non_nullable
              as DateTime,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      isValid: freezed == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool?,
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      visible: null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      notifications: null == notifications
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as bool,
      serial: freezed == serial
          ? _value.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlertSourceDataImplCopyWith<$Res>
    implements $AlertSourceDataCopyWith<$Res> {
  factory _$$AlertSourceDataImplCopyWith(_$AlertSourceDataImpl value,
          $Res Function(_$AlertSourceDataImpl) then) =
      __$$AlertSourceDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String name,
      int type,
      int authType,
      String baseURL,
      String username,
      String password,
      bool failing,
      DateTime lastSeen,
      DateTime priorFetch,
      DateTime lastFetch,
      String errorMessage,
      bool? isValid,
      String accessToken,
      bool visible,
      bool notifications,
      int? serial});
}

/// @nodoc
class __$$AlertSourceDataImplCopyWithImpl<$Res>
    extends _$AlertSourceDataCopyWithImpl<$Res, _$AlertSourceDataImpl>
    implements _$$AlertSourceDataImplCopyWith<$Res> {
  __$$AlertSourceDataImplCopyWithImpl(
      _$AlertSourceDataImpl _value, $Res Function(_$AlertSourceDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of AlertSourceData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? type = null,
    Object? authType = null,
    Object? baseURL = null,
    Object? username = null,
    Object? password = null,
    Object? failing = null,
    Object? lastSeen = null,
    Object? priorFetch = null,
    Object? lastFetch = null,
    Object? errorMessage = null,
    Object? isValid = freezed,
    Object? accessToken = null,
    Object? visible = null,
    Object? notifications = null,
    Object? serial = freezed,
  }) {
    return _then(_$AlertSourceDataImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      authType: null == authType
          ? _value.authType
          : authType // ignore: cast_nullable_to_non_nullable
              as int,
      baseURL: null == baseURL
          ? _value.baseURL
          : baseURL // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      failing: null == failing
          ? _value.failing
          : failing // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeen: null == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime,
      priorFetch: null == priorFetch
          ? _value.priorFetch
          : priorFetch // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastFetch: null == lastFetch
          ? _value.lastFetch
          : lastFetch // ignore: cast_nullable_to_non_nullable
              as DateTime,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      isValid: freezed == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool?,
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      visible: null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
      notifications: null == notifications
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as bool,
      serial: freezed == serial
          ? _value.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlertSourceDataImpl implements _AlertSourceData {
  const _$AlertSourceDataImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.authType,
      required this.baseURL,
      required this.username,
      required this.password,
      required this.failing,
      required this.lastSeen,
      required this.priorFetch,
      required this.lastFetch,
      required this.errorMessage,
      this.isValid,
      required this.accessToken,
      required this.visible,
      required this.notifications,
      this.serial});

  factory _$AlertSourceDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlertSourceDataImplFromJson(json);

  @override
  final int? id;
  @override
  final String name;
  @override
  final int type;
  @override
  final int authType;
  @override
  final String baseURL;
  @override
  final String username;
  @override
  final String password;
  @override
  final bool failing;
  @override
  final DateTime lastSeen;
  @override
  final DateTime priorFetch;
  @override
  final DateTime lastFetch;
  @override
  final String errorMessage;
  @override
  final bool? isValid;
  @override
  final String accessToken;
  @override
  final bool visible;
  @override
  final bool notifications;
  @override
  final int? serial;

  @override
  String toString() {
    return 'AlertSourceData(id: $id, name: $name, type: $type, authType: $authType, baseURL: $baseURL, username: $username, password: $password, failing: $failing, lastSeen: $lastSeen, priorFetch: $priorFetch, lastFetch: $lastFetch, errorMessage: $errorMessage, isValid: $isValid, accessToken: $accessToken, visible: $visible, notifications: $notifications, serial: $serial)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertSourceDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.authType, authType) ||
                other.authType == authType) &&
            (identical(other.baseURL, baseURL) || other.baseURL == baseURL) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.failing, failing) || other.failing == failing) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen) &&
            (identical(other.priorFetch, priorFetch) ||
                other.priorFetch == priorFetch) &&
            (identical(other.lastFetch, lastFetch) ||
                other.lastFetch == lastFetch) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.visible, visible) || other.visible == visible) &&
            (identical(other.notifications, notifications) ||
                other.notifications == notifications) &&
            (identical(other.serial, serial) || other.serial == serial));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      authType,
      baseURL,
      username,
      password,
      failing,
      lastSeen,
      priorFetch,
      lastFetch,
      errorMessage,
      isValid,
      accessToken,
      visible,
      notifications,
      serial);

  /// Create a copy of AlertSourceData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertSourceDataImplCopyWith<_$AlertSourceDataImpl> get copyWith =>
      __$$AlertSourceDataImplCopyWithImpl<_$AlertSourceDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlertSourceDataImplToJson(
      this,
    );
  }
}

abstract class _AlertSourceData implements AlertSourceData {
  const factory _AlertSourceData(
      {required final int? id,
      required final String name,
      required final int type,
      required final int authType,
      required final String baseURL,
      required final String username,
      required final String password,
      required final bool failing,
      required final DateTime lastSeen,
      required final DateTime priorFetch,
      required final DateTime lastFetch,
      required final String errorMessage,
      final bool? isValid,
      required final String accessToken,
      required final bool visible,
      required final bool notifications,
      final int? serial}) = _$AlertSourceDataImpl;

  factory _AlertSourceData.fromJson(Map<String, dynamic> json) =
      _$AlertSourceDataImpl.fromJson;

  @override
  int? get id;
  @override
  String get name;
  @override
  int get type;
  @override
  int get authType;
  @override
  String get baseURL;
  @override
  String get username;
  @override
  String get password;
  @override
  bool get failing;
  @override
  DateTime get lastSeen;
  @override
  DateTime get priorFetch;
  @override
  DateTime get lastFetch;
  @override
  String get errorMessage;
  @override
  bool? get isValid;
  @override
  String get accessToken;
  @override
  bool get visible;
  @override
  bool get notifications;
  @override
  int? get serial;

  /// Create a copy of AlertSourceData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlertSourceDataImplCopyWith<_$AlertSourceDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AlertSourceDataUpdate _$AlertSourceDataUpdateFromJson(
    Map<String, dynamic> json) {
  return _AlertSourceDataUpdate.fromJson(json);
}

/// @nodoc
mixin _$AlertSourceDataUpdate {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError;
  int get authType => throw _privateConstructorUsedError;
  String get baseURL => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  bool? get isValid => throw _privateConstructorUsedError;
  String get accessToken => throw _privateConstructorUsedError;
  int? get serial => throw _privateConstructorUsedError;

  /// Serializes this AlertSourceDataUpdate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AlertSourceDataUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AlertSourceDataUpdateCopyWith<AlertSourceDataUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertSourceDataUpdateCopyWith<$Res> {
  factory $AlertSourceDataUpdateCopyWith(AlertSourceDataUpdate value,
          $Res Function(AlertSourceDataUpdate) then) =
      _$AlertSourceDataUpdateCopyWithImpl<$Res, AlertSourceDataUpdate>;
  @useResult
  $Res call(
      {int? id,
      String name,
      int type,
      int authType,
      String baseURL,
      String username,
      String password,
      String errorMessage,
      bool? isValid,
      String accessToken,
      int? serial});
}

/// @nodoc
class _$AlertSourceDataUpdateCopyWithImpl<$Res,
        $Val extends AlertSourceDataUpdate>
    implements $AlertSourceDataUpdateCopyWith<$Res> {
  _$AlertSourceDataUpdateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AlertSourceDataUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? type = null,
    Object? authType = null,
    Object? baseURL = null,
    Object? username = null,
    Object? password = null,
    Object? errorMessage = null,
    Object? isValid = freezed,
    Object? accessToken = null,
    Object? serial = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      authType: null == authType
          ? _value.authType
          : authType // ignore: cast_nullable_to_non_nullable
              as int,
      baseURL: null == baseURL
          ? _value.baseURL
          : baseURL // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      isValid: freezed == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool?,
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      serial: freezed == serial
          ? _value.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlertSourceDataUpdateImplCopyWith<$Res>
    implements $AlertSourceDataUpdateCopyWith<$Res> {
  factory _$$AlertSourceDataUpdateImplCopyWith(
          _$AlertSourceDataUpdateImpl value,
          $Res Function(_$AlertSourceDataUpdateImpl) then) =
      __$$AlertSourceDataUpdateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String name,
      int type,
      int authType,
      String baseURL,
      String username,
      String password,
      String errorMessage,
      bool? isValid,
      String accessToken,
      int? serial});
}

/// @nodoc
class __$$AlertSourceDataUpdateImplCopyWithImpl<$Res>
    extends _$AlertSourceDataUpdateCopyWithImpl<$Res,
        _$AlertSourceDataUpdateImpl>
    implements _$$AlertSourceDataUpdateImplCopyWith<$Res> {
  __$$AlertSourceDataUpdateImplCopyWithImpl(_$AlertSourceDataUpdateImpl _value,
      $Res Function(_$AlertSourceDataUpdateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AlertSourceDataUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? type = null,
    Object? authType = null,
    Object? baseURL = null,
    Object? username = null,
    Object? password = null,
    Object? errorMessage = null,
    Object? isValid = freezed,
    Object? accessToken = null,
    Object? serial = freezed,
  }) {
    return _then(_$AlertSourceDataUpdateImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      authType: null == authType
          ? _value.authType
          : authType // ignore: cast_nullable_to_non_nullable
              as int,
      baseURL: null == baseURL
          ? _value.baseURL
          : baseURL // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      isValid: freezed == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool?,
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      serial: freezed == serial
          ? _value.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlertSourceDataUpdateImpl implements _AlertSourceDataUpdate {
  const _$AlertSourceDataUpdateImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.authType,
      required this.baseURL,
      required this.username,
      required this.password,
      required this.errorMessage,
      this.isValid,
      required this.accessToken,
      this.serial});

  factory _$AlertSourceDataUpdateImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlertSourceDataUpdateImplFromJson(json);

  @override
  final int? id;
  @override
  final String name;
  @override
  final int type;
  @override
  final int authType;
  @override
  final String baseURL;
  @override
  final String username;
  @override
  final String password;
  @override
  final String errorMessage;
  @override
  final bool? isValid;
  @override
  final String accessToken;
  @override
  final int? serial;

  @override
  String toString() {
    return 'AlertSourceDataUpdate(id: $id, name: $name, type: $type, authType: $authType, baseURL: $baseURL, username: $username, password: $password, errorMessage: $errorMessage, isValid: $isValid, accessToken: $accessToken, serial: $serial)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertSourceDataUpdateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.authType, authType) ||
                other.authType == authType) &&
            (identical(other.baseURL, baseURL) || other.baseURL == baseURL) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.serial, serial) || other.serial == serial));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, type, authType,
      baseURL, username, password, errorMessage, isValid, accessToken, serial);

  /// Create a copy of AlertSourceDataUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertSourceDataUpdateImplCopyWith<_$AlertSourceDataUpdateImpl>
      get copyWith => __$$AlertSourceDataUpdateImplCopyWithImpl<
          _$AlertSourceDataUpdateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlertSourceDataUpdateImplToJson(
      this,
    );
  }
}

abstract class _AlertSourceDataUpdate implements AlertSourceDataUpdate {
  const factory _AlertSourceDataUpdate(
      {required final int? id,
      required final String name,
      required final int type,
      required final int authType,
      required final String baseURL,
      required final String username,
      required final String password,
      required final String errorMessage,
      final bool? isValid,
      required final String accessToken,
      final int? serial}) = _$AlertSourceDataUpdateImpl;

  factory _AlertSourceDataUpdate.fromJson(Map<String, dynamic> json) =
      _$AlertSourceDataUpdateImpl.fromJson;

  @override
  int? get id;
  @override
  String get name;
  @override
  int get type;
  @override
  int get authType;
  @override
  String get baseURL;
  @override
  String get username;
  @override
  String get password;
  @override
  String get errorMessage;
  @override
  bool? get isValid;
  @override
  String get accessToken;
  @override
  int? get serial;

  /// Create a copy of AlertSourceDataUpdate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlertSourceDataUpdateImplCopyWith<_$AlertSourceDataUpdateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

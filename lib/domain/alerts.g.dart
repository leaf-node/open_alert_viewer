// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alerts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlertImpl _$$AlertImplFromJson(Map<String, dynamic> json) => _$AlertImpl(
      source: (json['source'] as num).toInt(),
      kind: $enumDecode(_$AlertTypeEnumMap, json['kind']),
      hostname: json['hostname'] as String,
      service: json['service'] as String,
      message: json['message'] as String,
      url: json['url'] as String,
      age: Duration(microseconds: (json['age'] as num).toInt()),
      downtimeScheduled: json['downtimeScheduled'] as bool,
      silenced: json['silenced'] as bool,
      active: json['active'] as bool,
    );

Map<String, dynamic> _$$AlertImplToJson(_$AlertImpl instance) =>
    <String, dynamic>{
      'source': instance.source,
      'kind': _$AlertTypeEnumMap[instance.kind]!,
      'hostname': instance.hostname,
      'service': instance.service,
      'message': instance.message,
      'url': instance.url,
      'age': instance.age.inMicroseconds,
      'downtimeScheduled': instance.downtimeScheduled,
      'silenced': instance.silenced,
      'active': instance.active,
    };

const _$AlertTypeEnumMap = {
  AlertType.okay: 'okay',
  AlertType.warning: 'warning',
  AlertType.error: 'error',
  AlertType.pending: 'pending',
  AlertType.unknown: 'unknown',
  AlertType.up: 'up',
  AlertType.unreachable: 'unreachable',
  AlertType.down: 'down',
  AlertType.hostPending: 'hostPending',
  AlertType.syncFailure: 'syncFailure',
};

_$AlertSourceDataImpl _$$AlertSourceDataImplFromJson(
        Map<String, dynamic> json) =>
    _$AlertSourceDataImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      type: (json['type'] as num).toInt(),
      authType: (json['authType'] as num).toInt(),
      baseURL: json['baseURL'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      failing: json['failing'] as bool,
      lastSeen: DateTime.parse(json['lastSeen'] as String),
      priorFetch: DateTime.parse(json['priorFetch'] as String),
      lastFetch: DateTime.parse(json['lastFetch'] as String),
      errorMessage: json['errorMessage'] as String,
      isValid: json['isValid'] as bool?,
      accessToken: json['accessToken'] as String,
      visible: json['visible'] as bool,
      notifications: json['notifications'] as bool,
      serial: (json['serial'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AlertSourceDataImplToJson(
        _$AlertSourceDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'authType': instance.authType,
      'baseURL': instance.baseURL,
      'username': instance.username,
      'password': instance.password,
      'failing': instance.failing,
      'lastSeen': instance.lastSeen.toIso8601String(),
      'priorFetch': instance.priorFetch.toIso8601String(),
      'lastFetch': instance.lastFetch.toIso8601String(),
      'errorMessage': instance.errorMessage,
      'isValid': instance.isValid,
      'accessToken': instance.accessToken,
      'visible': instance.visible,
      'notifications': instance.notifications,
      'serial': instance.serial,
    };

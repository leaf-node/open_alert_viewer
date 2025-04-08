// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alerts_zab.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ZabEventsData _$ZabEventsDataFromJson(Map<String, dynamic> json) =>
    _ZabEventsData(
      result:
          (json['result'] as List<dynamic>?)
              ?.map((e) => ZabEventData.fromJson(e as Map<String, dynamic>))
              .toList(),
      error:
          json['error'] == null
              ? null
              : ZabErrorData.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ZabEventsDataToJson(_ZabEventsData instance) =>
    <String, dynamic>{'result': instance.result, 'error': instance.error};

_ZabEventData _$ZabEventDataFromJson(Map<String, dynamic> json) =>
    _ZabEventData(
      name: json['name'] as String?,
      clock: json['clock'] as String?,
      opdata: json['opdata'] as String?,
      severity: json['severity'] as String?,
      objectid: json['objectid'] as String?,
      suppressed: json['suppressed'] as String?,
      acknowledged: json['acknowledged'] as String?,
      hosts:
          (json['hosts'] as List<dynamic>?)
              ?.map((e) => ZabHostData.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$ZabEventDataToJson(_ZabEventData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'clock': instance.clock,
      'opdata': instance.opdata,
      'severity': instance.severity,
      'objectid': instance.objectid,
      'suppressed': instance.suppressed,
      'acknowledged': instance.acknowledged,
      'hosts': instance.hosts,
    };

_ZabHostData _$ZabHostDataFromJson(Map<String, dynamic> json) => _ZabHostData(
  host: json['host'] as String?,
  name: json['name'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$ZabHostDataToJson(_ZabHostData instance) =>
    <String, dynamic>{
      'host': instance.host,
      'name': instance.name,
      'status': instance.status,
    };

_ZabErrorData _$ZabErrorDataFromJson(Map<String, dynamic> json) =>
    _ZabErrorData(
      message: json['message'] as String?,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$ZabErrorDataToJson(_ZabErrorData instance) =>
    <String, dynamic>{'message': instance.message, 'data': instance.data};

_ZabVersionData _$ZabVersionDataFromJson(Map<String, dynamic> json) =>
    _ZabVersionData(result: json['result'] as String?);

Map<String, dynamic> _$ZabVersionDataToJson(_ZabVersionData instance) =>
    <String, dynamic>{'result': instance.result};

_ZabProblemsData _$ZabProblemsDataFromJson(Map<String, dynamic> json) =>
    _ZabProblemsData(
      result:
          (json['result'] as List<dynamic>?)
              ?.map((e) => ZabProblemData.fromJson(e as Map<String, dynamic>))
              .toList(),
      error:
          json['error'] == null
              ? null
              : ZabErrorData.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ZabProblemsDataToJson(_ZabProblemsData instance) =>
    <String, dynamic>{'result': instance.result, 'error': instance.error};

_ZabProblemData _$ZabProblemDataFromJson(Map<String, dynamic> json) =>
    _ZabProblemData(
      eventid: json['eventid'] as String?,
      objectid: json['objectid'] as String?,
    );

Map<String, dynamic> _$ZabProblemDataToJson(_ZabProblemData instance) =>
    <String, dynamic>{
      'eventid': instance.eventid,
      'objectid': instance.objectid,
    };

_ZabTriggersData _$ZabTriggersDataFromJson(Map<String, dynamic> json) =>
    _ZabTriggersData(
      result:
          (json['result'] as List<dynamic>?)
              ?.map((e) => ZabTriggerData.fromJson(e as Map<String, dynamic>))
              .toList(),
      error:
          json['error'] == null
              ? null
              : ZabErrorData.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ZabTriggersDataToJson(_ZabTriggersData instance) =>
    <String, dynamic>{'result': instance.result, 'error': instance.error};

_ZabTriggerData _$ZabTriggerDataFromJson(Map<String, dynamic> json) =>
    _ZabTriggerData(
      triggerid: json['triggerid'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ZabTriggerDataToJson(_ZabTriggerData instance) =>
    <String, dynamic>{
      'triggerid': instance.triggerid,
      'status': instance.status,
    };

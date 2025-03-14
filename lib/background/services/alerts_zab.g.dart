// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alerts_zab.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ZabAlertsData _$ZabAlertsDataFromJson(Map<String, dynamic> json) =>
    _ZabAlertsData(
      result:
          (json['result'] as List<dynamic>?)
              ?.map((e) => ZabAlertData.fromJson(e as Map<String, dynamic>))
              .toList(),
      error:
          json['error'] == null
              ? null
              : ZabErrorData.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ZabAlertsDataToJson(_ZabAlertsData instance) =>
    <String, dynamic>{'result': instance.result, 'error': instance.error};

_ZabAlertData _$ZabAlertDataFromJson(Map<String, dynamic> json) =>
    _ZabAlertData(
      name: json['name'] as String?,
      clock: json['clock'] as String?,
      opdata: json['opdata'] as String?,
      severity: json['severity'] as String?,
      suppressed: json['suppressed'] as String?,
      acknowledged: json['acknowledged'] as String?,
      hosts:
          (json['hosts'] as List<dynamic>?)
              ?.map((e) => ZabHostsData.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$ZabAlertDataToJson(_ZabAlertData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'clock': instance.clock,
      'opdata': instance.opdata,
      'severity': instance.severity,
      'suppressed': instance.suppressed,
      'acknowledged': instance.acknowledged,
      'hosts': instance.hosts,
    };

_ZabHostsData _$ZabHostsDataFromJson(Map<String, dynamic> json) =>
    _ZabHostsData(host: json['host'] as String?, name: json['name'] as String?);

Map<String, dynamic> _$ZabHostsDataToJson(_ZabHostsData instance) =>
    <String, dynamic>{'host': instance.host, 'name': instance.name};

_ZabErrorData _$ZabErrorDataFromJson(Map<String, dynamic> json) =>
    _ZabErrorData(
      message: json['message'] as String?,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$ZabErrorDataToJson(_ZabErrorData instance) =>
    <String, dynamic>{'message': instance.message, 'data': instance.data};

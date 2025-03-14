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
    );

Map<String, dynamic> _$ZabAlertsDataToJson(_ZabAlertsData instance) =>
    <String, dynamic>{'result': instance.result};

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

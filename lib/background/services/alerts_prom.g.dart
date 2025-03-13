// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alerts_prom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PromAlertsData _$PromAlertsDataFromJson(Map<String, dynamic> json) =>
    _PromAlertsData(
      startsAt: json['startsAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      endsAt: json['endsAt'] as String?,
      generatorURL: json['generatorURL'] as String?,
      annotations:
          json['annotations'] == null
              ? null
              : AnnotationsData.fromJson(
                json['annotations'] as Map<String, dynamic>,
              ),
      labels:
          json['labels'] == null
              ? null
              : LabelsData.fromJson(json['labels'] as Map<String, dynamic>),
      status:
          json['status'] == null
              ? null
              : StatusData.fromJson(json['status'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PromAlertsDataToJson(_PromAlertsData instance) =>
    <String, dynamic>{
      'startsAt': instance.startsAt,
      'updatedAt': instance.updatedAt,
      'endsAt': instance.endsAt,
      'generatorURL': instance.generatorURL,
      'annotations': instance.annotations,
      'labels': instance.labels,
      'status': instance.status,
    };

_AnnotationsData _$AnnotationsDataFromJson(Map<String, dynamic> json) =>
    _AnnotationsData(summary: json['summary'] as String?);

Map<String, dynamic> _$AnnotationsDataToJson(_AnnotationsData instance) =>
    <String, dynamic>{'summary': instance.summary};

_StatusData _$StatusDataFromJson(Map<String, dynamic> json) => _StatusData(
  silencedBy:
      (json['silencedBy'] as List<dynamic>?)?.map((e) => e as Object).toList(),
);

Map<String, dynamic> _$StatusDataToJson(_StatusData instance) =>
    <String, dynamic>{'silencedBy': instance.silencedBy};

_LabelsData _$LabelsDataFromJson(Map<String, dynamic> json) => _LabelsData(
  severity: json['severity'] as String?,
  oav_type: json['oav_type'] as String?,
  instance: json['instance'] as String?,
  alertname: json['alertname'] as String?,
);

Map<String, dynamic> _$LabelsDataToJson(_LabelsData instance) =>
    <String, dynamic>{
      'severity': instance.severity,
      'oav_type': instance.oav_type,
      'instance': instance.instance,
      'alertname': instance.alertname,
    };

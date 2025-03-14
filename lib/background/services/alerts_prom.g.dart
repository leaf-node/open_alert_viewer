// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alerts_prom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PromAlertsDataImpl _$$PromAlertsDataImplFromJson(Map<String, dynamic> json) =>
    _$PromAlertsDataImpl(
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

Map<String, dynamic> _$$PromAlertsDataImplToJson(
  _$PromAlertsDataImpl instance,
) => <String, dynamic>{
  'startsAt': instance.startsAt,
  'updatedAt': instance.updatedAt,
  'endsAt': instance.endsAt,
  'generatorURL': instance.generatorURL,
  'annotations': instance.annotations,
  'labels': instance.labels,
  'status': instance.status,
};

_$AnnotationsDataImpl _$$AnnotationsDataImplFromJson(
  Map<String, dynamic> json,
) => _$AnnotationsDataImpl(summary: json['summary'] as String?);

Map<String, dynamic> _$$AnnotationsDataImplToJson(
  _$AnnotationsDataImpl instance,
) => <String, dynamic>{'summary': instance.summary};

_$StatusDataImpl _$$StatusDataImplFromJson(Map<String, dynamic> json) =>
    _$StatusDataImpl(
      silencedBy:
          (json['silencedBy'] as List<dynamic>?)
              ?.map((e) => e as Object)
              .toList(),
    );

Map<String, dynamic> _$$StatusDataImplToJson(_$StatusDataImpl instance) =>
    <String, dynamic>{'silencedBy': instance.silencedBy};

_$LabelsDataImpl _$$LabelsDataImplFromJson(Map<String, dynamic> json) =>
    _$LabelsDataImpl(
      severity: json['severity'] as String?,
      oav_type: json['oav_type'] as String?,
      instance: json['instance'] as String?,
      alertname: json['alertname'] as String?,
    );

Map<String, dynamic> _$$LabelsDataImplToJson(_$LabelsDataImpl instance) =>
    <String, dynamic>{
      'severity': instance.severity,
      'oav_type': instance.oav_type,
      'instance': instance.instance,
      'alertname': instance.alertname,
    };

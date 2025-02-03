// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alerts_nag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NagAlertsDataImpl _$$NagAlertsDataImplFromJson(Map<String, dynamic> json) =>
    _$NagAlertsDataImpl(
      description: json['description'] as String?,
      status: (json['status'] as num?)?.toInt(),
      scheduled_downtime_depth:
          (json['scheduled_downtime_depth'] as num?)?.toInt(),
      problem_has_been_acknowledged:
          json['problem_has_been_acknowledged'] as bool?,
      last_state_change: (json['last_state_change'] as num?)?.toInt(),
      last_hard_state_change: (json['last_hard_state_change'] as num?)?.toInt(),
      last_check: (json['last_check'] as num?)?.toInt(),
      state_type: (json['state_type'] as num?)?.toInt(),
      plugin_output: json['plugin_output'] as String?,
    );

Map<String, dynamic> _$$NagAlertsDataImplToJson(_$NagAlertsDataImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'status': instance.status,
      'scheduled_downtime_depth': instance.scheduled_downtime_depth,
      'problem_has_been_acknowledged': instance.problem_has_been_acknowledged,
      'last_state_change': instance.last_state_change,
      'last_hard_state_change': instance.last_hard_state_change,
      'last_check': instance.last_check,
      'state_type': instance.state_type,
      'plugin_output': instance.plugin_output,
    };

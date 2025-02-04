// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alerts_ici.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IciAlertsDataImpl _$$IciAlertsDataImplFromJson(Map<String, dynamic> json) =>
    _$IciAlertsDataImpl(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => IciResultsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$IciAlertsDataImplToJson(_$IciAlertsDataImpl instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

_$IciResultsDataImpl _$$IciResultsDataImplFromJson(Map<String, dynamic> json) =>
    _$IciResultsDataImpl(
      attrs: json['attrs'] == null
          ? null
          : AttrsData.fromJson(json['attrs'] as Map<String, dynamic>),
      joins: json['joins'] == null
          ? null
          : JoinsData.fromJson(json['joins'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$IciResultsDataImplToJson(
        _$IciResultsDataImpl instance) =>
    <String, dynamic>{
      'attrs': instance.attrs,
      'joins': instance.joins,
    };

_$AttrsDataImpl _$$AttrsDataImplFromJson(Map<String, dynamic> json) =>
    _$AttrsDataImpl(
      display_name: json['display_name'] as String?,
      state: json['state'] as num?,
      downtime_depth: json['downtime_depth'] as num?,
      acknowledgement: json['acknowledgement'] as num?,
      last_state_change: json['last_state_change'] as num?,
      last_hard_state_change: json['last_hard_state_change'] as num?,
      last_check: json['last_check'] as num?,
      last_check_result: json['last_check_result'] == null
          ? null
          : LastCheckResultData.fromJson(
              json['last_check_result'] as Map<String, dynamic>),
      state_type: json['state_type'] as num?,
    );

Map<String, dynamic> _$$AttrsDataImplToJson(_$AttrsDataImpl instance) =>
    <String, dynamic>{
      'display_name': instance.display_name,
      'state': instance.state,
      'downtime_depth': instance.downtime_depth,
      'acknowledgement': instance.acknowledgement,
      'last_state_change': instance.last_state_change,
      'last_hard_state_change': instance.last_hard_state_change,
      'last_check': instance.last_check,
      'last_check_result': instance.last_check_result,
      'state_type': instance.state_type,
    };

_$LastCheckResultDataImpl _$$LastCheckResultDataImplFromJson(
        Map<String, dynamic> json) =>
    _$LastCheckResultDataImpl(
      output: json['output'] as String?,
    );

Map<String, dynamic> _$$LastCheckResultDataImplToJson(
        _$LastCheckResultDataImpl instance) =>
    <String, dynamic>{
      'output': instance.output,
    };

_$JoinsDataImpl _$$JoinsDataImplFromJson(Map<String, dynamic> json) =>
    _$JoinsDataImpl(
      host: json['host'] == null
          ? null
          : HostsData.fromJson(json['host'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$JoinsDataImplToJson(_$JoinsDataImpl instance) =>
    <String, dynamic>{
      'host': instance.host,
    };

_$HostsDataImpl _$$HostsDataImplFromJson(Map<String, dynamic> json) =>
    _$HostsDataImpl(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$HostsDataImplToJson(_$HostsDataImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

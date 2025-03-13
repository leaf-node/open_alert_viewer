// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alerts_ici.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IciAlertsData _$IciAlertsDataFromJson(Map<String, dynamic> json) =>
    _IciAlertsData(
      results:
          (json['results'] as List<dynamic>?)
              ?.map((e) => IciResultsData.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$IciAlertsDataToJson(_IciAlertsData instance) =>
    <String, dynamic>{'results': instance.results};

_IciResultsData _$IciResultsDataFromJson(Map<String, dynamic> json) =>
    _IciResultsData(
      attrs:
          json['attrs'] == null
              ? null
              : AttrsData.fromJson(json['attrs'] as Map<String, dynamic>),
      joins:
          json['joins'] == null
              ? null
              : JoinsData.fromJson(json['joins'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IciResultsDataToJson(_IciResultsData instance) =>
    <String, dynamic>{'attrs': instance.attrs, 'joins': instance.joins};

_AttrsData _$AttrsDataFromJson(Map<String, dynamic> json) => _AttrsData(
  display_name: json['display_name'] as String?,
  state: json['state'] as num?,
  downtime_depth: json['downtime_depth'] as num?,
  acknowledgement: json['acknowledgement'] as num?,
  last_state_change: json['last_state_change'] as num?,
  last_hard_state_change: json['last_hard_state_change'] as num?,
  last_check: json['last_check'] as num?,
  last_check_result:
      json['last_check_result'] == null
          ? null
          : LastCheckResultData.fromJson(
            json['last_check_result'] as Map<String, dynamic>,
          ),
  state_type: json['state_type'] as num?,
);

Map<String, dynamic> _$AttrsDataToJson(_AttrsData instance) =>
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

_LastCheckResultData _$LastCheckResultDataFromJson(Map<String, dynamic> json) =>
    _LastCheckResultData(output: json['output'] as String?);

Map<String, dynamic> _$LastCheckResultDataToJson(
  _LastCheckResultData instance,
) => <String, dynamic>{'output': instance.output};

_JoinsData _$JoinsDataFromJson(Map<String, dynamic> json) => _JoinsData(
  host:
      json['host'] == null
          ? null
          : HostsData.fromJson(json['host'] as Map<String, dynamic>),
);

Map<String, dynamic> _$JoinsDataToJson(_JoinsData instance) =>
    <String, dynamic>{'host': instance.host};

_HostsData _$HostsDataFromJson(Map<String, dynamic> json) =>
    _HostsData(name: json['name'] as String?);

Map<String, dynamic> _$HostsDataToJson(_HostsData instance) =>
    <String, dynamic>{'name': instance.name};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IsolateMessageImpl _$$IsolateMessageImplFromJson(Map<String, dynamic> json) =>
    _$IsolateMessageImpl(
      name: $enumDecode(_$MessageNameEnumMap, json['name']),
      destination:
          $enumDecodeNullable(_$MessageDestinationEnumMap, json['destination']),
      id: (json['id'] as num?)?.toInt(),
      alerts: (json['alerts'] as List<dynamic>?)
          ?.map((e) => Alert.fromJson(e as Map<String, dynamic>))
          .toList(),
      sourceData: json['sourceData'] == null
          ? null
          : AlertSourceData.fromJson(
              json['sourceData'] as Map<String, dynamic>),
      allSources: (json['allSources'] as List<dynamic>?)
          ?.map((e) => AlertSourceData.fromJson(e as Map<String, dynamic>))
          .toList(),
      forceRefreshNow: json['forceRefreshNow'] as bool?,
      alreadyFetching: json['alreadyFetching'] as bool?,
    );

Map<String, dynamic> _$$IsolateMessageImplToJson(
        _$IsolateMessageImpl instance) =>
    <String, dynamic>{
      'name': _$MessageNameEnumMap[instance.name]!,
      'destination': _$MessageDestinationEnumMap[instance.destination],
      'id': instance.id,
      'alerts': instance.alerts,
      'sourceData': instance.sourceData,
      'allSources': instance.allSources,
      'forceRefreshNow': instance.forceRefreshNow,
      'alreadyFetching': instance.alreadyFetching,
    };

const _$MessageNameEnumMap = {
  MessageName.alertsInit: 'alertsInit',
  MessageName.alertsFetching: 'alertsFetching',
  MessageName.alertsFetched: 'alertsFetched',
  MessageName.fetchAlerts: 'fetchAlerts',
  MessageName.refreshTimer: 'refreshTimer',
  MessageName.addSource: 'addSource',
  MessageName.updateSource: 'updateSource',
  MessageName.removeSource: 'removeSource',
  MessageName.enableNotifications: 'enableNotifications',
  MessageName.disableNotifications: 'disableNotifications',
  MessageName.toggleSounds: 'toggleSounds',
  MessageName.playDesktopSound: 'playDesktopSound',
  MessageName.sourcesChanged: 'sourcesChanged',
  MessageName.sourcesFailure: 'sourcesFailure',
  MessageName.showRefreshIndicator: 'showRefreshIndicator',
  MessageName.updateLastSeen: 'updateLastSeen',
  MessageName.confirmSources: 'confirmSources',
  MessageName.confirmSourcesReply: 'confirmSourcesReply',
};

const _$MessageDestinationEnumMap = {
  MessageDestination.alerts: 'alerts',
  MessageDestination.notifications: 'notifications',
  MessageDestination.refreshIcon: 'refreshIcon',
  MessageDestination.accountSettings: 'accountSettings',
};

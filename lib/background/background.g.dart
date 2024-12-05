// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IsolateMessage _$IsolateMessageFromJson(Map<String, dynamic> json) =>
    IsolateMessage(
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
      sources: (json['sources'] as List<dynamic>?)
          ?.map((e) => AlertSource.fromJson(e as Map<String, dynamic>))
          .toList(),
      forceRefreshNow: json['forceRefreshNow'] as bool?,
      alreadyFetching: json['alreadyFetching'] as bool?,
    );

Map<String, dynamic> _$IsolateMessageToJson(IsolateMessage instance) =>
    <String, dynamic>{
      'name': _$MessageNameEnumMap[instance.name]!,
      'destination': _$MessageDestinationEnumMap[instance.destination],
      'id': instance.id,
      'alerts': instance.alerts?.map((e) => e.toJson()).toList(),
      'sourceData': instance.sourceData?.toJson(),
      'sources': instance.sources?.map((e) => e.toJson()).toList(),
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

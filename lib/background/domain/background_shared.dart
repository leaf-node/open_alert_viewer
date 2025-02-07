/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/alerts.dart';

part 'background_shared.freezed.dart';
part 'background_shared.g.dart';

enum MessageName {
  alertsInit,
  alertsFetching,
  alertsFetched,
  fetchAlerts,
  refreshTimer,
  initSources,
  addSource,
  updateSource,
  removeSource,
  enableNotifications,
  disableNotifications,
  toggleSounds,
  playDesktopSound,
  sourcesChanged,
  sourcesFailure,
  showRefreshIndicator,
  updateLastSeen,
  confirmSources,
  confirmSourcesReply,
  backgroundReady,
  alertFiltersChanged,
}

enum MessageDestination {
  drop,
  alerts,
  notifications,
  refreshIcon,
  sourceSettings,
  accountEditing,
}

@freezed
class IsolateMessage with _$IsolateMessage {
  const factory IsolateMessage({
    required MessageName name,
    MessageDestination? destination,
    int? id,
    List<Alert>? alerts,
    AlertSourceDataUpdate? sourceData,
    bool? forceRefreshNow,
    bool? alreadyFetching,
  }) = _IsolateMessage;

  factory IsolateMessage.fromJson(Map<String, dynamic> json) =>
      _$IsolateMessageFromJson(json);
}

class BackgroundTranslator {
  static String serialize(IsolateMessage message) {
    return jsonEncode(message);
  }

  static IsolateMessage deserialize(String message) {
    final messageMap = jsonDecode(message) as Map<String, dynamic>;
    return IsolateMessage.fromJson(messageMap);
  }
}

/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:freezed_annotation/freezed_annotation.dart';

part 'alerts.freezed.dart';
part 'alerts.g.dart';

enum AlertType {
  okay(name: "Okay"),
  warning(name: "Warning"),
  error(name: "Error"),
  pending(name: "Pending"),
  unknown(name: "Unknown"),
  up(name: "Up"),
  unreachable(name: "Unreachable"),
  down(name: "Down"),
  hostPending(name: "Host Pending"),
  syncFailure(name: "Sync Failure");

  const AlertType({required this.name});

  final String name;
}

@freezed
class Alert with _$Alert {
  const factory Alert({
    required int source,
    required AlertType kind,
    required String hostname,
    required String service,
    required String message,
    required String url,
    required Duration age,
    required bool downtimeScheduled,
    required bool silenced,
    required bool active,
  }) = _Alert;

  factory Alert.fromJson(Map<String, Object?> json) => _$AlertFromJson(json);
}

@freezed
class AlertSourceData with _$AlertSourceData {
  const factory AlertSourceData({
    required int? id,
    required String name,
    required int type,
    required int authType,
    required String baseURL,
    required String username,
    required String password,
    required bool failing,
    required DateTime lastSeen,
    required DateTime priorFetch,
    required DateTime lastFetch,
    required String errorMessage,
    bool? isValid,
    required String accessToken,
    required bool visible,
    required bool notifications,
    int? serial,
  }) = _AlertSourceData;

  factory AlertSourceData.fromJson(Map<String, Object?> json) =>
      _$AlertSourceDataFromJson(json);
}

enum SilenceTypes {
  downtimeScheduled("Downtime Scheduled", 0),
  acknowledged("Acknowledged", 1),
  inactive("Inactive", 2);

  const SilenceTypes(this.text, this.id);

  final String text;
  final int id;
}

enum AuthTypes {
  basicAuth("Basic Auth", 0);

  const AuthTypes(this.text, this.value);

  final String text;
  final int value;
}

enum SourceTypes {
  demo("Demo", -2),
  nullType("Unknown", -1),
  autodetect("Autodetect", 0),
  ici("Icinga", 3),
  nag("Nagios Core", 2),
  prom("Prometheus Alertmanager", 1);

  const SourceTypes(this.text, this.value);
  final String text;
  final int value;
}

/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

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

class Alert {
  const Alert(
      {required this.source,
      required this.kind,
      required this.hostname,
      required this.service,
      required this.message,
      required this.url,
      required this.age});

  final int source;
  final AlertType kind;
  final String hostname;
  final String service;
  final String message;
  final String url;
  final Duration age;
}

class AlertSourceData {
  AlertSourceData({
    required this.id,
    required this.name,
    required this.type,
    required this.baseURL,
    required this.path,
    required this.username,
    required this.password,
    required this.failing,
    required this.lastSeen,
  });

  int? id;
  String name;
  int type;
  String baseURL;
  String path;
  String username;
  String password;
  bool failing;
  DateTime lastSeen;
}

abstract class AlertSource {
  const AlertSource({required this.sourceData});

  Future<List<Alert>> fetchAlerts();

  final AlertSourceData sourceData;
}

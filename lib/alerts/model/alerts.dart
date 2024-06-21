/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

enum AlertType {
  okay,
  warning,
  error,
  pending,
  unknown,
  up,
  unreachable,
  down,
  hostPending,
  syncFailure
}

class Alert {
  const Alert(
      {required this.source,
      required this.kind,
      required this.hostname,
      required this.service,
      required this.message,
      required this.age});

  final int source;
  final AlertType kind;
  final String hostname;
  final String service;
  final String message;
  final Duration age;
}

abstract class AlertSource {
  const AlertSource(
      {required this.id,
      required this.name,
      required this.type,
      required this.url,
      required this.username,
      required this.password});

  Future<List<Alert>> fetchAlerts();

  final int id;
  final String name;
  final int type;
  final String url;
  final String username;
  final String password;
}

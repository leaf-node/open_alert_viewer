/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:equatable/equatable.dart';

enum AlertType {
  okay,
  warning,
  error,
  pending,
  unknown,
  up,
  unreachable,
  down,
  hostPending
}

class Alert extends Equatable {
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

  @override
  List<Object> get props => [source, kind, hostname, service, message, age];
}

abstract class AlertSource {
  const AlertSource();

  Future<List<Alert>> fetchAlerts({required Duration maxCacheAge});
}

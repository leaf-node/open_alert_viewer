/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import '../model/alerts.dart';
import 'package:equatable/equatable.dart';

abstract class AlertState extends Equatable {
  const AlertState({required this.alerts});

  final List<Alert> alerts;

  @override
  List<Object> get props => alerts;
}

final class AlertsInit extends AlertState {
  const AlertsInit() : super(alerts: const []);
}

final class AlertsFetching extends AlertState {
  const AlertsFetching({required super.alerts});
}

final class AlertsFetched extends AlertState {
  const AlertsFetched({required super.alerts});
}

final class SourcesListUpdateError extends AlertState {
  const SourcesListUpdateError({required super.alerts});
}

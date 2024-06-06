/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import '../model/alerts.dart';
import 'package:equatable/equatable.dart';

abstract class AlertState extends Equatable {
  const AlertState({required this.alerts, required this.sources});

  final List<Alert> alerts;
  final List<AlertSource> sources;

  @override
  List<Object> get props => [...sources, ...alerts];
}

final class AlertsInit extends AlertState {
  const AlertsInit() : super(alerts: const [], sources: const []);
}

final class AlertsFetching extends AlertState {
  const AlertsFetching({required super.alerts, required super.sources});
}

final class AlertsFetched extends AlertState {
  const AlertsFetched({required super.alerts, required super.sources});
}

final class SourcesChanged extends AlertState {
  const SourcesChanged({required super.alerts, required super.sources});
}

final class SourcesListUpdateError extends AlertState {
  const SourcesListUpdateError({required super.alerts, required super.sources});
}

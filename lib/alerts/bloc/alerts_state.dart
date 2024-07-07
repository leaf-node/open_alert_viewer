/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import '../model/alerts.dart';

abstract class AlertState {
  const AlertState({required this.alerts, required this.sources});

  final List<Alert> alerts;
  final List<AlertSource> sources;
}

final class AlertsInit extends AlertState {
  AlertsInit({required super.alerts, required super.sources});
}

final class AlertsFetching extends AlertState {
  AlertsFetching({required super.alerts, required super.sources});
}

final class AlertsFetched extends AlertState {
  AlertsFetched({required super.alerts, required super.sources});
}

final class SourcesChanged extends AlertState {
  SourcesChanged({required super.alerts, required super.sources});
}

final class SourcesListUpdateError extends AlertState {
  SourcesListUpdateError({required super.alerts, required super.sources});
}

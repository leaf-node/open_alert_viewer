/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
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

final class SourcesChangedEvent extends AlertState {
  SourcesChangedEvent({required super.alerts, required super.sources});
}

final class SourcesUpdateError extends AlertState {
  SourcesUpdateError({required super.alerts, required super.sources});
}

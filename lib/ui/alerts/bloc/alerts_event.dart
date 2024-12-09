/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import '../../../domain/alerts.dart';

abstract class AlertEvent {
  const AlertEvent();
}

final class ListenForAlerts implements AlertEvent {}

final class FetchAlerts implements AlertEvent {
  FetchAlerts({required this.forceRefreshNow});

  final bool forceRefreshNow;
}

final class AddAlertSource implements AlertEvent {
  AddAlertSource({required this.sourceData});

  final AlertSourceData sourceData;
}

final class UpdateAlertSource implements AlertEvent {
  UpdateAlertSource({required this.sourceData});

  final AlertSourceData sourceData;
}

final class RemoveAlertSource implements AlertEvent {
  RemoveAlertSource({required this.id});

  final int id;
}

final class UpdateLastSeen implements AlertEvent {
  UpdateLastSeen();
}

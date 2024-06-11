/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

abstract class AlertEvent {
  const AlertEvent();
}

final class FetchAlerts implements AlertEvent {
  const FetchAlerts({required this.forceRefreshNow});

  final bool forceRefreshNow;
}

final class AddAlertSource implements AlertEvent {
  const AddAlertSource({required this.source});

  final List<String> source;
}

final class UpdateAlertSource implements AlertEvent {
  const UpdateAlertSource({required this.id, required this.values});

  final int id;
  final List<Object> values;
}

final class RemoveAlertSource implements AlertEvent {
  const RemoveAlertSource({required this.id});

  final int id;
}

/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

abstract class AlertEvent {
  const AlertEvent();
}

final class FetchAlerts implements AlertEvent {
  const FetchAlerts({required this.maxCacheAge});

  final Duration maxCacheAge;
}

final class AddAlertSources implements AlertEvent {
  const AddAlertSources({required this.sources});

  final List<List<String>> sources;
}

final class RemoveAlertSource implements AlertEvent {
  const RemoveAlertSource({required this.id});

  final int id;
}

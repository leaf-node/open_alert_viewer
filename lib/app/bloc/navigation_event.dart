/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:open_alert_viewer/alerts/model/alerts.dart';

abstract class NavEvent {}

final class OpenSplashPageEvent implements NavEvent {}

final class OpenAlertsPageEvent implements NavEvent {}

final class OpenSettingsPageEvent implements NavEvent {}

final class OpenGeneralSettingsPageEvent implements NavEvent {}

final class OpenAccountSettingsPageEvent implements NavEvent {
  const OpenAccountSettingsPageEvent({required this.source});

  final AlertSource? source;
}

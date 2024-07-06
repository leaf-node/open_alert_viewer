/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import '../../alerts/model/alerts.dart';

abstract class NavEvent {}

final class OpenAlertsPageEvent implements NavEvent {}

final class OpenSettingsPageEvent implements NavEvent {}

final class OpenGeneralSettingsPageEvent implements NavEvent {}

final class OpenAccountSettingsPageEvent implements NavEvent {
  OpenAccountSettingsPageEvent({required this.source});

  final AlertSource? source;
}

final class OpenLicensingPageEvent implements NavEvent {}

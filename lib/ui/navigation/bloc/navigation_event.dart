/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import '../../../domain/alerts.dart';

abstract class NavEvent {}

final class OpenAlertsPageEvent implements NavEvent {}

final class OpenSettingsPageEvent implements NavEvent {}

final class OpenGeneralSettingsPageEvent implements NavEvent {}

final class OpenAboutPageEvent implements NavEvent {}

final class OpenAccountSettingsPageEvent implements NavEvent {
  OpenAccountSettingsPageEvent({required this.source});

  final AlertSource? source;
}

final class OpenLicensingPageEvent implements NavEvent {}

final class OpenPrivacyPageEvent implements NavEvent {}

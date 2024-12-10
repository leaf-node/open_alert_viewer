/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import '../../../domain/alerts.dart';

abstract class NavEvent {}

final class OpenAlertsScreenEvent implements NavEvent {}

final class OpenSettingsScreenEvent implements NavEvent {}

final class OpenGeneralSettingsScreenEvent implements NavEvent {}

final class OpenAboutScreenEvent implements NavEvent {}

final class OpenAccountSettingsScreenEvent implements NavEvent {
  OpenAccountSettingsScreenEvent({required this.source});

  final AlertSourceData? source;
}

final class OpenLicensingScreenEvent implements NavEvent {}

final class OpenPrivacyScreenEvent implements NavEvent {}

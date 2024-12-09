/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import '../../../domain/alerts.dart';

abstract class NavState {
  const NavState();
}

final class ShowAlertsScreen extends NavState {
  ShowAlertsScreen();
}

final class ShowSettingsScreen extends NavState {
  ShowSettingsScreen();
}

final class ShowAboutScreen extends NavState {
  ShowAboutScreen();
}

final class ShowGeneralSettingsScreen extends NavState {
  ShowGeneralSettingsScreen();
}

final class ShowAccountSettingsScreen extends NavState {
  ShowAccountSettingsScreen({required this.source});

  final AlertSource? source;
}

final class ShowLicensingScreen extends NavState {
  ShowLicensingScreen();
}

final class ShowPrivacyScreen extends NavState {
  ShowPrivacyScreen();
}

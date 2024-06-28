/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import '../../alerts/model/alerts.dart';

abstract class NavState {
  const NavState();
}

final class ShowSplashPage extends NavState {
  ShowSplashPage();
}

final class ShowAlertsPage extends NavState {
  ShowAlertsPage();
}

final class ShowSettingsPage extends NavState {
  ShowSettingsPage();
}

final class ShowGeneralSettingsPage extends NavState {
  ShowGeneralSettingsPage();
}

final class ShowAccountSettingsPage extends NavState {
  ShowAccountSettingsPage({required this.source});

  final AlertSource? source;
}

final class ShowLicensingPage extends NavState {
  ShowLicensingPage();
}

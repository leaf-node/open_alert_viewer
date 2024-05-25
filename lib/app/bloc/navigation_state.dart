/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:open_alert_viewer/app/model/navigation.dart';

abstract class NavState {
  const NavState(this.status);

  final NavStatus status;
}

final class ShowSplashPage extends NavState {
  const ShowSplashPage() : super(NavStatus.splashPage);
}

final class ShowAlertsPage extends NavState {
  const ShowAlertsPage() : super(NavStatus.alertsPage);
}

final class ShowSettingsPage extends NavState {
  const ShowSettingsPage() : super(NavStatus.settingsPage);
}

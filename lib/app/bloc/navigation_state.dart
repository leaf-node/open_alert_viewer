/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import '../../alerts/model/alerts.dart';

abstract class NavState {
  const NavState();

  @override
  int get hashCode =>
      Object.hash("NavState", DateTime.now().microsecondsSinceEpoch);

  @override
  bool operator ==(Object other) {
    return false;
  }
}

final class ShowSplashPage extends NavState {
  const ShowSplashPage();
}

final class ShowAlertsPage extends NavState {
  const ShowAlertsPage();
}

final class ShowSettingsPage extends NavState {
  const ShowSettingsPage();
}

final class ShowGeneralSettingsPage extends NavState {
  const ShowGeneralSettingsPage();
}

final class ShowAccountSettingsPage extends NavState {
  const ShowAccountSettingsPage({required this.source});

  final AlertSource? source;

  @override
  int get hashCode => Object.hash(
      "AccountSettings", source, DateTime.now().microsecondsSinceEpoch);

  @override
  bool operator ==(Object other) {
    return false;
  }
}

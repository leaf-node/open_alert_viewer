/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

import '../../app/data_repository/settings_repository.dart';

enum BatterySetting {
  notApplicable("Not Applicable", false),
  unknown("Unknown", false),
  granted("Granted", true),
  limited("Limited", false),
  provisional("Provisional", false),
  denied("Denied", false),
  restricted("Restricted", false),
  permanentlyDenied("Permanently Denied", false);

  const BatterySetting(this.name, this.active);

  final String name;
  final bool active;
}

class BatteryPermissionRepo {
  BatteryPermissionRepo({required SettingsRepo settings})
      : _settings = settings;

  final SettingsRepo _settings;

  static Future<BatterySetting> getStatus() async {
    if (Platform.isAndroid) {
      final status = await Permission.ignoreBatteryOptimizations.status;
      if (status.isGranted) {
        return BatterySetting.granted;
      } else if (status.isLimited) {
        return BatterySetting.limited;
      } else if (status.isProvisional) {
        return BatterySetting.provisional;
      } else if (status.isDenied) {
        return BatterySetting.denied;
      } else if (status.isRestricted) {
        return BatterySetting.restricted;
      } else if (status.isPermanentlyDenied) {
        return BatterySetting.permanentlyDenied;
      } else {
        return BatterySetting.unknown;
      }
    } else {
      return BatterySetting.notApplicable;
    }
  }

  Future<void> requestBatteryPermission() async {
    _settings.batteryPermissionRequested = true;
    if (Platform.isAndroid) {
      await Permission.ignoreBatteryOptimizations.request();
    }
  }
}

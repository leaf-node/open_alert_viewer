/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

part of 'battery_permission_cubit.dart';

@immutable
class BatteryPermissionState {
  const BatteryPermissionState(this.value);

  const BatteryPermissionState.init() : value = BatterySetting.unknown;

  final BatterySetting value;
}

/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data_repository/battery_repository.dart';

part 'battery_permission_state.dart';

class BatteryPermissionCubit extends Cubit<BatteryPermissionState> {
  BatteryPermissionCubit(this.repo) : super(BatteryPermissionState.init()) {
    emitLatestState();
  }

  final BatteryPermissionRepo repo;

  Future<void> emitLatestState() async {
    emit(BatteryPermissionState(await BatteryPermissionRepo.getStatus()));
  }

  void requestPermission() async {
    if (!(state.value.active)) {
      await repo.requestBatteryPermission();
      await emitLatestState();
    }
  }
}

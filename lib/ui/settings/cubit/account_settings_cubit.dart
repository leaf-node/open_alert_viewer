/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/repositories/account_repo.dart';
import '../../../data/repositories/notifications_repo.dart';
import '../../../data/repositories/settings_repo.dart';
import '../../../domain/alerts.dart';

part 'account_settings_state.dart';
part 'account_settings_cubit.freezed.dart';

class AccountSettingsCubit extends Cubit<AccountSettingsState> {
  AccountSettingsCubit({
    required int id,
    required SettingsRepo settings,
    required AccountsRepo accountsRepo,
    required NotificationsRepo notificationRepo,
  }) : _id = id,
       _settings = settings,
       _accountsRepo = accountsRepo,
       _notificationsRepo = notificationRepo,
       super(
         AccountSettingsState.init(
           settings: settings,
           source: accountsRepo.getSource(id),
         ),
       ) {
    _state = state;
    refreshStateAsync();
  }

  final int _id;
  final SettingsRepo _settings;
  final AccountsRepo _accountsRepo;
  final NotificationsRepo _notificationsRepo;
  AccountSettingsState? _state;

  Future<void> refreshStateAsync() async {
    final globalNotificationsEnabled = await _settings.notificationsEnabledSafe;
    _state = _state!.copyWith(
      globalNotificationsEnabled: globalNotificationsEnabled,
      source: _accountsRepo.getSource(_id),
    );
    emit(_state!);
  }

  Future<void> switchVisibility() async {
    _accountsRepo.switchVisibility(_id);
    await refreshStateAsync();
  }

  Future<void> switchNotifications() async {
    _accountsRepo.switchNotifications(_id);
    await refreshStateAsync();
    _notificationsRepo.enableOrDisableNotifications();
  }
}

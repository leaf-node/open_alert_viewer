/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:open_alert_viewer/ui/alerts/bloc/refresh_bloc.dart';

import '../../../background/background.dart';
import '../../../data/repositories/battery_repository.dart';
import '../../../data/repositories/settings_repository.dart';
import '../../core/widgets/shared_widgets.dart';
import '../../notifications/bloc/notification_bloc.dart';
import 'general_settings_state.dart';

class SettingsCubit extends Cubit<SettingsCubitState> {
  SettingsCubit(
      {required SettingsRepo settings,
      required BackgroundChannel bgChannel,
      required NotificationBloc notificationBloc,
      required RefreshIconBloc refreshIconBloc})
      : _settingsRepo = settings,
        _bgChannel = bgChannel,
        _notificationBloc = notificationBloc,
        _refreshIconBloc = refreshIconBloc,
        super(SettingsCubitState.init()) {
    _state = state;
    refreshState();
  }

  final SettingsRepo _settingsRepo;
  final BackgroundChannel _bgChannel;
  final NotificationBloc _notificationBloc;
  final RefreshIconBloc _refreshIconBloc;
  SettingsCubitState? _state;

  Future<void> refreshState() async {
    _state = _state!.copyWith(refreshIntervalSubtitle: () {
      for (var option in RefreshFrequencies.values) {
        if (option.value == _settingsRepo.refreshInterval) {
          return option.text;
        }
      }
      return "Every ${_settingsRepo.refreshInterval} seconds";
    }());
    _state = _state!.copyWith(syncTimeoutSubtitle: () {
      for (var option in SyncTimeouts.values) {
        if (option.value == _settingsRepo.syncTimeout) {
          return option.text;
        }
      }
      return "Every ${_settingsRepo.syncTimeout} seconds";
    }());
    _state = _state!.copyWith(darkModeSubtitle: () {
      for (var option in ColorModes.values) {
        if (option.value == _settingsRepo.darkMode) {
          return option.text;
        }
      }
      return "Unknown";
    }());
    _state = _state!.copyWith(
        notificationsEnabledSubtitle: _settingsRepo.notificationsEnabled
            ? "Enabled within app"
            : "Disabled");
    _state = _state!.copyWith(
        soundEnabledSubtitle:
            _settingsRepo.soundEnabled ? "Enabled within app" : "Disabled");
    _state = _state!.copyWith(
        batteryPermissionSubtitle:
            (await BatteryPermissionRepo.getStatus()).name);
    _state = _state!.copyWith(settings: {
      "refreshInterval": _settingsRepo.refreshInterval,
      "syncTimeout": _settingsRepo.syncTimeout,
      "notificationsRequested": _settingsRepo.notificationsRequested,
      "notificationsEnabled": _settingsRepo.notificationsEnabled,
      "soundEnabled": _settingsRepo.soundEnabled,
      "alertFilter": _settingsRepo.alertFilter,
      "silenceFilter": _settingsRepo.silenceFilter,
      "darkMode": _settingsRepo.darkMode,
    });
    emit(_state!);
  }

  Future<void> onTapRefreshIntervalButton(int? result) async {
    if (result == -1) {
      _notificationBloc.add(DisableNotificationsEvent());
      await _pushSetting("notificationsEnabled", false);
    } else if (result != null) {
      _notificationBloc.add(EnableNotificationsEvent());
      await _pushSetting("notificationsEnabled", true);
    }
    if (result != null) {
      await _pushSetting("refreshInterval", result);
    }
  }

  Future<void> onTapSyncTimeoutButton(int? result) async {
    if (result != null) {
      await _pushSetting("syncTimeout", result);
      _refreshIconBloc.add(RefreshIconNow(forceRefreshNow: true));
    }
  }

  Future<void> onTapNotificationsEnabled(BuildContext context) async {
    if (_settingsRepo.notificationsEnabled) {
      await _pushSetting("notificationsEnabled", false);
      _notificationBloc.add(DisableNotificationsEvent());
    } else {
      requestAndEnableNotifications(
          askAgain: true,
          context: context,
          callback: () async {
            if (_settingsRepo.refreshInterval == -1) {
              await _pushSetting(
                  "refreshInterval", RefreshFrequencies.oneMinute.value);
            }
            await _pushSetting(
                "notificationsEnabled", _settingsRepo.notificationsEnabled);
          });
    }
  }

  Future<void> openAppSettings() async {
    AppSettings.openAppSettings(type: AppSettingsType.notification);
  }

  Future<void> onTapPlaySoundEnabled() async {
    await _pushSetting("soundEnabled", !_settingsRepo.soundEnabled);
    _notificationBloc.add(ToggleSounds());
  }

  Future<void> onTapDarkMode(int? result) async {
    if (result != null) {
      await _pushSetting("darkMode", result);
    }
  }

  Future<void> setAlertFilterAt(
      BuildContext context, bool? newValue, int index) async {
    await _pushSetting("setAlertFilterAt", (newValue!, index));
  }

  Future<void> setSilenceFilterAt(
      BuildContext context, bool? newValue, int index) async {
    await _pushSetting("setSilenceFilterAt", (newValue!, index));
  }

  Future<void> _pushSetting(String name, Object newSetting) async {
    switch (name) {
      case "refreshInterval":
        _settingsRepo.refreshInterval = newSetting;
        _bgChannel
            .makeRequest(const IsolateMessage(name: MessageName.refreshTimer));
      case "syncTimeout":
        _settingsRepo.syncTimeout = newSetting;
      case "notificationsRequested":
        _settingsRepo.notificationsRequested = newSetting;
      case "notificationsEnabled":
        _settingsRepo.notificationsEnabled = newSetting;
      case "soundEnabled":
        _settingsRepo.soundEnabled = newSetting;
      case "alertFilter":
        _settingsRepo.alertFilter = newSetting;
      case "setAlertFilterAt":
        bool value;
        int index;
        (value, index) = newSetting as (bool, int);
        _settingsRepo.setAlertFilterAt(value, index);
      case "silenceFilter":
        _settingsRepo.silenceFilter = newSetting;
      case "setSilenceFilterAt":
        bool value;
        int index;
        (value, index) = newSetting as (bool, int);
        _settingsRepo.setSilenceFilterAt(value, index);
      case "darkMode":
        _settingsRepo.darkMode = newSetting;
      case _:
        throw Exception("Unsupported setting: $name");
    }
    await refreshState();
  }
}

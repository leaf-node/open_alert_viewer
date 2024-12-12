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
      "notificationsEnabled": _settingsRepo.notificationsEnabled,
      "soundEnabled": _settingsRepo.soundEnabled,
      "alertFilter": _settingsRepo.alertFilter,
      "silenceFilter": _settingsRepo.silenceFilter,
      "darkMode": _settingsRepo.darkMode,
    });
    emit(_state!);
  }

  void onTapRefreshIntervalButton(int? result) {
    if (result == -1) {
      _notificationBloc.add(DisableNotificationsEvent());
      _settingsRepo.notificationsEnabled = false;
    } else if (result != null) {
      _notificationBloc.add(EnableNotificationsEvent());
      _settingsRepo.notificationsEnabled = true;
    }
    if (result != null) {
      _settingsRepo.refreshInterval = result;
      _bgChannel
          .makeRequest(const IsolateMessage(name: MessageName.refreshTimer));
    }
    refreshState();
  }

  void onTapSyncTimeoutButton(int? result) {
    if (result != null) {
      _settingsRepo.syncTimeout = result;
      _refreshIconBloc.add(RefreshIconNow(forceRefreshNow: true));
    }
    refreshState();
  }

  void onTapNotificationsEnabled(BuildContext context) {
    if (_settingsRepo.notificationsEnabled) {
      _settingsRepo.notificationsEnabled = false;
      _notificationBloc.add(DisableNotificationsEvent());
    } else {
      requestAndEnableNotifications(
          askAgain: true,
          context: context,
          callback: () {
            if (_settingsRepo.refreshInterval == -1) {
              _settingsRepo.refreshInterval =
                  RefreshFrequencies.oneMinute.value;
              _bgChannel.makeRequest(
                  const IsolateMessage(name: MessageName.refreshTimer));
            }
            refreshState();
          });
    }
    refreshState();
  }

  void openAppSettings() {
    AppSettings.openAppSettings(type: AppSettingsType.notification);
  }

  void onTapPlaySoundEnabled() {
    _settingsRepo.soundEnabled = !_settingsRepo.soundEnabled;
    _notificationBloc.add(ToggleSounds());
    refreshState();
  }

  void onTapDarkMode(int? result) {
    if (result != null) {
      _settingsRepo.darkMode = result;
      refreshState();
    }
  }

  void setAlertFilterAt(BuildContext context, bool? newValue, int index) {
    _settingsRepo.setAlertFilterAt(newValue!, index);
    refreshState();
  }

  void setSilenceFilterAt(BuildContext context, bool? newValue, int index) {
    _settingsRepo.setSilenceFilterAt(newValue!, index);
    refreshState();
  }
}

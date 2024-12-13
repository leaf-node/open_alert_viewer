/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../background/background.dart';
import '../../../data/repositories/settings_repository.dart';
import '../../../domain/alerts.dart';
import '../../../domain/navigation.dart';
import 'alerts_state.dart';

class AlertsCubit extends Cubit<AlertsCubitState> {
  AlertsCubit(
      {required BackgroundChannel bgChannel,
      required Navigation navigation,
      required SettingsRepo settings})
      : _bgChannel = bgChannel,
        _navigation = navigation,
        _settings = settings,
        super(AlertsCubitState.init()) {
    _state = state;
    _listenForSettings();
    _listenForAlerts();
    _refreshState();
  }

  AlertsCubitState? _state;
  final BackgroundChannel _bgChannel;
  final Navigation _navigation;
  final SettingsRepo _settings;

  void _refreshState() {
    final filter = _settings.alertFilter;
    bool areImportantShown = true;
    for (var kind in [
      AlertType.error,
      AlertType.down,
      AlertType.unreachable,
      AlertType.syncFailure
    ]) {
      if (filter[kind.index] == false) {
        areImportantShown = false;
        break;
      }
    }
    bool notifyEnabled = _settings.notificationsEnabled;
    bool soundEnabled = _settings.soundEnabled;
    _state = _state!.copyWith(settings: {
      "notifications_enabled": notifyEnabled,
      "sound_enabled": soundEnabled,
      "alert_filter": _settings.alertFilter
    });
    _state = _state!.copyWith(
        showNotificationStatusWidget: !notifyEnabled,
        showSoundStatusWidget: !soundEnabled && notifyEnabled,
        showFilterStatusWidget: !areImportantShown);
    emit(_state!);
  }

  void openRootSettings() {
    _navigation.goTo(Screens.rootSettings);
  }

  void openGeneralSettings() {
    _navigation.goTo(Screens.generalSettings);
  }

  void fetchAlerts({bool? forceRefreshNow}) async {
    _bgChannel.makeRequest(IsolateMessage(
        name: MessageName.fetchAlerts, forceRefreshNow: forceRefreshNow));
  }

  void updateLastSeen() {
    _bgChannel
        .makeRequest(const IsolateMessage(name: MessageName.updateLastSeen));
  }

  Future<void> _listenForSettings() async {
    await _settings.ready.future;
    await for (String name in _settings.stream!) {
      if (name == "notifications_enabled" ||
          name == "sound_enabled" ||
          name == "alert_filter") {
        _refreshState();
      }
    }
  }

  Future<void> _listenForAlerts() async {
    List<Alert> alerts = [];
    List<AlertSourceData> sources = [];
    FetchingStatus status;
    await for (final message
        in _bgChannel.isolateStreams[MessageDestination.alerts]!.stream) {
      alerts = message.alerts ?? alerts;
      sources = message.allSources ?? sources;
      if (message.name == MessageName.alertsInit) {
        status = FetchingStatus.init;
      } else if (message.name == MessageName.alertsFetching) {
        status = FetchingStatus.fetching;
      } else if (message.name == MessageName.alertsFetched) {
        status = FetchingStatus.fetched;
      } else {
        throw Exception(
            "OAV Invalid 'alert' stream message name: ${message.name}");
      }
      _state =
          _state!.copyWith(status: status, alerts: alerts, sources: sources);
      emit(_state!);
    }
  }
}

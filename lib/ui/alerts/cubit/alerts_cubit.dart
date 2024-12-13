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
    _listenForRefreshIcon();
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
    _updateAlertsState();
    emit(_state!);
  }

  void openRootSettings() {
    _navigation.goTo(Screens.rootSettings);
  }

  void openGeneralSettings() {
    _navigation.goTo(Screens.generalSettings);
  }

  void fetchAlerts({bool? forceRefreshNow}) {
    _bgChannel.makeRequest(IsolateMessage(
        name: MessageName.fetchAlerts, forceRefreshNow: forceRefreshNow));
  }

  void onTapRefresh() {
    updateLastSeen();
    if (_state!.refresh.status != RefreshIconStatus.triggeredOrRunning) {
      _triggerRefreshIcon(forceRefreshNow: true);
    }
  }

  void updateLastSeen() {
    _bgChannel
        .makeRequest(const IsolateMessage(name: MessageName.updateLastSeen));
  }

  void _triggerRefreshIcon(
      {required bool forceRefreshNow, bool? alreadyFetching}) {
    _state = _state!.copyWith(
        refresh: RefreshIconState(
            status: RefreshIconStatus.triggeredOrRunning,
            forceRefreshNow: forceRefreshNow,
            alreadyFetching:
                alreadyFetching ?? _state!.refresh.alreadyFetching));
    _refreshState();
  }

  void _updateAlertsState() {
    List<bool> filter = _settings.alertFilter;
    List<bool> silenceFilter = _settings.silenceFilter;
    List<Alert> filteredAlerts = [];
    for (var alert in _state!.alerts) {
      if (filter[alert.kind.index]) {
        if ((alert.downtimeScheduled &&
                !silenceFilter[SilenceTypes.downtimeScheduled.id]) ||
            (alert.silenced && !silenceFilter[SilenceTypes.acknowledged.id]) ||
            (!alert.active && !silenceFilter[SilenceTypes.inactive.id])) {
          continue;
        }
        filteredAlerts.add(alert);
      }
    }
    _state = _state!.copyWith(filteredAlerts: filteredAlerts);
    if (_state!.sources.isEmpty) {
      _state =
          _state!.copyWith(emptyPaneMessage: "Please configure an account");
    } else if (filteredAlerts.isEmpty) {
      String caveat = " ";
      if (_state!.alerts
          .where((v) => v.kind != AlertType.okay && v.kind != AlertType.up)
          .isNotEmpty) {
        caveat = " (filtered) ";
      }
      _state = _state!.copyWith(emptyPaneMessage: "No${caveat}alerts here!");
    }
  }

  Future<void> onRefresh() async {
    bool forceRefreshNow = true;
    bool alreadyFetching = false;
    if (_state!.refresh.status == RefreshIconStatus.triggeredOrRunning) {
      forceRefreshNow = _state!.refresh.forceRefreshNow;
      alreadyFetching = _state!.refresh.alreadyFetching;
    }
    if (!alreadyFetching) {
      fetchAlerts(forceRefreshNow: forceRefreshNow);
      await Future.delayed(const Duration(milliseconds: 100));
    }
    while (_state!.status == FetchingStatus.fetching) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    _state = _state!.copyWith(
        refresh: RefreshIconState(
            status: RefreshIconStatus.stopped,
            forceRefreshNow: false,
            alreadyFetching: false));
    _refreshState();
  }

  Future<void> _listenForRefreshIcon() async {
    await for (final message
        in _bgChannel.isolateStreams[MessageDestination.refreshIcon]!.stream) {
      if (message.name == MessageName.showRefreshIndicator) {
        _triggerRefreshIcon(
            forceRefreshNow: message.forceRefreshNow ?? false,
            alreadyFetching: message.alreadyFetching ?? false);
      } else {
        throw Exception(
            "OAV Invalid 'refresh' stream message name: ${message.name}");
      }
    }
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
      _refreshState();
    }
  }
}

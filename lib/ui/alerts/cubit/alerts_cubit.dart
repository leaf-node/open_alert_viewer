/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../background/domain/background_external.dart';
import '../../../background/domain/background_shared.dart';
import '../../../data/repositories/account_repo.dart';
import '../../../data/repositories/alerts_repo.dart';
import '../../../data/repositories/settings_repo.dart';
import '../../../domain/alerts.dart';
import 'alerts_state.dart';

class AlertsCubit extends Cubit<AlertsCubitState> {
  AlertsCubit({
    required BackgroundChannel bgChannel,
    required AlertsRepo alertsRepo,
    required AccountsRepo accounts,
    required SettingsRepo settings,
  }) : _bgChannel = bgChannel,
       _alertsRepo = alertsRepo,
       _accounts = accounts,
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
  final AlertsRepo _alertsRepo;
  final AccountsRepo _accounts;
  final SettingsRepo _settings;

  Future<void> _refreshState() async {
    final filter = _settings.alertFilter;
    bool areImportantShown = true;
    for (var kind in [
      AlertType.error,
      AlertType.down,
      AlertType.unreachable,
      AlertType.syncFailure,
    ]) {
      if (filter[kind.index] == false) {
        areImportantShown = false;
        break;
      }
    }
    bool notifyEnabled = await _settings.notificationsEnabledSafe;
    bool soundEnabled = _settings.soundEnabled;
    _state = _state!.copyWith(
      settings: {
        "notifications_enabled": notifyEnabled,
        "sound_enabled": soundEnabled,
        "alert_filter": _settings.alertFilter,
      },
    );
    final sources = _accounts.listSources();
    final anyInvisible = sources.where((e) => !e.visible).isNotEmpty;
    final anyNotificationsOff =
        sources.where((e) => !e.notifications).isNotEmpty;
    _state = _state!.copyWith(
      sources: sources,
      showVisibilityStatusWidget: anyInvisible,
      showNotificationStatusWidget: !notifyEnabled || anyNotificationsOff,
      showSoundStatusWidget: !soundEnabled && notifyEnabled,
      showFilterStatusWidget: !areImportantShown,
    );
    _updateAlertsState();
    emit(_state!);
  }

  Future<void> onTapRefresh() async {
    updateLastSeen();
    if (_state!.refresh.status != RefreshIconStatus.triggeredOrRunning) {
      await _triggerRefreshIcon(forceRefreshNow: true);
    }
  }

  void updateLastSeen() {
    _alertsRepo.updateLastSeen();
  }

  Future<void> _triggerRefreshIcon({
    required bool forceRefreshNow,
    bool? alreadyFetching,
  }) async {
    _state = _state!.copyWith(
      refresh: RefreshIconState(
        status: RefreshIconStatus.triggeredOrRunning,
        forceRefreshNow: forceRefreshNow,
        alreadyFetching: alreadyFetching ?? _state!.refresh.alreadyFetching,
      ),
    );
    await _refreshState();
  }

  void _updateAlertsState() {
    List<bool> filter = _settings.alertFilter;
    List<bool> silenceFilter = _settings.silenceFilter;
    List<Alert> filteredAlerts = [];
    for (var alert in _state!.alerts) {
      if (!filter[alert.kind.index]) {
        continue;
      }
      if ((alert.downtimeScheduled &&
              !silenceFilter[SilenceTypes.downtimeScheduled.id]) ||
          (alert.silenced && !silenceFilter[SilenceTypes.acknowledged.id]) ||
          (!alert.active && !silenceFilter[SilenceTypes.inactive.id]) ||
          (!alert.enabled && !silenceFilter[SilenceTypes.disabled.id])) {
        continue;
      }
      if (!(alert.source == 0 ||
          (_state!.sources
                  .where((e) => e.id == alert.source)
                  .firstOrNull
                  ?.visible ??
              false))) {
        continue;
      }
      filteredAlerts.add(alert);
    }
    _state = _state!.copyWith(filteredAlerts: filteredAlerts);
    if (_state!.sources.isEmpty) {
      _state = _state!.copyWith(
        emptyPaneMessage: "Please configure an account",
      );
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
      _alertsRepo.fetchAlerts(forceRefreshNow: forceRefreshNow);
      await Future.delayed(const Duration(milliseconds: 100));
    }
    while (_state!.status == FetchingStatus.fetching) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    _state = _state!.copyWith(
      refresh: RefreshIconState(
        status: RefreshIconStatus.stopped,
        forceRefreshNow: false,
        alreadyFetching: false,
      ),
    );
    await _refreshState();
  }

  Future<void> _listenForRefreshIcon() async {
    await for (final message
        in _bgChannel.isolateStreams[MessageDestination.refreshIcon]!.stream) {
      if (message.name == MessageName.showRefreshIndicator) {
        await _triggerRefreshIcon(
          forceRefreshNow: message.forceRefreshNow ?? false,
          alreadyFetching: message.alreadyFetching ?? false,
        );
      } else {
        throw Exception(
          "OAV Invalid 'refresh' stream message name: ${message.name}",
        );
      }
    }
  }

  Future<void> _listenForSettings() async {
    await _settings.ready.future;
    await for (String name in _settings.stream!) {
      if (name == "notifications_enabled" ||
          name == "sound_enabled" ||
          name == "alert_filter") {
        await _refreshState();
      }
    }
  }

  Future<void> _listenForAlerts() async {
    List<Alert> alerts = [];
    FetchingStatus status;
    await for (final message
        in _bgChannel.isolateStreams[MessageDestination.alerts]!.stream) {
      alerts = message.alerts ?? alerts;
      if (message.name == MessageName.alertsInit) {
        status = FetchingStatus.init;
      } else if (message.name == MessageName.alertsFetching) {
        status = FetchingStatus.fetching;
      } else if (message.name == MessageName.alertsFetched) {
        status = FetchingStatus.fetched;
      } else if (message.name == MessageName.alertFiltersChanged) {
        status = _state!.status;
      } else {
        throw Exception(
          "OAV Invalid 'alert' stream message name: ${message.name}",
        );
      }
      _state = _state!.copyWith(status: status, alerts: alerts);
      await _refreshState();
    }
  }
}

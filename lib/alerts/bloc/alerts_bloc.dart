/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../app/data_repository/app_repository.dart';
import '../../app/data_repository/settings_repository.dart';
import '../../notifications/data_repository/notification.dart';
import '../model/alerts.dart';
import 'alerts_event.dart';
import 'alerts_state.dart';

class AlertsBloc extends Bloc<AlertEvent, AlertState> {
  AlertsBloc(
      {required AppRepo repo,
      required NotificationRepo notifier,
      required SettingsRepo settings})
      : _alerts = [],
        _repo = repo,
        _notifier = notifier,
        _settings = settings,
        super(AlertsInit()) {
    on<AddAlertSource>(_addSource);
    on<UpdateAlertSource>(_updateSource);
    on<RemoveAlertSource>(_removeSource);
    on<FetchAlerts>(_fetch, transformer: droppable());

    add(FetchAlerts(forceRefreshNow: false));
  }

  List<Alert> _alerts;
  final AppRepo _repo;
  final NotificationRepo _notifier;
  final SettingsRepo _settings;

  Future<void> _addSource(
      AddAlertSource event, Emitter<AlertState> emit) async {
    var result = _repo.addSource(source: event.source);
    if (result >= 0) {
      emit(SourcesChanged(alerts: _alerts, sources: _repo.alertSources));
      add(FetchAlerts(forceRefreshNow: true));
    } else {
      emit(
          SourcesListUpdateError(alerts: _alerts, sources: _repo.alertSources));
    }
  }

  Future<void> _updateSource(
      UpdateAlertSource event, Emitter<AlertState> emit) async {
    var success = _repo.updateSource(id: event.id, values: event.source);
    if (success) {
      emit(SourcesChanged(alerts: _alerts, sources: _repo.alertSources));
      add(FetchAlerts(forceRefreshNow: true));
    } else {
      emit(
          SourcesListUpdateError(alerts: _alerts, sources: _repo.alertSources));
    }
  }

  Future<void> _removeSource(
      RemoveAlertSource event, Emitter<AlertState> emit) async {
    _repo.removeSource(id: event.id);
    emit(SourcesChanged(alerts: _alerts, sources: _repo.alertSources));
    add(FetchAlerts(forceRefreshNow: true));
  }

  Future<void> _fetch(FetchAlerts event, Emitter<AlertState> emit) async {
    StreamController<List<Alert>> controller = StreamController();
    _repo.fetchAlerts(
        controller: controller, forceRefreshNow: event.forceRefreshNow);
    await for (var alerts in controller.stream) {
      _alerts = alerts;
      emit(AlertsFetching(alerts: _alerts, sources: _repo.alertSources));
    }
    emit(AlertsFetched(alerts: _alerts, sources: _repo.alertSources));
    if (_settings.notificationsEnabled) {
      await _notifier.showFilteredNotifications(alerts: _alerts);
    }
  }
}

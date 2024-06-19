/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../app/data_repository/settings_repository.dart';
import '../../notifications/bloc/notification_bloc.dart';
import '../../app/data_repository/app_repository.dart';
import '../model/alerts.dart';
import 'alerts_event.dart';
import 'alerts_state.dart';

class AlertsBloc extends Bloc<AlertEvent, AlertState> {
  AlertsBloc(
      {required AppRepo repo,
      required SettingsRepo settings,
      required NotificationBloc notifier})
      : _alerts = [],
        _repo = repo,
        _settings = settings,
        _notifierBloc = notifier,
        super(const AlertsInit()) {
    on<AddAlertSource>(_addSource);
    on<UpdateAlertSource>(_updateSource);
    on<RemoveAlertSource>(_removeSource);
    on<FetchAlerts>(_fetch, transformer: droppable());

    add(const FetchAlerts(forceRefreshNow: false));
  }

  List<Alert> _alerts;
  final AppRepo _repo;
  final SettingsRepo _settings;
  final NotificationBloc _notifierBloc;

  Future<void> _addSource(
      AddAlertSource event, Emitter<AlertState> emit) async {
    var result = _repo.addSource(source: event.source);
    if (result >= 0) {
      emit(SourcesChanged(alerts: _alerts, sources: _repo.alertSources));
      add(const FetchAlerts(forceRefreshNow: true));
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
      add(const FetchAlerts(forceRefreshNow: true));
    } else {
      emit(
          SourcesListUpdateError(alerts: _alerts, sources: _repo.alertSources));
    }
  }

  Future<void> _removeSource(
      RemoveAlertSource event, Emitter<AlertState> emit) async {
    _repo.removeSource(id: event.id);
    emit(SourcesChanged(alerts: _alerts, sources: _repo.alertSources));
    add(const FetchAlerts(forceRefreshNow: true));
  }

  Future<void> _fetch(FetchAlerts event, Emitter<AlertState> emit) async {
    DateTime prevFetch = _settings.lastFetched;
    StreamController<List<Alert>> controller = StreamController();
    _repo.fetchAlerts(
        controller: controller, forceRefreshNow: event.forceRefreshNow);
    await for (var alerts in controller.stream) {
      _alerts = alerts;
      emit(AlertsFetching(alerts: _alerts, sources: _repo.alertSources));
    }
    emit(AlertsFetched(alerts: _alerts, sources: _repo.alertSources));
    _notifierBloc.add(ShowFilteredNotificationsEvent(
        timeSincePrevFetch: _settings.lastFetched.difference(prevFetch),
        alerts: _alerts));
  }
}

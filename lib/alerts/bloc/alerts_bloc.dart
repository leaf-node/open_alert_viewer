/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../app/data_repository/app_repository.dart';
import '../model/alerts.dart';
import 'alerts_event.dart';
import 'alerts_state.dart';

class AlertsBloc extends Bloc<AlertEvent, AlertState> {
  AlertsBloc(
      {required AppRepo repo,
      required StreamController<AlertsAndStatus> controller})
      : _alerts = [],
        _repo = repo,
        _controller = controller,
        super(AlertsInit()) {
    on<ListenForAlerts>(_listenForAlerts);
    on<AddAlertSource>(_addSource);
    on<UpdateAlertSource>(_updateSource);
    on<RemoveAlertSource>(_removeSource);
    on<FetchAlerts>(_fetch, transformer: droppable());

    add(ListenForAlerts());
  }

  List<Alert> _alerts;
  final AppRepo _repo;
  final StreamController<AlertsAndStatus> _controller;

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
    _repo.fetchAlerts(forceRefreshNow: event.forceRefreshNow);
  }

  Future<void> _listenForAlerts(
      ListenForAlerts event, Emitter<AlertState> emit) async {
    await emit.forEach(_controller.stream, onData: (data) {
      _alerts = data.alerts;
      if (!data.done) {
        return AlertsFetching(alerts: _alerts, sources: _repo.alertSources);
      } else {
        return AlertsFetched(alerts: _alerts, sources: _repo.alertSources);
      }
    });
  }
}

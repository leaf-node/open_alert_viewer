/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../background/background.dart';
import '../model/alerts.dart';
import 'alerts_event.dart';
import 'alerts_state.dart';

class AlertsBloc extends Bloc<AlertEvent, AlertState> {
  AlertsBloc({required BackgroundWorker bgWorker})
      : _bgWorker = bgWorker,
        super(AlertsInit(alerts: [], sources: [])) {
    on<ListenForAlerts>(_listenForAlerts);
    on<AddAlertSource>(_addSource);
    on<UpdateAlertSource>(_updateSource);
    on<RemoveAlertSource>(_removeSource);
    on<FetchAlerts>(_fetch, transformer: droppable());
    add(ListenForAlerts());
  }

  final BackgroundWorker _bgWorker;

  Future<void> _addSource(
      AddAlertSource event, Emitter<AlertState> emit) async {
    _bgWorker.makeRequest(IsolateMessage(
        name: MessageName.addSource, sourceData: event.sourceData));
  }

  Future<void> _updateSource(
      UpdateAlertSource event, Emitter<AlertState> emit) async {
    _bgWorker.makeRequest(IsolateMessage(
        name: MessageName.updateSource, sourceData: event.sourceData));
  }

  Future<void> _removeSource(
      RemoveAlertSource event, Emitter<AlertState> emit) async {
    _bgWorker.makeRequest(
        IsolateMessage(name: MessageName.removeSource, id: event.id));
  }

  Future<void> _fetch(FetchAlerts event, Emitter<AlertState> emit) async {
    _bgWorker.makeRequest(IsolateMessage(
        name: MessageName.fetchAlerts, forceRefreshNow: event.forceRefreshNow));
  }

  Future<void> _listenForAlerts(
      ListenForAlerts event, Emitter<AlertState> emit) async {
    List<Alert> alerts = [];
    List<AlertSource> sources = [];
    await for (final sourceData
        in _bgWorker.isolateStreams[MessageDestination.alerts]!.stream) {
      alerts = sourceData.alerts ?? alerts;
      sources = sourceData.sources ?? sources;
      if (sourceData.name == MessageName.alertsInit) {
        emit(AlertsInit(alerts: alerts, sources: sources));
      } else if (sourceData.name == MessageName.alertsFetching) {
        emit(AlertsFetching(alerts: alerts, sources: sources));
      } else if (sourceData.name == MessageName.alertsFetched) {
        emit(AlertsFetched(alerts: alerts, sources: sources));
      } else if (sourceData.name == MessageName.sourcesChanged) {
        emit(SourcesChanged(alerts: alerts, sources: sources));
      } else {
        throw Exception(
            "OAV Invalid 'alert' stream message name: ${sourceData.name}");
      }
    }
  }
}

/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../../background/background.dart';
import '../../../domain/alerts.dart';
import 'alerts_event.dart';
import 'alerts_state.dart';

class AlertsBloc extends Bloc<AlertEvent, AlertState> {
  AlertsBloc({required BackgroundChannel bgChannel})
      : _bgChannel = bgChannel,
        super(AlertsInit(alerts: [], sources: [])) {
    on<ListenForAlerts>(_listenForAlerts);
    on<AddAlertSource>(_addSource);
    on<UpdateAlertSource>(_updateSource);
    on<RemoveAlertSource>(_removeSource);
    on<FetchAlerts>(_fetch, transformer: droppable());
    on<UpdateLastSeen>(_updateLastSeen);
    add(ListenForAlerts());
  }

  final BackgroundChannel _bgChannel;

  Future<void> _addSource(
      AddAlertSource event, Emitter<AlertState> emit) async {
    _bgChannel.makeRequest(IsolateMessage(
        name: MessageName.addSource, sourceData: event.sourceData));
  }

  Future<void> _updateSource(
      UpdateAlertSource event, Emitter<AlertState> emit) async {
    _bgChannel.makeRequest(IsolateMessage(
        name: MessageName.updateSource, sourceData: event.sourceData));
  }

  Future<void> _removeSource(
      RemoveAlertSource event, Emitter<AlertState> emit) async {
    _bgChannel.makeRequest(
        IsolateMessage(name: MessageName.removeSource, id: event.id));
  }

  Future<void> _fetch(FetchAlerts event, Emitter<AlertState> emit) async {
    _bgChannel.makeRequest(IsolateMessage(
        name: MessageName.fetchAlerts, forceRefreshNow: event.forceRefreshNow));
  }

  Future<void> _updateLastSeen(
      UpdateLastSeen event, Emitter<AlertState> emit) async {
    _bgChannel
        .makeRequest(const IsolateMessage(name: MessageName.updateLastSeen));
  }

  Future<void> _listenForAlerts(
      ListenForAlerts event, Emitter<AlertState> emit) async {
    List<Alert> alerts = [];
    List<AlertSource> sources = [];
    await for (final message
        in _bgChannel.isolateStreams[MessageDestination.alerts]!.stream) {
      alerts = message.alerts ?? alerts;
      sources = message.sources ?? sources;
      if (message.name == MessageName.alertsInit) {
        emit(AlertsInit(alerts: alerts, sources: sources));
      } else if (message.name == MessageName.alertsFetching) {
        emit(AlertsFetching(alerts: alerts, sources: sources));
      } else if (message.name == MessageName.alertsFetched) {
        emit(AlertsFetched(alerts: alerts, sources: sources));
      } else if (message.name == MessageName.sourcesChanged) {
        emit(SourcesChangedEvent(alerts: alerts, sources: sources));
        add(FetchAlerts(forceRefreshNow: true));
      } else if (message.name == MessageName.sourcesFailure) {
        emit(SourcesUpdateError(alerts: alerts, sources: sources));
        add(FetchAlerts(forceRefreshNow: true));
      } else {
        throw Exception(
            "OAV Invalid 'alert' stream message name: ${message.name}");
      }
    }
  }
}

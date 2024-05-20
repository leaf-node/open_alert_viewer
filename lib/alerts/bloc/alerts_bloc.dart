/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';

import '../model/alerts.dart';
import 'alerts_events.dart';
import 'alerts_state.dart';

class AlertsBloc extends Bloc<AlertEvent, AlertState> {
  AlertsBloc() : super(const AlertsInit()) {
    _alertSources = {};
    _alerts = [];
    refreshKey = GlobalKey<RefreshIndicatorState>();
    on<AddAlertSources>(_addSources);
    on<RemoveAlertSource>(_removeSource);
    on<FetchAlerts>(_fetch, transformer: droppable());
  }

  late Set<AlertSource> _alertSources;
  late List<Alert> _alerts;
  late GlobalKey<RefreshIndicatorState> refreshKey;

  Future<void> _addSources(
      AddAlertSources event, Emitter<AlertState> emit) async {
    _alertSources.addAll(event.sources);

    add(const FetchAlerts(maxCacheAge: Duration.zero));
  }

  Future<void> _removeSource(
      RemoveAlertSource event, Emitter<AlertState> emit) async {
    _alertSources.remove(event.source);

    add(const FetchAlerts(maxCacheAge: Duration.zero));
  }

  Future<void> _fetch(FetchAlerts event, Emitter<AlertState> emit) async {
    emit(AlertsFetching(_alerts));
    refreshKey.currentState?.show();

    List<Alert> newAlerts = [];
    List<List<Alert>> fetched = [];
    List<Future<List<Alert>>> incoming = [];

    for (var source in _alertSources) {
      incoming.add(source.fetchAlerts(event.maxCacheAge));
    }

    fetched = await Future.wait(incoming);
    for (var result in fetched) {
      newAlerts.addAll(result);
    }

    _alerts = newAlerts;
    emit(AlertsFetched(_alerts));
  }
}

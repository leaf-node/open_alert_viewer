import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../model/alert.dart';
import '../model/alerts.dart';
import 'alert_events.dart';
import 'alert_state.dart';

class AlertsBloc extends Bloc<AlertEvent, AlertState> {
  AlertsBloc() : super(const AlertsInit()) {
    _alertSources = {};
    _alerts = [];
    refreshKey = GlobalKey<RefreshIndicatorState>();
    on<AddAlertSource>(_addSource);
    on<RemoveAlertSource>(_removeSource);
    on<FetchAlerts>(_fetch);
  }

  late Set<AlertSource> _alertSources;
  late List<Alert> _alerts;
  late GlobalKey<RefreshIndicatorState> refreshKey;

  Future<void> _addSource(
      AddAlertSource event, Emitter<AlertState> emit) async {
    _alertSources.add(event.source);

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

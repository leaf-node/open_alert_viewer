/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../model/alerts.dart';
import '../repository/alerts_repository.dart';
import 'alerts_event.dart';
import 'alerts_state.dart';

class AlertsBloc extends Bloc<AlertEvent, AlertState> {
  AlertsBloc({required AllAlerts alertSourcesRepo})
      : _alerts = [],
        _alertSourcesRepo = alertSourcesRepo,
        super(const AlertsInit()) {
    on<AddAlertSource>(_addSource);
    on<RemoveAlertSource>(_removeSource);
    on<FetchAlerts>(_fetch, transformer: droppable());

    add(const FetchAlerts(maxCacheAge: Duration.zero));
  }

  List<Alert> _alerts;
  final AllAlerts _alertSourcesRepo;

  Future<void> _addSource(
      AddAlertSource event, Emitter<AlertState> emit) async {
    var result = _alertSourcesRepo.addSource(source: event.source);
    if (result >= 0) {
      add(const FetchAlerts(maxCacheAge: Duration.zero));
    } else {
      emit(SourcesListUpdateError(alerts: _alerts));
    }
  }

  Future<void> _removeSource(
      RemoveAlertSource event, Emitter<AlertState> emit) async {
    _alertSourcesRepo.removeSource(id: event.id);
    add(const FetchAlerts(maxCacheAge: Duration.zero));
  }

  Future<void> _fetch(FetchAlerts event, Emitter<AlertState> emit) async {
    emit(AlertsFetching(alerts: _alerts));
    _alerts = await _alertSourcesRepo.fetch(maxCacheAge: Duration.zero);
    emit(AlertsFetched(alerts: _alerts));
  }
}

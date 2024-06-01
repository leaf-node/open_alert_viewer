/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../model/alerts.dart';
import '../../app/repository/app_repository.dart';
import 'alerts_event.dart';
import 'alerts_state.dart';

class AlertsBloc extends Bloc<AlertEvent, AlertState> {
  AlertsBloc({required AllAlerts repo})
      : _alerts = [],
        _repo = repo,
        super(const AlertsInit()) {
    on<AddAlertSource>(_addSource);
    on<RemoveAlertSource>(_removeSource);
    on<FetchAlerts>(_fetch, transformer: droppable());

    add(const FetchAlerts(maxCacheAge: Duration.zero));
  }

  List<Alert> _alerts;
  final AllAlerts _repo;

  Future<void> _addSource(
      AddAlertSource event, Emitter<AlertState> emit) async {
    var result = _repo.addSource(source: event.source);
    if (result >= 0) {
      add(const FetchAlerts(maxCacheAge: Duration.zero));
    } else {
      emit(SourcesListUpdateError(alerts: _alerts));
    }
  }

  Future<void> _removeSource(
      RemoveAlertSource event, Emitter<AlertState> emit) async {
    _repo.removeSource(id: event.id);
    add(const FetchAlerts(maxCacheAge: Duration.zero));
  }

  Future<void> _fetch(FetchAlerts event, Emitter<AlertState> emit) async {
    _alerts = _repo.fetchCachedAlerts();
    emit(AlertsFetching(alerts: _alerts));
    _alerts = await _repo.fetch(maxCacheAge: event.maxCacheAge);
    emit(AlertsFetched(alerts: _alerts));
  }
}

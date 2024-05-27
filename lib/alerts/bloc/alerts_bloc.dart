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
  AlertsBloc({required AllAlerts alertsRepo}) : super(const AlertsInit()) {
    _alerts = [];
    _alertsRepo = alertsRepo;
    on<AddAlertSources>(_addSources);
    on<RemoveAlertSource>(_removeSource);
    on<FetchAlerts>(_fetch, transformer: droppable());
  }

  late List<Alert> _alerts;
  late AllAlerts _alertsRepo;

  Future<void> _addSources(
      AddAlertSources event, Emitter<AlertState> emit) async {
    _alertsRepo.addSources(sources: event.sources);
    add(const FetchAlerts(maxCacheAge: Duration.zero));
  }

  Future<void> _removeSource(
      RemoveAlertSource event, Emitter<AlertState> emit) async {
    _alertsRepo.removeSource(source: event.source);
    add(const FetchAlerts(maxCacheAge: Duration.zero));
  }

  Future<void> _fetch(FetchAlerts event, Emitter<AlertState> emit) async {
    emit(AlertsFetching(alerts: _alerts));
    _alerts = await _alertsRepo.fetch(maxCacheAge: Duration.zero);
    emit(AlertsFetched(alerts: _alerts));
  }
}

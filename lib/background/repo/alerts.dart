/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';
import 'dart:developer';

import '../../../alerts/model/alerts.dart';
import '../../app/data_source/database.dart';
import '../../app/data_repository/settings_repository.dart';
import '../background.dart';
import 'notifications.dart';
import 'sources.dart';

class AlertsRepo {
  AlertsRepo(
      {required LocalDatabase db,
      required SettingsRepo settings,
      required SourcesRepo sourcesRepo,
      required NotificationRepo notifier})
      : _db = db,
        _sourcesRepo = sourcesRepo,
        _settings = settings,
        _notifier = notifier,
        _alertSources = [],
        _alerts = [];

  final LocalDatabase _db;
  final SettingsRepo _settings;
  final SourcesRepo _sourcesRepo;
  final NotificationRepo _notifier;
  late StreamController<IsolateMessage> _alertStream;
  List<AlertSource> _alertSources;
  List<Alert> _alerts;
  Timer? _timer;
  bool _fetching = false;

  void init(StreamController<IsolateMessage> alertStream) async {
    _alertStream = alertStream;
    startTimer();
  }

  Future<void> fetchAlerts({required bool forceRefreshNow}) async {
    if (_fetching) {
      return;
    }
    _fetching = true;
    int interval = _settings.refreshInterval;
    _fetchCachedAlerts();
    _alertSources = _sourcesRepo.alertSources;
    _alertStream.add(IsolateMessage(
        name: MessageName.alertsFetching,
        alerts: _alerts,
        sources: _alertSources));
    if (!forceRefreshNow) {
      if (interval == -1) {
        _alertStream.add(
            IsolateMessage(name: MessageName.alertsFetched, alerts: _alerts));
        _fetching = false;
        return;
      }
      var maxCacheAge = Duration(minutes: interval);
      var lastFetched = _settings.lastFetched;
      if (maxCacheAge.compareTo(DateTime.now().difference(lastFetched)) >= 0) {
        _alertStream.add(
            IsolateMessage(name: MessageName.alertsFetched, alerts: _alerts));
        _fetching = false;
        return;
      }
    }
    List<Future<List<Alert>>> incoming = [];
    List<Alert> freshAlerts = [];
    var lastFetched = DateTime.now();
    var oldSyncFailures = _alerts
        .where((oldAlert) => oldAlert.kind == AlertType.syncFailure)
        .toList();
    for (var source in _alertSources) {
      var sourceFuture = source.fetchAlerts();
      sourceFuture = sourceFuture.onError((TypeError error, StackTrace trace) {
        log(error.toString());
        log(trace.toString());
        return Future.value([
          Alert(
              source: source.id,
              kind: AlertType.syncFailure,
              hostname: source.name,
              service: "OAV",
              message: "Error fetching alerts. "
                  "Please open an issue using \"Online Support\" in the settings menu.",
              url: "https://github.com/okaycode-dev/open_alert_viewer/issues",
              age: Duration.zero)
        ]);
      });
      incoming.add(sourceFuture);
      incoming.last.then((List<Alert> newAlerts) {
        var updatedAlerts = _updateSyncFailureAges(newAlerts, oldSyncFailures);
        _alerts = _alerts.where((alert) => alert.source != source.id).toList();
        _alerts.addAll(updatedAlerts);
        _alerts.sort(_alertSort);
        _alertStream.add(
            IsolateMessage(name: MessageName.alertsFetching, alerts: _alerts));
        freshAlerts.addAll(updatedAlerts);
      });
    }
    await Future.wait(incoming);
    _alerts = freshAlerts;
    _alerts.sort(_alertSort);
    _alertStream
        .add(IsolateMessage(name: MessageName.alertsFetching, alerts: _alerts));
    _cacheAlerts();
    _settings.priorFetch = _settings.lastFetched;
    _settings.lastFetched = lastFetched;
    _alertStream
        .add(IsolateMessage(name: MessageName.alertsFetched, alerts: _alerts));
    _notifier.showFilteredNotifications(
        alerts: _alerts, alertStream: _alertStream);
    _fetching = false;
  }

  List<Alert> _updateSyncFailureAges(
      List<Alert> alerts, List<Alert> oldSyncFailures) {
    return alerts.map((alert) {
      if (alert.kind == AlertType.syncFailure) {
        var oldAlerts = oldSyncFailures
            .where((oldAlert) => oldAlert.source == alert.source)
            .toList();
        if (oldAlerts.isEmpty) {
          return alert;
        }
        var newAge =
            oldAlerts[0].age + DateTime.now().difference(_settings.lastFetched);
        return Alert(
            source: alert.source,
            kind: alert.kind,
            hostname: alert.hostname,
            service: alert.service,
            message: alert.message,
            url: alert.url,
            age: newAge);
      }
      return alert;
    }).toList();
  }

  int _alertSort(Alert a, Alert b) {
    if ((a.kind == b.kind) ||
        (a.kind != AlertType.syncFailure && b.kind != AlertType.syncFailure)) {
      return a.age.compareTo(b.age);
    } else if (a.kind == AlertType.syncFailure) {
      return -1;
    } else {
      return 1;
    }
  }

  void _cacheAlerts() {
    List<List<Object>> serialized = [];
    for (var alert in _alerts) {
      serialized.add([
        alert.source,
        alert.kind.index,
        alert.hostname,
        alert.service,
        alert.message,
        alert.url,
        alert.age.inSeconds
      ]);
    }
    _db.removeCachedAlerts();
    _db.insertIntoAlertsCache(alerts: serialized);
  }

  List<Alert> _fetchCachedAlerts() {
    List<Alert> alerts = [];
    List<Map<String, dynamic>> serializedList = _db.fetchCachedAlerts();
    for (var serialized in serializedList) {
      alerts.add(Alert(
        source: serialized["source"] as int,
        kind: AlertType.values[serialized["kind"] as int],
        message: serialized["message"] as String,
        url: serialized["url"] as String,
        hostname: serialized["hostname"] as String,
        service: serialized["service"] as String,
        age: Duration(seconds: serialized["age"] as int),
      ));
    }
    _alerts = alerts;
    return alerts;
  }

  void startTimer() {
    if (_timer != null) {
      return;
    }
    fetchAlerts(forceRefreshNow: false);
    var nextFetchIn = _settings.lastFetched
        .add(Duration(minutes: _settings.refreshInterval))
        .difference(DateTime.now());
    Future.delayed(nextFetchIn, () {
      refreshTimer();
    });
  }

  void refreshTimer() {
    _timer?.cancel();
    _timer =
        Timer.periodic(Duration(minutes: _settings.refreshInterval), (timer) {
      fetchAlerts(forceRefreshNow: true);
    });
    fetchAlerts(forceRefreshNow: true);
  }
}

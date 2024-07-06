/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';
import 'dart:developer';

import 'package:open_alert_viewer/notifications/data_repository/notification.dart';

import '../../alerts/data_source/alerts_random.dart';
import '../../alerts/model/alerts.dart';
import '../data_source/database.dart';
import 'settings_repository.dart';

class AlertsAndStatus {
  const AlertsAndStatus({required this.alerts, required this.done});

  final List<Alert> alerts;
  final bool done;
}

class AppRepo {
  AppRepo(
      {required LocalDatabase db,
      required SettingsRepo settings,
      required NotificationRepo notifier,
      required StreamController<AlertsAndStatus> controller})
      : _db = db,
        _settings = settings,
        _notifier = notifier,
        _controller = controller,
        _alertSources = [],
        _alerts = [];

  final LocalDatabase _db;
  final SettingsRepo _settings;
  final NotificationRepo _notifier;
  final StreamController<AlertsAndStatus> _controller;
  List<AlertSource> _alertSources;
  List<Alert> _alerts;
  Timer? _timer;

  List<AlertSource> get alertSources {
    _refreshSources();
    return _alertSources;
  }

  Future<void> open() async {
    await _db.open();
  }

  Future<void> migrate() async {
    await _db.migrate();
  }

  void close() {
    _db.close();
  }

  void _refreshSources() {
    List<AlertSource> sources = [];
    List<Map<String, dynamic>> sourcesData = _db.listSources();
    Function alertSource;
    for (var source in sourcesData) {
      List<dynamic> values = source.values.toList();
      var id = values[0] as int;
      var name = values[1] as String;
      int type;
      try {
        type = values[2] as int;
      } catch (e) {
        log("Unsupported source id: '${values[2]}'. Removing source.");
        removeSource(id: id);
        continue;
      }
      var url = values[3] as String;
      var username = values[4] as String;
      var password = values[5] as String;

      switch (type) {
        case 0:
          alertSource = RandomAlerts.new;
        default:
          throw "Unsupported source id: $type";
      }
      sources.add(alertSource(
          id: id,
          type: type,
          name: name,
          url: url,
          username: username,
          password: password));
    }
    _alertSources = sources;
  }

  int addSource({required List<String> source}) {
    return _db.addSource(source: source);
  }

  bool updateSource({required int id, required List<Object> values}) {
    return _db.updateSource(id: id, values: values);
  }

  void removeSource({required int id}) {
    _db.removeSource(id: id);
  }

  bool checkUniqueSource({int? id, required String name}) {
    return _db.checkUniqueSource(id: id, name: name);
  }

  Future<void> fetchAlerts({required bool forceRefreshNow}) async {
    int interval = _settings.refreshInterval;
    _fetchCachedAlerts();
    _controller.add(AlertsAndStatus(alerts: _alerts, done: false));
    if (!forceRefreshNow) {
      if (interval == -1) {
        _controller.add(AlertsAndStatus(alerts: _alerts, done: true));
        return;
      }
      var maxCacheAge = Duration(minutes: interval);
      var lastFetched = _settings.lastFetched;
      if (maxCacheAge.compareTo(DateTime.now().difference(lastFetched)) >= 0) {
        _controller.add(AlertsAndStatus(alerts: _alerts, done: true));
        return;
      }
    }
    _refreshSources();
    List<Future<List<Alert>>> incoming = [];
    List<Alert> freshAlerts = [];
    var lastFetched = DateTime.now();
    var timeout = _settings.syncTimeout;
    var oldSyncFailures = _alerts
        .where((oldAlert) => oldAlert.kind == AlertType.syncFailure)
        .toList();
    for (var source in _alertSources) {
      var sourceFuture = source.fetchAlerts();
      if (timeout > 0) {
        sourceFuture =
            sourceFuture.timeout(Duration(seconds: timeout), onTimeout: () {
          String host = Uri.parse(source.url).host;
          host = (host.isEmpty) ? source.name : host;
          return Future.value([
            Alert(
                source: source.id,
                kind: AlertType.syncFailure,
                hostname: host,
                service: source.name,
                message: "Connection Timed Out",
                age: Duration.zero)
          ]);
        });
      }
      incoming.add(sourceFuture);
      incoming.last.then((List<Alert> newAlerts) {
        var updatedAlerts = _updateSyncFailureAges(newAlerts, oldSyncFailures);
        _alerts = _alerts.where((alert) => alert.source != source.id).toList();
        _alerts.addAll(updatedAlerts);
        _alerts.sort(_alertSort);
        _controller.add(AlertsAndStatus(alerts: _alerts, done: false));
        freshAlerts.addAll(updatedAlerts);
      });
    }
    await Future.wait(incoming);
    _alerts = freshAlerts;
    _alerts.sort(_alertSort);
    _controller.add(AlertsAndStatus(alerts: _alerts, done: false));
    _cacheAlerts();
    _settings.priorFetch = _settings.lastFetched;
    _settings.lastFetched = lastFetched;
    _controller.add(AlertsAndStatus(alerts: _alerts, done: true));
    _notifier.showFilteredNotifications(alerts: _alerts);
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
        hostname: serialized["hostname"] as String,
        service: serialized["service"] as String,
        age: Duration(seconds: serialized["age"] as int),
      ));
    }
    _alerts = alerts;
    return alerts;
  }

  Future<void> startTimer() async {
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

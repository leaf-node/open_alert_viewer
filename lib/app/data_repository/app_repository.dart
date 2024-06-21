/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';
import 'dart:developer';

import '../../alerts/data_source/alerts_random.dart';
import '../../alerts/model/alerts.dart';
import '../data_source/database.dart';
import 'settings_repository.dart';

class AppRepo {
  AppRepo({required LocalDatabase db, required SettingsRepo settings})
      : _db = db,
        _settings = settings,
        _alertSources = [],
        _alerts = [];

  final LocalDatabase _db;
  final SettingsRepo _settings;
  List<AlertSource> _alertSources;
  List<Alert> _alerts;

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

  void fetchAlerts(
      {required StreamController<List<Alert>> controller,
      required bool forceRefreshNow}) async {
    int interval = _settings.refreshInterval;
    fetchCachedAlerts();
    controller.add(_alerts);
    if (!forceRefreshNow) {
      if (interval == -1) {
        controller.close();
        return;
      }
      var maxCacheAge = Duration(minutes: interval);
      var lastFetched = _settings.lastFetched;
      if (maxCacheAge.compareTo(DateTime.now().difference(lastFetched)) >= 0) {
        controller.close();
        return;
      }
    }
    _refreshSources();
    List<Future<List<Alert>>> incoming = [];
    List<Alert> freshAlerts = [];
    var lastFetched = DateTime.now();
    var timeout = _settings.syncTimeout;
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
      incoming.last.then((List<Alert> alerts) {
        freshAlerts.addAll(alerts);
        _alerts = _alerts.where((alert) => alert.source != source.id).toList();
        _alerts.addAll(alerts);
        _alerts.sort((a, b) => a.age.compareTo(b.age));
        controller.add(_alerts);
      });
    }
    await Future.wait(incoming);
    _alerts = freshAlerts;
    _alerts.sort((a, b) => a.age.compareTo(b.age));
    controller.add(_alerts);
    _cacheAlerts();
    _settings.lastFetched = lastFetched;
    controller.close();
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

  List<Alert> fetchCachedAlerts() {
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
}

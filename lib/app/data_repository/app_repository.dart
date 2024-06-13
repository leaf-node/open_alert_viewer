/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import '../data_source/database.dart';
import '../../alerts/data_source/alerts_random.dart';
import '../../alerts/model/alerts.dart';
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
      var type = values[2] as int;
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

  Future<List<Alert>> fetchAlerts({required bool forceRefreshNow}) async {
    int interval = _settings.refreshInterval;
    if (!forceRefreshNow) {
      if (interval == -1) {
        return _alerts;
      }
      var maxCacheAge = Duration(minutes: interval);
      var lastFetched = _settings.lastFetched;
      if (maxCacheAge.compareTo(DateTime.now().difference(lastFetched)) > 0) {
        return _alerts;
      }
    }
    _refreshSources();

    List<Alert> newAlerts = [];
    List<List<Alert>> fetched = [];
    List<Future<List<Alert>>> incoming = [];

    for (var source in _alertSources) {
      incoming.add(source.fetchAlerts());
    }
    fetched = await Future.wait(incoming);
    var lastFetched = DateTime.now();
    for (var result in fetched) {
      newAlerts.addAll(result);
    }
    newAlerts.sort((a, b) => a.age.compareTo(b.age));
    _alerts = newAlerts;

    _cacheAlerts();
    _settings.lastFetched = lastFetched;
    return _alerts;
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

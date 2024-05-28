/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import '../../app/data_provider/sources.dart';
import '../data_provider/alerts_random.dart';
import '../model/alerts.dart';

class AllAlerts {
  AllAlerts({required SourcesDBwrapper sourcesDBwrapper})
      : _sourcesDBwrapper = sourcesDBwrapper,
        _alertSources = [],
        _alerts = [],
        _lastFetch = DateTime.utc(1970);

  final SourcesDBwrapper _sourcesDBwrapper;
  List<AlertSource> _alertSources;
  List<Alert> _alerts;
  DateTime _lastFetch;

  List<AlertSource> get alertSources => _alertSources;

  void _refreshSources() {
    List<AlertSource> sources = [];
    List<Map<String, dynamic>> sourcesData = _sourcesDBwrapper.listSources();
    for (var source in sourcesData) {
      List<dynamic> values = source.values.toList();
      var id = values[0] as int;
      var name = values[1] as String;
      var type = values[2] as int;
      //var url = values[3] as String;
      //var username = values[4] as String;
      //var password = values[5] as String;

      switch (type) {
        case 0:
          sources.add(RandomAlerts(id: id, name: name));
        default:
          throw "Unsupported source id: $type";
      }
    }
    _alertSources = sources;
  }

  int addSource({required List<String> source}) {
    return _sourcesDBwrapper.addSource(source: source);
  }

  void removeSource({required int id}) {
    _sourcesDBwrapper.removeSource(id: id);
  }

  Future<List<Alert>> fetch({required Duration maxCacheAge}) async {
    if (maxCacheAge.compareTo(DateTime.now().difference(_lastFetch)) > 0) {
      return _alerts;
    }

    _refreshSources();

    List<Alert> newAlerts = [];
    List<List<Alert>> fetched = [];
    List<Future<List<Alert>>> incoming = [];

    for (var source in _alertSources) {
      incoming.add(source.fetchAlerts());
    }

    fetched = await Future.wait(incoming);
    for (var result in fetched) {
      newAlerts.addAll(result);
    }

    newAlerts.sort((a, b) => a.age.compareTo(b.age));
    _alerts = newAlerts;

    _lastFetch = DateTime.now();
    return _alerts;
  }
}

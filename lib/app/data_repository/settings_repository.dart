/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import '../data_source/database.dart';

class SettingsRepo {
  SettingsRepo({required LocalDatabase db}) : _db = db;

  final LocalDatabase _db;

  get lastFetched => _getLastFetched();
  set lastFetched(value) => _setLastFetched(value);
  get refreshInterval => _getRefreshInterval();
  set refreshInterval(value) => _setRefreshInterval(value);

  DateTime _getLastFetched() {
    String storedValue = _db.getSetting(setting: "last_fetch_time");
    var value = DateTime.fromMillisecondsSinceEpoch(
        switch (storedValue) { "" => 0, _ => int.parse(storedValue) });
    if (value.compareTo(DateTime.now()) > 0) {
      value = DateTime.fromMillisecondsSinceEpoch(0);
    }
    return value;
  }

  void _setLastFetched(DateTime lastFetch) {
    _db.setSetting(
        setting: "last_fetch_time",
        value: lastFetch.millisecondsSinceEpoch.toString());
  }

  int _getRefreshInterval() {
    String storedValue = _db.getSetting(setting: "refresh_interval");
    var value = switch (storedValue) { "" => 5, _ => int.parse(storedValue) };
    if (value == 0 || value < -1) {
      value = 1;
    }
    return value;
  }

  void _setRefreshInterval(int? newValue) {
    _db.setSetting(setting: "refresh_interval", value: newValue.toString());
  }
}

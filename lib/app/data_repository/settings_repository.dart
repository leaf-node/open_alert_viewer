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
  get refreshFrequency => _getRefreshFrequency();
  set refreshFrequency(value) => _setRefreshFrequency(value);

  DateTime _getLastFetched() {
    String lastFetchStr = _db.getSetting(setting: "last_fetch_time");
    var value = DateTime.fromMillisecondsSinceEpoch(
        switch (lastFetchStr) { "" => 0, _ => int.parse(lastFetchStr) });
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

  int _getRefreshFrequency() {
    String refreshFrequency = _db.getSetting(setting: "refresh_frequency");
    var value =
        switch (refreshFrequency) { "" => 5, _ => int.parse(refreshFrequency) };
    if (value <= 0) {
      value = 1;
    }
    return value;
  }

  void _setRefreshFrequency(int refreshFrequency) {
    _db.setSetting(
        setting: "refresh_frequency", value: refreshFrequency.toString());
  }
}

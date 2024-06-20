/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import '../data_source/database.dart';

class SettingsRepo {
  SettingsRepo({required LocalDatabase db}) : _db = db;

  final LocalDatabase _db;

  DateTime get lastFetched => _getLastFetched();
  set lastFetched(value) => _setLastFetched(value);
  int get refreshInterval => _getSetting<int>("refresh_interval", 5);
  set refreshInterval(value) => _setSetting<int>("refresh_interval", value);
  int get syncTimeout => _getSetting<int>("sync_timeout", 10);
  set syncTimeout(value) => _setSetting<int>("sync_timeout", value);

  T _getSetting<T>(String name, T defaultValue) {
    String storedValue = _db.getSetting(setting: name);
    T value;
    try {
      if (T == int) {
        value = int.parse(storedValue) as T;
      } else if (T == bool) {
        value = bool.parse(storedValue) as T;
      } else {
        value = defaultValue;
      }
    } catch (e) {
      value = defaultValue;
    }
    if (value == 0 || (T is int && value as int < -1)) {
      value = defaultValue;
    }
    return value;
  }

  void _setSetting<T>(String name, T newValue) {
    _db.setSetting(setting: name, value: newValue.toString());
  }

  DateTime _getLastFetched() {
    var value = DateTime.fromMillisecondsSinceEpoch(
        _getSetting<int>("last_fetch_time", 0));
    if (value.compareTo(DateTime.now()) > 0) {
      value = DateTime.fromMillisecondsSinceEpoch(0);
    }
    return value;
  }

  void _setLastFetched(DateTime lastFetch) {
    _setSetting<int>("last_fetch_time", lastFetch.millisecondsSinceEpoch);
  }
}

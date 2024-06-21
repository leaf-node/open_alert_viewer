/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import '../data_source/database.dart';

class SettingsRepo {
  SettingsRepo({required LocalDatabase db}) : _db = db;

  final LocalDatabase _db;

  DateTime get lastFetched => _getSetting<DateTime>(
      "last_fetch_time", DateTime.fromMillisecondsSinceEpoch(0));
  set lastFetched(value) => _setSetting<DateTime>("last_fetch_time", value);
  int get refreshInterval => _getSetting<int>("refresh_interval", 5);
  set refreshInterval(value) => _setSetting<int>("refresh_interval", value);
  int get syncTimeout => _getSetting<int>("sync_timeout", 10);
  set syncTimeout(value) => _setSetting<int>("sync_timeout", value);
  bool get notificationsRequested =>
      _getSetting<bool>("notifications_requested", false);
  set notificationsRequested(value) =>
      _setSetting<bool>("notifications_requested", value);
  bool get notificationsEnabled =>
      _getSetting<bool>("notifications_enabled", false);
  set notificationsEnabled(value) =>
      _setSetting<bool>("notifications_enabled", value);

  T _getSetting<T>(String name, T defaultValue) {
    String storedValue = _db.getSetting(setting: name);
    T value;
    try {
      if (T == int) {
        value = int.parse(storedValue) as T;
      } else if (T == bool) {
        value = bool.parse(storedValue) as T;
      } else if (T == String) {
        value = storedValue as T;
      } else if (T == DateTime) {
        value =
            DateTime.fromMillisecondsSinceEpoch(int.parse(storedValue)) as T;
      } else {
        value = defaultValue;
      }
    } catch (e) {
      value = defaultValue;
    }
    if (T == DateTime && (value as DateTime).compareTo(DateTime.now()) > 0) {
      value = defaultValue;
    }
    if (T == int && (value == 0 || value as int < -1)) {
      value = defaultValue;
    }
    return value;
  }

  void _setSetting<T>(String name, T newValue) {
    if (T == DateTime) {
      _setSetting<int>(name, (newValue as DateTime).millisecondsSinceEpoch);
      return;
    }
    _db.setSetting(setting: name, value: newValue.toString());
  }
}

/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:convert';

import '../../alerts/model/alerts.dart';
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
  DateTime get userLastLooked => _getSetting<DateTime>(
      "user_last_looked", DateTime.fromMillisecondsSinceEpoch(0));
  set userLastLooked(value) => _setSetting<DateTime>("user_last_looked", value);
  DateTime get priorFetch => _getSetting<DateTime>(
      "prior_fetch_time", DateTime.fromMillisecondsSinceEpoch(0));
  set priorFetch(value) => _setSetting<DateTime>("prior_fetch_time", value);
  List<bool> get alertFilter => _getSetting<List<bool>>("alert_filter", [true],
      opt: AlertType.values.length);
  set alertFilter(value) => _setSetting<List<bool>>("alert_filter", value);
  void setAlertFilterAt(bool value, int index) =>
      _setListAt<bool>("alert_filter", value, [true], index);
  int get darkMode => _getSetting<int>("dark_mode", -1);
  set darkMode(value) => _setSetting<int>("dark_mode", value);

  T _getSetting<T>(String name, T defaultValue, {int? opt}) {
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
      } else if (T == List<bool>) {
        value = List<bool>.from(jsonDecode(storedValue)) as T;
      } else {
        value = defaultValue;
      }
    } catch (e) {
      if (name == "alert_filter") {
        value = [false, true, true, false, true, false, true, true, false, true]
            as T;
      } else {
        value = defaultValue;
      }
    }
    if (T == DateTime && (value as DateTime).compareTo(DateTime.now()) > 0) {
      value = defaultValue;
    } else if ((name == "refresh_interval" || name == "sync_timeout") &&
        (value == 0 || value as int < -1)) {
      value = defaultValue;
    } else if (T == List<bool>) {
      int oldLength = (value as List).length;
      if (opt != null && opt > oldLength) {
        for (var i = oldLength; i < opt; i++) {
          (value as List).add((defaultValue as List)[0]);
        }
      }
    }
    return value;
  }

  void _setSetting<T>(String name, T newValue) {
    if (T == DateTime) {
      _setSetting<int>(name, (newValue as DateTime).millisecondsSinceEpoch);
      return;
    } else if (T == List<bool>) {
      _setSetting<String>(name, jsonEncode(newValue as List));
      return;
    }
    _db.setSetting(setting: name, value: newValue.toString());
  }

  void _setListAt<T>(String name, T newValue, List<T> defaultValue, int index) {
    List<T> currentSetting =
        _getSetting<List<T>>(name, defaultValue, opt: index + 1);
    currentSetting[index] = newValue;
    _setSetting<List<T>>(name, currentSetting);
  }
}

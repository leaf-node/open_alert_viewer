/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

class Util {
  static Map<String, T> mapConvert<T>(Map<String, dynamic> data) {
    return {for (var MapEntry(:key, :value) in data.entries) key: value as T};
  }

  static String prettyPrintDuration(Duration duration) {
    String ageStr;

    int seconds = duration.inSeconds.floor() % 60;
    int minutes = duration.inMinutes.floor() % 60;
    int hours = duration.inHours.floor() % 24;
    int days = duration.inDays.floor();

    ageStr = (days > 0) ? "${days}d " : "";
    ageStr += (days > 0 || hours > 0) ? "${hours}h " : "";
    ageStr += (days > 0 || hours > 0 || minutes > 0) ? "${minutes}m " : "";
    ageStr += "${seconds}s";

    return ageStr;
  }
}

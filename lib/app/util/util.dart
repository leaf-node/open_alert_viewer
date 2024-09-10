/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

class Util {
  static Map<String, T> mapConvert<T>(Map<String, dynamic> data) {
    return {for (var MapEntry(:key, :value) in data.entries) key: value as T};
  }

  static String prettyPrintDuration(
      {required Duration duration, bool? longForm, bool? stripLeadingOne}) {
    String durationStr;
    List<String> durationArray = [];
    int seconds = duration.inSeconds.floor() % 60;
    int minutes = duration.inMinutes.floor() % 60;
    int hours = duration.inHours.floor() % 24;
    int days = duration.inDays.floor();
    if (longForm ?? false) {
      if (days == 1) {
        durationArray.add("1 day");
      } else if (days > 0) {
        durationArray.add("$days days");
      }
      if (hours == 1) {
        durationArray.add("1 hour");
      } else if (hours > 0) {
        durationArray.add("$hours hours");
      }
      if (minutes == 1) {
        durationArray.add("1 minute");
      } else if (minutes > 0) {
        durationArray.add("$minutes minutes");
      }
      if (seconds == 1) {
        durationArray.add("1 second");
      } else if (seconds > 0) {
        durationArray.add("$seconds seconds");
      }
      if (durationArray.isEmpty) {
        durationArray.add("0 seconds");
      } else if ((stripLeadingOne ?? false) && durationArray.length == 1) {
        if (durationArray[0].substring(durationArray[0].length - 1) != "s") {
          durationArray[0] = durationArray[0].substring(2);
        }
      }
      durationStr = durationArray.join(", ");
    } else {
      durationStr = (days > 0) ? "${days}d " : "";
      durationStr += (days > 0 || hours > 0) ? "${hours}h " : "";
      durationStr +=
          (days > 0 || hours > 0 || minutes > 0) ? "${minutes}m " : "";
      durationStr += "${seconds}s";
    }
    return durationStr;
  }
}

/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:math';

import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class Util {
  static final random = Random(DateTime.now().microsecondsSinceEpoch);

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

  static bool toBool(Object value) {
    if (value.runtimeType == String) {
      return switch (value) { "0" => false, "1" || _ => true };
    } else if (value.runtimeType == int) {
      return switch (value) { 0 => false, 1 || _ => true };
    } else {
      throw Exception(
          "Invalid format to convert to bool: ${value.runtimeType}");
    }
  }

  static Future<String> getVersion() async {
    try {
      String gitVersion;
      final pubspecVersion =
          loadYaml(await rootBundle.loadString("pubspec.yaml"))["version"];
      var head = await rootBundle.loadString('.git/HEAD');
      if (head.startsWith('ref: refs/heads/')) {
        final branchName = head.split('ref: refs/heads/').last.trim();
        gitVersion = await rootBundle.loadString('.git/refs/heads/$branchName');
      } else {
        gitVersion = head;
      }
      return "$pubspecVersion-${gitVersion.substring(0, 8)}";
    } catch (e) {
      return "version-unknown";
    }
  }

  static int genRandom() {
    return random.nextInt(1 << 32);
  }
}

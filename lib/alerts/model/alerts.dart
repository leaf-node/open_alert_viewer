/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:http/http.dart' as http;

enum AlertType {
  okay(name: "Okay"),
  warning(name: "Warning"),
  error(name: "Error"),
  pending(name: "Pending"),
  unknown(name: "Unknown"),
  up(name: "Up"),
  unreachable(name: "Unreachable"),
  down(name: "Down"),
  hostPending(name: "Host Pending"),
  syncFailure(name: "Sync Failure");

  const AlertType({required this.name});

  final String name;
}

class Alert {
  const Alert(
      {required this.source,
      required this.kind,
      required this.hostname,
      required this.service,
      required this.message,
      required this.age});

  final int source;
  final AlertType kind;
  final String hostname;
  final String service;
  final String message;
  final Duration age;
}

abstract class AlertSource {
  const AlertSource(
      {required this.id,
      required this.name,
      required this.type,
      required this.baseURL,
      required this.path,
      required this.username,
      required this.password});

  Future<List<Alert>> fetchAlerts();

  static Future<(int, String)> fetchData(String baseURL, String path) async {
    Function uriBuilder;

    if (RegExp(r"^https?://").hasMatch(baseURL)) {
      uriBuilder = _simpleParse;
    } else if (RegExp(r"^localhost(:[^@:]*|/)").hasMatch(baseURL)) {
      uriBuilder = Uri.http;
    } else {
      uriBuilder = Uri.https;
    }
    var response = await http.get(uriBuilder(baseURL, path));
    return (response.statusCode, response.body);
  }

  static Uri _simpleParse(String base, String path) {
    return Uri.parse(base + path);
  }

  final int id;
  final String name;
  final int type;
  final String baseURL;
  final String path;
  final String username;
  final String password;
}

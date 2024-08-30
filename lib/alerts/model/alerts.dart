/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../background/background.dart';

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

  final int id;
  final String name;
  final int type;
  final String baseURL;
  final String path;
  final String username;
  final String password;
}

mixin NetworkFetch {
  Future<http.Response> networkFetch(
      String baseURL, String path, String username, String password) async {
    Function uriBuilder;
    Map<String, String> headers;
    headers = {
      "User-Agent": "open_alert_viewer/${BackgroundWorker.appVersion}"
    };
    if (RegExp(r"^https?://").hasMatch(baseURL)) {
      uriBuilder = _simpleParse;
    } else if (RegExp(r"^localhost(:[0-9]*)?(/.*)?$").hasMatch(baseURL)) {
      uriBuilder = Uri.http;
    } else {
      uriBuilder = Uri.https;
    }
    if (username != "" || password != "") {
      var basicAuth =
          "Basic ${base64.encode(utf8.encode("$username:$password"))}";
      headers["authorization"] = basicAuth;
    }
    var response = await http
        .get(uriBuilder(baseURL, path), headers: headers)
        .timeout(Duration(seconds: BackgroundWorker.settings.syncTimeout),
            onTimeout: () {
      return http.Response("408 Client Timeout", 408);
    });
    return response;
  }

  Uri _simpleParse(String base, String path) {
    return Uri.parse(base + path);
  }
}

/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../background/background.dart';
import '../data_repository/settings_repository.dart';

mixin NetworkFetch {
  Future<http.Response> networkFetch(String baseURL, String path,
      String username, String password, String parameters) async {
    Map<String, String> headers;
    headers = {"User-Agent": "open_alert_viewer/${SettingsRepo.appVersion}"};
    if (username != "" || password != "") {
      var basicAuth =
          "Basic ${base64.encode(utf8.encode("$username:$password"))}";
      headers["authorization"] = basicAuth;
    }
    var response = await http
        .get(Uri.parse(generateURL(baseURL, path, parameters)),
            headers: headers)
        .timeout(Duration(seconds: BackgroundWorker.settings.syncTimeout),
            onTimeout: () {
      return http.Response("408 Client Timeout", 408,
          reasonPhrase: "Client Timeout");
    });
    return response;
  }

  String generateURL(String baseURL, String path, String parameters) {
    String prefix;
    if (RegExp(r"^https?://").hasMatch(baseURL)) {
      prefix = "";
    } else if (RegExp(r"^localhost(:[0-9]*)?(/.*)?$").hasMatch(baseURL)) {
      prefix = "http://";
    } else {
      prefix = "https://";
    }
    return prefix + baseURL + path + parameters;
  }
}

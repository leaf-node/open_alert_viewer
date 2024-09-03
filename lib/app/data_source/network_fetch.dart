/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../background/background.dart';

mixin NetworkFetch {
  Future<http.Response> networkFetch(
      String baseURL, String path, String username, String password) async {
    String prefix;
    Map<String, String> headers;
    headers = {
      "User-Agent": "open_alert_viewer/${BackgroundWorker.appVersion}"
    };
    if (RegExp(r"^https?://").hasMatch(baseURL)) {
      prefix = "";
    } else if (RegExp(r"^localhost(:[0-9]*)?(/.*)?$").hasMatch(baseURL)) {
      prefix = "http://";
    } else {
      prefix = "https://";
    }
    if (username != "" || password != "") {
      var basicAuth =
          "Basic ${base64.encode(utf8.encode("$username:$password"))}";
      headers["authorization"] = basicAuth;
    }
    var response = await http
        .get(Uri.parse(prefix + baseURL + path), headers: headers)
        .timeout(Duration(seconds: BackgroundWorker.settings.syncTimeout),
            onTimeout: () {
      return http.Response("408 Client Timeout", 408);
    });
    return response;
  }
}

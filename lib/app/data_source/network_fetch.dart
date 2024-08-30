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

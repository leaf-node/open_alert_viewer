/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../background/background.dart';
import '../data_repository/settings_repository.dart';

mixin NetworkFetch {
  Future<http.Response> networkFetch(
      String baseURL, String username, String password, String restOfURL,
      [String? postBody, String? authOverride]) async {
    Map<String, String> headers;
    headers = {"User-Agent": "open_alert_viewer/${SettingsRepo.appVersion}"};
    if ((username != "" || password != "") && authOverride == null) {
      var basicAuth =
          "Basic ${base64.encode(utf8.encode("$username:$password"))}";
      headers["authorization"] = basicAuth;
    }
    String url = generateURL(baseURL, restOfURL);
    if (RegExp(r"^http://").hasMatch(url) &&
        !RegExp(r"^http://localhost(:[0-9]+)?(/.*)?$").hasMatch(url)) {
      return http.Response("426 HTTPS required", 426,
          reasonPhrase: "HTTPS Required");
    }
    Future<Response> query;
    if (postBody == null) {
      query = http.get(Uri.parse(url), headers: headers);
    } else {
      query = http.post(Uri.parse(url), headers: headers, body: postBody);
    }
    var response = await query
        .timeout(Duration(seconds: BackgroundWorker.settings.syncTimeout),
            onTimeout: () {
      return http.Response("408 Client Timeout", 408,
          reasonPhrase: "Client Timeout");
    });
    return response;
  }

  String generateURL(String baseURL, String restOfURL) {
    String prefix;
    if (RegExp(r"^https?://").hasMatch(baseURL)) {
      prefix = "";
    } else if (RegExp(r"^localhost(:[0-9]*)?(/.*)?$").hasMatch(baseURL)) {
      prefix = "http://";
    } else {
      prefix = "https://";
    }
    return prefix + baseURL + restOfURL;
  }
}

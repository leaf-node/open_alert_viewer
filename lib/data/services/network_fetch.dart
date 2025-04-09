/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../background/domain/background_external.dart';

String useragent = "open_alert_viewer/1";

mixin NetworkFetch {
  Future<http.Response> networkFetch(
    String baseURL,
    String username,
    String password,
    String restOfURL, {
    String? postBody,
    bool authOverride = false,
    Map<String, String>? headers,
    int? maxTimeout,
  }) async {
    Map<String, String> collectedHeaders = {"User-Agent": useragent};
    collectedHeaders.addAll(headers ?? {});
    if ((username != "" || password != "") && !authOverride) {
      var basicAuth =
          "Basic ${base64.encode(utf8.encode("$username:$password"))}";
      collectedHeaders["authorization"] = basicAuth;
    }
    String url = generateURL(baseURL, restOfURL);
    if (RegExp(r"^http://").hasMatch(url) &&
        !RegExp(r"^http://localhost(:[0-9]+)?(/.*)?$").hasMatch(url)) {
      return http.Response(
        "426 HTTPS required",
        426,
        reasonPhrase: "HTTPS Required",
      );
    }
    Uri? parsedURI;
    Future<Response> query;
    try {
      parsedURI = Uri.parse(url);
    } catch (e) {
      parsedURI = null;
    }
    if (parsedURI == null || parsedURI.host == "") {
      return http.Response("400 Bad Request", 400, reasonPhrase: "Bad Request");
    }
    if (postBody == null) {
      query = http.get(parsedURI, headers: collectedHeaders);
    } else {
      query = http.post(parsedURI, headers: collectedHeaders, body: postBody);
    }
    var timeout = BackgroundChannel.settings!.syncTimeout;
    if (maxTimeout != null) {
      timeout = (timeout > maxTimeout) ? maxTimeout : timeout;
    }
    var response = await query.timeout(
      Duration(seconds: timeout),
      onTimeout: () {
        return http.Response(
          "408 Client Timeout",
          408,
          reasonPhrase: "Client Timeout",
        );
      },
    );
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

  Future<bool> isOnline(String baseURL) async {
    final isLocalhost = RegExp(
      r"^(https?://)?localhost(:[0-9]+)?(/.*)?",
    ).hasMatch(baseURL);
    try {
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();
      return isLocalhost ||
          !connectivityResult.contains(ConnectivityResult.none);
    } catch (e) {
      return true;
    }
  }
}

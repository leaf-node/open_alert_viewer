/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../app/data_source/network_fetch.dart';

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
      required this.url,
      required this.age,
      required this.downtimeScheduled,
      required this.silenced,
      required this.active});

  final int source;
  final AlertType kind;
  final String hostname;
  final String service;
  final String message;
  final String url;
  final Duration age;
  final bool downtimeScheduled;
  final bool silenced;
  final bool active;
}

class AlertSourceData {
  AlertSourceData({
    required this.id,
    required this.name,
    required this.type,
    required this.authType,
    required this.baseURL,
    required this.username,
    required this.password,
    required this.failing,
    required this.lastSeen,
    required this.priorFetch,
    required this.lastFetch,
    required this.errorMessage,
    this.isValid,
    this.serial,
  });

  int? id;
  String name;
  int type;
  int authType;
  String baseURL;
  String username;
  String password;
  bool failing;
  DateTime lastSeen;
  DateTime priorFetch;
  DateTime lastFetch;
  String errorMessage;
  bool? isValid;
  int? serial;

  AlertSourceData copy() {
    return AlertSourceData(
        id: id,
        name: name,
        type: type,
        authType: authType,
        baseURL: baseURL,
        username: username,
        password: password,
        failing: failing,
        lastSeen: lastSeen,
        priorFetch: priorFetch,
        lastFetch: lastFetch,
        errorMessage: errorMessage,
        isValid: isValid,
        serial: serial);
  }
}

enum AuthTypes {
  basicAuth("Basic Auth", 0);

  const AuthTypes(this.text, this.value);

  final String text;
  final int value;
}

enum SourceTypes {
  demo("Demo", -2),
  nullType("Null", -1),
  autodetect("Autodetect", 0),
  ici("Icinga", 3),
  nag("Nagios Core", 2),
  prom("Prometheus Alertmanager", 1);

  const SourceTypes(this.text, this.value);
  final String text;
  final int value;
}

abstract class AlertSource with NetworkFetch {
  const AlertSource({required this.sourceData});

  final AlertSourceData sourceData;

  Future<List<Alert>> fetchAlerts();

  List<Alert> alertForInvalidSource(AlertSourceData sourceData) {
    var errorMessage = sourceData.errorMessage;
    List<Alert> alerts = [
      Alert(
          source: sourceData.id!,
          kind: AlertType.syncFailure,
          hostname: sourceData.name,
          service: "OAV",
          message: "Error connecting to your account. "
              "(${(errorMessage == "") ? "Unknown reason" : errorMessage}). "
              "Try editing your account details. ",
          url: generateURL(sourceData.baseURL, ""),
          age: Duration.zero,
          silenced: false,
          downtimeScheduled: false,
          active: true)
    ];
    return alerts;
  }

  List<Alert> errorFetchingAlerts(
      {required AlertSourceData sourceData,
      required String error,
      required String endpoint}) {
    var alerts = [
      Alert(
          source: sourceData.id!,
          kind: AlertType.syncFailure,
          hostname: sourceData.name,
          service: "OAV",
          message: error,
          url: generateURL(sourceData.baseURL, endpoint),
          age: Duration.zero,
          silenced: false,
          downtimeScheduled: false,
          active: true)
    ];
    return alerts;
  }

  Future<List<Alert>> fetchAndDecodeJSON(
      {required List<Alert> Function(Map<String, dynamic> data)
          unstructuredDataToAlerts,
      required List<String> endpoints}) async {
    if (!(sourceData.isValid ?? false)) {
      return alertForInvalidSource(sourceData);
    }
    Map<String, dynamic> dataSet = {};
    for (String endpoint in endpoints) {
      Response? response;
      String errorMessage = "";
      try {
        response = await networkFetch(sourceData.baseURL, sourceData.username,
            sourceData.password, endpoint);
      } on SocketException catch (e) {
        errorMessage = e.message;
      } on HandshakeException catch (e) {
        errorMessage = e.message;
      } on ClientException catch (e) {
        errorMessage = e.message;
      }
      if (response == null || errorMessage.isNotEmpty) {
        return errorFetchingAlerts(
            sourceData: sourceData,
            error: "Error fetching alerts: $errorMessage",
            endpoint: endpoint);
      }
      if (response.statusCode != 200) {
        return errorFetchingAlerts(
            sourceData: sourceData,
            error: "Error fetching alerts: HTTP status code "
                "${response.statusCode}: ${response.reasonPhrase}",
            endpoint: endpoint);
      } else {
        try {
          dataSet[endpoint] = json.decode(response.body);
        } catch (e) {
          return errorFetchingAlerts(
              sourceData: sourceData,
              error: "Error decoding reply: invalid JSON",
              endpoint: endpoint);
        }
      }
    }
    return unstructuredDataToAlerts(dataSet);
  }
}

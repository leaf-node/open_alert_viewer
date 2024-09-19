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
      required this.age});

  final int source;
  final AlertType kind;
  final String hostname;
  final String service;
  final String message;
  final String url;
  final Duration age;
}

class AlertSourceData {
  AlertSourceData({
    required this.id,
    required this.name,
    required this.type,
    required this.baseURL,
    required this.path,
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
  String baseURL;
  String path;
  String username;
  String password;
  bool failing;
  DateTime lastSeen;
  DateTime priorFetch;
  DateTime lastFetch;
  String errorMessage;
  bool? isValid;
  int? serial;
}

enum SourceTypes {
  demo("Demo", -2),
  nullType("Null", -1),
  autodetect("Autodetect", 0),
  ici("Icinga", 3),
  nag("Nagios", 2),
  prom("Prometheus", 1);

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
          url: generateURL(sourceData.baseURL, "", ""),
          age: Duration.zero)
    ];
    return alerts;
  }

  List<Alert> errorFetchingAlerts(
      {required AlertSourceData sourceData,
      required String error,
      required String parameters}) {
    var alerts = [
      Alert(
          source: sourceData.id!,
          kind: AlertType.syncFailure,
          hostname: sourceData.name,
          service: "OAV",
          message: error,
          url: generateURL(sourceData.baseURL, sourceData.path, parameters),
          age: Duration.zero)
    ];
    return alerts;
  }

  Future<List<Alert>> fetchAndDecodeJSON(
      {required List<Alert> Function(Map<String, dynamic> data)
          unstructuredDataToAlerts,
      required List<String> queryParametersSet}) async {
    if (!(sourceData.isValid ?? false)) {
      return alertForInvalidSource(sourceData);
    }
    Response response;
    Map<String, dynamic> dataSet = {};
    for (String parameters in queryParametersSet) {
      try {
        response = await networkFetch(sourceData.baseURL, sourceData.path,
            sourceData.username, sourceData.password, parameters);
      } on SocketException catch (e) {
        return errorFetchingAlerts(
            sourceData: sourceData,
            error: "Error fetching alerts: ${e.message}",
            parameters: parameters);
      }
      if (response.statusCode != 200) {
        return errorFetchingAlerts(
            sourceData: sourceData,
            error: "Error fetching alerts: HTTP status code "
                "${response.statusCode}: ${response.reasonPhrase}",
            parameters: parameters);
      } else {
        try {
          dataSet[parameters] = json.decode(response.body);
        } catch (e) {
          return errorFetchingAlerts(
              sourceData: sourceData,
              error: "Error decoding reply: invalid JSON",
              parameters: parameters);
        }
      }
    }
    return unstructuredDataToAlerts(dataSet);
  }
}

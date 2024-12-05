/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../app/data_source/network_fetch.dart';

part 'alerts.g.dart';

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

@JsonSerializable()
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

  factory Alert.fromJson(Map<String, dynamic> json) => _$AlertFromJson(json);

  Map<String, dynamic> toJson() => _$AlertToJson(this);
}

@JsonSerializable()
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
    required this.accessToken,
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
  String accessToken;
  int? serial;

  factory AlertSourceData.fromJson(Map<String, dynamic> json) =>
      _$AlertSourceDataFromJson(json);

  Map<String, dynamic> toJson() => _$AlertSourceDataToJson(this);

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
        accessToken: accessToken,
        serial: serial);
  }
}

enum SilenceTypes {
  downtimeScheduled("Downtime Scheduled", 0),
  acknowledged("Acknowledged", 1),
  inactive("Inactive", 2);

  const SilenceTypes(this.text, this.id);

  final String text;
  final int id;
}

enum AuthTypes {
  basicAuth("Basic Auth", 0);

  const AuthTypes(this.text, this.value);

  final String text;
  final int value;
}

enum SourceTypes {
  demo("Demo", -2),
  nullType("Unknown", -1),
  autodetect("Autodetect", 0),
  ici("Icinga", 3),
  nag("Nagios Core", 2),
  prom("Prometheus Alertmanager", 1);

  const SourceTypes(this.text, this.value);
  final String text;
  final int value;
}

@JsonSerializable()
class AlertSource with NetworkFetch {
  const AlertSource({required this.sourceData});

  final AlertSourceData sourceData;

  factory AlertSource.fromJson(Map<String, dynamic> json) =>
      _$AlertSourceFromJson(json);

  Map<String, dynamic> toJson() => _$AlertSourceToJson(this);

  Future<List<Alert>> fetchAlerts() async {
    return [];
  }

  List<Alert> alertForInvalidSource(AlertSourceData sourceData) {
    final error = sourceData.errorMessage;
    return errorFetchingAlerts(
        sourceData: sourceData,
        error: "Error connecting to your account. "
            "(${(error == "") ? "Unknown reason" : error}). "
            "Try editing your account details. ",
        endpoint: "");
  }

  List<Alert> errorFetchingAlerts(
      {required AlertSourceData sourceData,
      required String error,
      required String endpoint}) {
    return [
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
  }

  Future<(dynamic, List<Alert>)> fetchAndDecodeJSON(
      {required String endpoint,
      String? postBody,
      bool? authOverride,
      Map<String, String>? headers}) async {
    if (!(sourceData.isValid ?? false)) {
      return (null, alertForInvalidSource(sourceData));
    }
    dynamic dataSet;
    Response? response;
    String errorMessage = "";
    try {
      response = await networkFetch(sourceData.baseURL, sourceData.username,
          sourceData.password, endpoint,
          postBody: postBody, authOverride: authOverride, headers: headers);
    } on SocketException catch (e) {
      errorMessage = e.message;
    } on HandshakeException catch (e) {
      errorMessage = e.message;
    } on ClientException catch (e) {
      errorMessage = e.message;
    }
    if (response == null || errorMessage.isNotEmpty) {
      return (
        null,
        errorFetchingAlerts(
            sourceData: sourceData,
            error: "Error fetching alerts: $errorMessage",
            endpoint: endpoint)
      );
    }
    if (response.statusCode != 200) {
      return (
        null,
        errorFetchingAlerts(
            sourceData: sourceData,
            error: "Error fetching alerts: HTTP status code "
                "${response.statusCode}: ${response.reasonPhrase}",
            endpoint: endpoint)
      );
    } else {
      try {
        dataSet = json.decode(response.body);
      } catch (e) {
        return (
          null,
          errorFetchingAlerts(
              sourceData: sourceData,
              error: "Error parsing reply: invalid JSON",
              endpoint: endpoint)
        );
      }
    }
    return (dataSet, <Alert>[]);
  }
}

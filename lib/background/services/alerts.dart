/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../data/services/network_fetch.dart';
import '../../domain/alerts.dart';

abstract class AlertSource with NetworkFetch {
  const AlertSource({required this.sourceData});

  final AlertSourceData sourceData;

  Future<List<Alert>> fetchAlerts();

  List<Alert> alertForInvalidSource() {
    final error = sourceData.errorMessage;
    return errorFetchingAlerts(
      sourceData: sourceData,
      error:
          "Error connecting to your account. "
          "(${(error == "") ? "Unknown reason" : error}). "
          "Try editing your account details. ",
      endpoint: "",
    );
  }

  List<Alert> errorFetchingAlerts({
    required AlertSourceData sourceData,
    required String error,
    required String endpoint,
  }) {
    return [
      Alert(
        source: sourceData.id!,
        kind: AlertType.syncFailure,
        hostname: sourceData.name,
        service: "OAV",
        message: error,
        monitorUrl: generateURL(sourceData.baseURL, endpoint),
        serviceUrl: "",
        age: Duration.zero,
        silenced: false,
        downtimeScheduled: false,
        active: true,
      ),
    ];
  }

  Future<(dynamic, List<Alert>)> fetchAndDecodeJSON({
    required String endpoint,
    String? postBody,
    bool authOverride = false,
    Map<String, String>? headers,
  }) async {
    if (!(sourceData.isValid ?? false)) {
      return (null, alertForInvalidSource());
    }
    dynamic dataSet;
    Response? response;
    String errorMessage = "";
    try {
      response = await networkFetch(
        sourceData.baseURL,
        sourceData.username,
        sourceData.password,
        endpoint,
        postBody: postBody,
        authOverride: authOverride,
        headers: headers,
      );
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
          endpoint: endpoint,
        ),
      );
    }
    if (response.statusCode != 200) {
      return (
        null,
        errorFetchingAlerts(
          sourceData: sourceData,
          error:
              "Error fetching alerts: HTTP status code "
              "${response.statusCode}: ${response.reasonPhrase}",
          endpoint: endpoint,
        ),
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
            endpoint: endpoint,
          ),
        );
      }
    }
    return (dataSet, <Alert>[]);
  }
}

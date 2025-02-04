/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/alerts.dart';
import 'alerts.dart';

part 'alerts_prom.freezed.dart';
part 'alerts_prom.g.dart';

class PromAlerts extends AlertSource {
  PromAlerts({required super.sourceData});

  static const endpoint = "/api/v2/alerts";

  @override
  Future<List<Alert>> fetchAlerts() async {
    dynamic dataSet;
    List<Alert> errors;
    (dataSet, errors) = await fetchAndDecodeJSON(endpoint: endpoint);
    if (dataSet == null) {
      if (errors.isEmpty) {
        throw Exception("Missing alert message after Prometheus fetch error");
      } else {
        return errors;
      }
    }
    List<Alert> newAlerts = [];
    for (Map<String, dynamic> datum in dataSet as List) {
      PromAlertsData alertDatum = PromAlertsData.fromJson(datum);
      final severity = alertDatum.labels?.severity ?? "unknown";
      final type = alertDatum.labels?.oav_type ?? "";
      AlertType kind;
      if (RegExp(r"^(error|page|critical)$").hasMatch(severity)) {
        kind = RegExp(r"^(ping|icmp)$").hasMatch(type)
            ? AlertType.down
            : AlertType.error;
      } else if (RegExp(r"^(warning)$").hasMatch(severity)) {
        kind = AlertType.warning;
      } else {
        kind = AlertType.unknown;
      }
      newAlerts.add(Alert(
          source: sourceData.id!,
          kind: kind,
          hostname: alertDatum.labels?.instance ?? "Unknown Host",
          service: alertDatum.labels?.alertname ?? "Unknown",
          message: alertDatum.annotations?.summary ?? "...",
          url: alertDatum.generatorURL ?? "",
          age: (alertDatum.startsAt == null)
              ? Duration.zero
              : DateTime.now().difference(DateTime.parse(alertDatum.startsAt!)),
          silenced: (alertDatum.status != null &&
              alertDatum.status!.silencedBy != null &&
              alertDatum.status!.silencedBy!.isNotEmpty),
          downtimeScheduled: false,
          active: true));
    }
    return newAlerts;
  }
}

@freezed
class PromAlertsData with _$PromAlertsData {
  const factory PromAlertsData(
      // ignore: non_constant_identifier_names
      {String? startsAt,
      String? updatedAt,
      String? endsAt,
      String? generatorURL,
      AnnotationsData? annotations,
      LabelsData? labels,
      StatusData? status}) = _PromAlertsData;

  factory PromAlertsData.fromJson(Map<String, dynamic> json) =>
      _$PromAlertsDataFromJson(json);
}

@freezed
class AnnotationsData with _$AnnotationsData {
  const factory AnnotationsData({String? summary}) = _AnnotationsData;

  factory AnnotationsData.fromJson(Map<String, dynamic> json) =>
      _$AnnotationsDataFromJson(json);
}

@freezed
class StatusData with _$StatusData {
  const factory StatusData({List<Object>? silencedBy}) = _StatusData;

  factory StatusData.fromJson(Map<String, dynamic> json) =>
      _$StatusDataFromJson(json);
}

@freezed
class LabelsData with _$LabelsData {
  const factory LabelsData(
      {String? severity,
      // ignore: non_constant_identifier_names
      String? oav_type,
      String? instance,
      String? alertname}) = _LabelsData;

  factory LabelsData.fromJson(Map<String, dynamic> json) =>
      _$LabelsDataFromJson(json);
}

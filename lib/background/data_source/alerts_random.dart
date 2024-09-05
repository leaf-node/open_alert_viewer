/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:math';

import '../../alerts/model/alerts.dart';

class RandomAlerts implements AlertSource {
  RandomAlerts(
      {required this.id,
      required this.name,
      required this.type,
      required this.baseURL,
      required this.path,
      required this.username,
      required this.password})
      : _randomSeed = Random(DateTime.now().microsecondsSinceEpoch),
        _alerts = [];

  @override
  final int id;
  @override
  final String name;
  @override
  final int type;
  @override
  final String baseURL;
  @override
  final String path;
  @override
  final String username;
  @override
  final String password;
  final Random _randomSeed;
  List<Alert> _alerts;

  @override
  Future<List<Alert>> fetchAlerts() async {
    List<Alert> nextAlerts = [];
    int count = 20 + _randomSeed.nextInt(20);
    for (int i = 0; i < count; i++) {
      nextAlerts.add(Alert(
          source: id,
          kind: AlertType
              .values[_randomSeed.nextInt(AlertType.values.length - 1)],
          hostname: "example.com",
          service: "fizz buzz",
          message: "foo bar baz",
          url: "https://example.com",
          age: Duration(seconds: _randomSeed.nextInt(60 * 10))));
    }
    // simulate network timeout
    await Future.delayed(Duration(milliseconds: _randomSeed.nextInt(4000)));
    _alerts = nextAlerts;
    return _alerts;
  }
}

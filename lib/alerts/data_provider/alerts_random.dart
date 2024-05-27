/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:math';

import '../model/alerts.dart';

class RandomAlerts implements AlertSource {
  RandomAlerts({required this.id, required this.name}) {
    _randomSeed = Random(DateTime.now().millisecondsSinceEpoch);
    _alerts = [];
  }

  final int id;
  final String name;
  late Random _randomSeed;
  late List<Alert> _alerts;

  @override
  Future<List<Alert>> fetchAlerts() async {
    List<Alert> nextAlerts = [];
    int count = 20 + _randomSeed.nextInt(20);
    for (int i = 0; i < count; i++) {
      nextAlerts.add(Alert(
          source: 0,
          kind: AlertType.values[_randomSeed.nextInt(AlertType.values.length)],
          hostname: "example.com",
          service: "fizz buzz",
          message: "foo bar baz",
          age: Duration(seconds: _randomSeed.nextInt(60 * 60 * 24 * 7))));
    }
    // simulate network timeout
    await Future.delayed(const Duration(seconds: 2));
    _alerts = nextAlerts;
    return _alerts;
  }
}

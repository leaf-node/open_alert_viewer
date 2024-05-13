import 'dart:math';

import 'alert.dart';

abstract class AlertSource {
  const AlertSource();

  Future<List<Alert>> fetchAlerts(Duration maxCacheAge);
}

class RandomAlerts implements AlertSource {
  RandomAlerts() {
    _randomSeed = Random(DateTime.now().millisecondsSinceEpoch);
    _alerts = [];
    _nextAlerts = [];
    _lastFetch = DateTime.utc(1970);
  }

  late Random _randomSeed;
  late List<Alert> _alerts;
  late List<Alert> _nextAlerts;
  late DateTime _lastFetch;

  @override
  Future<List<Alert>> fetchAlerts(Duration maxCacheAge) async {
    if (maxCacheAge.compareTo(DateTime.now().difference(_lastFetch)) > 0) {
      return _alerts;
    }

    _nextAlerts = [];
    int count = 20 + _randomSeed.nextInt(20);
    for (int i = 0; i < count; i++) {
      _nextAlerts.add(Alert(
          kind: AlertType.values[_randomSeed.nextInt(AlertType.values.length)],
          message: "something broke",
          age: Duration(seconds: _randomSeed.nextInt(60 * 60 * 24 * 7))));
    }
    // simulate network timeout
    await Future.delayed(const Duration(seconds: 2));

    _lastFetch = DateTime.now();
    _alerts = _nextAlerts;
    return _alerts;
  }
}

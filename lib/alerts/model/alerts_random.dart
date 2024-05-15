import 'dart:math';

import 'alerts.dart';

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
          source: 0,
          kind: AlertType.values[_randomSeed.nextInt(AlertType.values.length)],
          hostname: "example.com",
          service: "fizz buzz",
          message: "foo bar baz",
          age: Duration(seconds: _randomSeed.nextInt(60 * 60 * 24 * 7))));
    }
    // simulate network timeout
    await Future.delayed(const Duration(seconds: 2));
    _nextAlerts.sort((a, b) => a.age.compareTo(b.age));

    _lastFetch = DateTime.now();
    _alerts = _nextAlerts;
    return _alerts;
  }
}

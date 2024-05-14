enum AlertType { up, okay, warning, error, unreachable, down, unknown, pending }

class Alert {
  const Alert(
      {required this.kind,
      required this.hostname,
      required this.message,
      required this.age});

  final AlertType kind;
  final String hostname;
  final String message;
  final Duration age;
}

abstract class AlertSource {
  const AlertSource();

  Future<List<Alert>> fetchAlerts(Duration maxCacheAge);
}

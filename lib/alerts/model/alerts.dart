enum AlertType {
  okay,
  warning,
  error,
  pending,
  unknown,
  up,
  unreachable,
  down,
  hostPending
}

class Alert {
  const Alert(
      {required this.kind,
      required this.hostname,
      required this.service,
      required this.message,
      required this.age});

  final AlertType kind;
  final String hostname;
  final String service;
  final String message;
  final Duration age;
}

abstract class AlertSource {
  const AlertSource();

  Future<List<Alert>> fetchAlerts(Duration maxCacheAge);
}

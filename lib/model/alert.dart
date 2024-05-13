enum AlertType { okay, warning, error, unreachable, down, unknown }

class Alert {
  const Alert({required this.kind, required this.message, required this.age});

  final AlertType kind;
  final String message;
  final Duration age;
}

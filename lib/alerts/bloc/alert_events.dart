import '../model/alerts.dart';

abstract class AlertEvent {
  const AlertEvent();
}

final class FetchAlerts implements AlertEvent {
  const FetchAlerts({required this.maxCacheAge});

  final Duration maxCacheAge;
}

final class AddAlertSource implements AlertEvent {
  const AddAlertSource({required this.source});

  final AlertSource source;
}

final class RemoveAlertSource implements AlertEvent {
  const RemoveAlertSource({required this.source});

  final AlertSource source;
}

import '../model/alert.dart';
import 'package:equatable/equatable.dart';

abstract class AlertState extends Equatable {
  const AlertState(this.alerts);

  final List<Alert> alerts;

  @override
  List<Object> get props => alerts;
}

final class AlertsInit extends AlertState {
  const AlertsInit() : super(const []);
}

final class AlertsFetching extends AlertState {
  const AlertsFetching(super.alerts);
}

final class AlertsFetched extends AlertState {
  const AlertsFetched(super.alerts);
}

import 'package:bloc/bloc.dart';

import '../model/alert.dart';
import '../model/alerts.dart';

class AlertsCubit extends Cubit<List<Alert>> {
  AlertsCubit(this.sources) : super([]);

  late List<AlertSource> sources;

  Future<void> fetch(Duration maxCacheAge) async {
    List<Alert> alerts = [];
    for (var source in sources) {
      alerts.addAll(await source.fetchAlerts(maxCacheAge));
    }
    emit(alerts);
  }
}

/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import '../../../alerts/model/alerts.dart';
import '../../app/data_source/database.dart';
import '../../app/data_repository/settings_repository.dart';
import '../background.dart';
import 'notifications.dart';
import 'sources.dart';

class AlertsRepo {
  AlertsRepo(
      {required LocalDatabase db,
      required SettingsRepo settings,
      required SourcesRepo sourcesRepo,
      required NotificationRepo notifier})
      : _db = db,
        _sourcesRepo = sourcesRepo,
        _settings = settings,
        _notifier = notifier,
        _alertSources = [],
        _alerts = [];

  final LocalDatabase _db;
  final SettingsRepo _settings;
  final SourcesRepo _sourcesRepo;
  final NotificationRepo _notifier;
  late StreamController<IsolateMessage> _outboundStream;
  List<AlertSource> _alertSources;
  List<Alert> _alerts;
  Timer? _timer;
  bool _fetching = false;

  void init(StreamController<IsolateMessage> outboundStream) async {
    _outboundStream = outboundStream;
    startTimer();
  }

  Future<void> fetchAlerts({required bool forceRefreshNow}) async {
    if (_fetching) {
      return;
    }
    _fetching = true;
    int interval = _settings.refreshInterval;
    _fetchCachedAlerts();
    _alertSources = _sourcesRepo.alertSources;
    _outboundStream.add(IsolateMessage(
        name: MessageName.alertsFetching,
        destination: MessageDestination.alerts,
        alerts: _alerts,
        sources: _alertSources));
    _outboundStream.add(const IsolateMessage(
        name: MessageName.showRefreshIndicator,
        destination: MessageDestination.refreshIcon,
        forceRefreshNow: false,
        alreadyFetching: true));
    if (!forceRefreshNow) {
      if (interval == -1) {
        _outboundStream.add(IsolateMessage(
            name: MessageName.alertsFetched,
            destination: MessageDestination.alerts,
            alerts: _alerts));
        _fetching = false;
        return;
      }
      var maxCacheAge = Duration(seconds: interval);
      var lastFetched = _settings.lastFetched;
      if (maxCacheAge.compareTo(DateTime.now().difference(lastFetched)) >= 0) {
        _outboundStream.add(IsolateMessage(
            name: MessageName.alertsFetched,
            destination: MessageDestination.alerts,
            alerts: _alerts));
        _fetching = false;
        return;
      }
    }
    List<Future<List<Alert>>> incoming = [];
    List<Alert> freshAlerts = [];
    var lastFetched = DateTime.now();
    var oldSyncFailures = _alerts
        .where((oldAlert) => oldAlert.kind == AlertType.syncFailure)
        .toList();
    for (var source in _alertSources) {
      var sourceFuture = source.fetchAlerts();
      sourceFuture = sourceFuture.catchError((Object error) {
        source.sourceData.failing = true;
        _sourcesRepo.updateSource(sourceData: source.sourceData);
        String message;
        if (error is Error) {
          message = "${error.toString()}\n${error.stackTrace.toString()}";
        } else {
          message = error.toString();
        }
        return Future.value([
          Alert(
              source: source.sourceData.id!,
              kind: AlertType.syncFailure,
              hostname: source.sourceData.name,
              service: "OAV",
              message: "Error fetching alerts. "
                  "Please open an issue using the link icon to the left.",
              url: "https://github.com/okaycode-dev/open_alert_viewer/issues",
              age: Duration.zero),
          Alert(
              source: source.sourceData.id!,
              kind: AlertType.syncFailure,
              hostname: source.sourceData.name,
              service: "OAV",
              message: message,
              url: "https://github.com/okaycode-dev/open_alert_viewer/issues",
              age: Duration.zero)
        ]);
      });
      incoming.add(sourceFuture);
      incoming.last.then((List<Alert> newAlerts) {
        if (newAlerts.isEmpty || newAlerts[0].kind != AlertType.syncFailure) {
          source.sourceData.failing = false;
          _sourcesRepo.updateSource(sourceData: source.sourceData);
        }
        var updatedAlerts = _updateSyncFailureAges(newAlerts, oldSyncFailures);
        _alerts = _alerts
            .where((alert) => alert.source != source.sourceData.id)
            .toList();
        _alerts.addAll(updatedAlerts);
        _alerts.sort(_alertSort);
        _outboundStream.add(IsolateMessage(
            name: MessageName.alertsFetching,
            destination: MessageDestination.alerts,
            alerts: _alerts));
        freshAlerts.addAll(updatedAlerts);
      });
    }
    await Future.wait(incoming);
    _alerts = freshAlerts;
    _alerts.sort(_alertSort);
    _outboundStream.add(IsolateMessage(
        name: MessageName.alertsFetching,
        destination: MessageDestination.alerts,
        alerts: _alerts));
    _cacheAlerts();
    _settings.priorFetch = _settings.lastFetched;
    _settings.lastFetched = lastFetched;
    _outboundStream.add(IsolateMessage(
        name: MessageName.alertsFetched,
        destination: MessageDestination.alerts,
        alerts: _alerts));
    _notifier.showFilteredNotifications(
        alerts: _alerts, sources: _alertSources, alertStream: _outboundStream);
    _fetching = false;
  }

  List<Alert> _updateSyncFailureAges(
      List<Alert> alerts, List<Alert> oldSyncFailures) {
    return alerts.map((alert) {
      if (alert.kind == AlertType.syncFailure) {
        var oldAlerts = oldSyncFailures
            .where((oldAlert) => oldAlert.source == alert.source)
            .toList();
        if (oldAlerts.isEmpty) {
          return alert;
        }
        var newAge =
            oldAlerts[0].age + DateTime.now().difference(_settings.lastFetched);
        return Alert(
            source: alert.source,
            kind: alert.kind,
            hostname: alert.hostname,
            service: alert.service,
            message: alert.message,
            url: alert.url,
            age: newAge);
      }
      return alert;
    }).toList();
  }

  int _alertSort(Alert a, Alert b) {
    if ((a.kind == b.kind) ||
        (a.kind != AlertType.syncFailure && b.kind != AlertType.syncFailure)) {
      return a.age.compareTo(b.age);
    } else if (a.kind == AlertType.syncFailure) {
      return -1;
    } else {
      return 1;
    }
  }

  void _cacheAlerts() {
    _db.removeCachedAlerts();
    _db.insertIntoAlertsCache(alerts: _alerts);
  }

  List<Alert> _fetchCachedAlerts() {
    _alerts = _db.fetchCachedAlerts();
    return _alerts;
  }

  void startTimer() {
    if (_timer != null) {
      return;
    }
    fetchAlerts(forceRefreshNow: false);
    var nextFetchIn = _settings.lastFetched
        .add(Duration(seconds: _settings.refreshInterval))
        .difference(DateTime.now());
    Future.delayed(nextFetchIn, () {
      refreshTimer();
    });
  }

  void refreshTimer() {
    _timer?.cancel();
    _timer =
        Timer.periodic(Duration(seconds: _settings.refreshInterval), (timer) {
      fetchAlerts(forceRefreshNow: true);
    });
    fetchAlerts(forceRefreshNow: true);
  }
}

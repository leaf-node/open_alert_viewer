/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import '../../data/services/network_fetch.dart';
import '../../domain/alerts.dart';
import '../../data/services/database.dart';
import '../../data/repositories/settings_repo.dart';
import '../domain/background_shared.dart';
import 'notifications_bg_repo.dart';
import 'sources_bg_repo.dart';

class AlertsBackgroundRepo with NetworkFetch {
  AlertsBackgroundRepo(
      {required LocalDatabase db,
      required SettingsRepo settings,
      required SourcesBackgroundRepo sourcesRepo,
      required NotificationsBackgroundRepo notifier})
      : _db = db,
        _sourcesRepo = sourcesRepo,
        _settings = settings,
        _notifier = notifier,
        _alertSources = [],
        _alerts = [];

  final LocalDatabase _db;
  final SettingsRepo _settings;
  final SourcesBackgroundRepo _sourcesRepo;
  final NotificationsBackgroundRepo _notifier;
  late StreamController<IsolateMessage> _outboundStream;
  List<AlertSourceData> _alertSources;
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
        alerts: _alerts));
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
    var currentFetch = DateTime.now();
    var oldSyncFailures = _alerts
        .where((oldAlert) => oldAlert.kind == AlertType.syncFailure)
        .toList();
    for (var source in _alertSources) {
      var sourceFuture = _sourcesRepo.getClassedSource(source).fetchAlerts();
      sourceFuture = sourceFuture.catchError((Object error) {
        String message;
        if (error is Error) {
          message = "${error.toString()}\n${error.stackTrace.toString()}";
        } else {
          message = error.toString();
        }
        return Future.value([
          Alert(
              source: source.id!,
              kind: AlertType.syncFailure,
              hostname: source.name,
              service: "OAV",
              message: "Error fetching alerts. "
                  "Please open an issue using the alert link to "
                  "report this error.",
              serviceUrl:
                  "https://github.com/okcode-studio/open_alert_viewer/issues",
              monitorUrl: generateURL(source.baseURL, ""),
              age: Duration.zero,
              silenced: false,
              downtimeScheduled: false,
              active: true),
          Alert(
              source: source.id!,
              kind: AlertType.syncFailure,
              hostname: source.name,
              service: "OAV",
              message: message,
              serviceUrl:
                  "https://github.com/okcode-studio/open_alert_viewer/issues",
              monitorUrl: generateURL(source.baseURL, ""),
              age: Duration.zero,
              silenced: false,
              downtimeScheduled: false,
              active: true)
        ]);
      });
      incoming.add(sourceFuture);
      incoming.last.then((List<Alert> newAlerts) {
        bool priorValue = source.failing;
        bool failing;
        if (newAlerts
            .where((v) => v.kind == AlertType.syncFailure)
            .isNotEmpty) {
          failing = true;
        } else {
          failing = false;
        }
        if (failing != priorValue) {
          _sourcesRepo.setFailingStatus(id: source.id!, failing: failing);
        }
        var updatedAlerts = _updateSyncFailureAges(newAlerts, oldSyncFailures);
        _alerts = _alerts.where((alert) => alert.source != source.id).toList();
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
    for (var source in _alertSources) {
      if (!source.failing) {
        _sourcesRepo.setLastAndPriorFetch(
            id: source.id!, lastFetch: currentFetch);
      }
    }
    _settings.priorFetch = _settings.lastFetched;
    _settings.lastFetched = currentFetch;
    _outboundStream.add(IsolateMessage(
        name: MessageName.alertsFetched,
        destination: MessageDestination.alerts,
        alerts: _alerts));
    _notifier.showFilteredNotifications(
        alerts: _alerts,
        allSources: _alertSources,
        alertStream: _outboundStream);
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
            serviceUrl: alert.serviceUrl,
            monitorUrl: alert.monitorUrl,
            age: newAge,
            silenced: false,
            downtimeScheduled: false,
            active: true);
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

  void refreshTimer() async {
    _timer?.cancel();
    if (_settings.refreshInterval != -1) {
      _timer =
          Timer.periodic(Duration(seconds: _settings.refreshInterval), (timer) {
        fetchAlerts(forceRefreshNow: true);
      });
    }
    fetchAlerts(forceRefreshNow: true);
    if (await _settings.notificationsEnabledSafe) {
      _notifier.updateAnroidStickyNotification();
    }
  }
}

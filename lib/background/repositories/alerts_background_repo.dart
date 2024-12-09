/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import '../../domain/alerts.dart';
import '../../data/services/database.dart';
import '../../data/repositories/settings_repository.dart';
import '../background.dart';
import 'notifications_background_repo.dart';
import 'sources_background_repo.dart';

class AlertsBackgroundRepo {
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
        alerts: _alerts,
        allSources: _alertSources));
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
                  "Please open an issue using the link icon to the left to "
                  "report any persistent errors.",
              url: "https://github.com/okcode-studio/open_alert_viewer/issues",
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
              url: "https://github.com/okcode-studio/open_alert_viewer/issues",
              age: Duration.zero,
              silenced: false,
              downtimeScheduled: false,
              active: true)
        ]);
      });
      incoming.add(sourceFuture);
      incoming.last.then((List<Alert> newAlerts) {
        bool priorValue = source.failing;
        if (newAlerts
            .where((v) => v.kind == AlertType.syncFailure)
            .isNotEmpty) {
          source = source.copyWith(failing: true);
        } else {
          source = source.copyWith(failing: false);
        }
        if (source.failing != priorValue) {
          _sourcesRepo.updateSource(sourceData: source);
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
        source = source.copyWith(
            priorFetch: source.lastFetch, lastFetch: currentFetch);
        _sourcesRepo.updateSource(sourceData: source);
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
            url: alert.url,
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

  void refreshTimer() {
    _timer?.cancel();
    if (_settings.refreshInterval != -1) {
      _timer =
          Timer.periodic(Duration(seconds: _settings.refreshInterval), (timer) {
        fetchAlerts(forceRefreshNow: true);
      });
    }
    fetchAlerts(forceRefreshNow: true);
    if (_settings.notificationsEnabled) {
      _notifier.updateAnroidStickyNotification();
    }
  }
}

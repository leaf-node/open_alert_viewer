/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import '../../../background/domain/background_external.dart';
import '../../../background/domain/background_shared.dart';
import '../../domain/alerts.dart';
import '../services/database.dart';

class AccountsRepo {
  AccountsRepo({
    required LocalDatabase db,
    required BackgroundChannel bgChannel,
  }) : _db = db,
       _bgChannel = bgChannel;

  final LocalDatabase _db;
  final BackgroundChannel _bgChannel;

  bool checkUniqueSource({int? id, required String name}) {
    return _db.checkUniqueSource(id: id, name: name);
  }

  List<AlertSourceData> listSources() {
    return _db.listSources();
  }

  AlertSourceData? getSource(id) {
    final matches = listSources().where((e) => e.id == id);
    if (matches.isEmpty) {
      return null;
    } else {
      return matches.first;
    }
  }

  // should only be run right after `sourceData = getSource(sourceData.id)`
  void _updateSource(AlertSourceData sourceData) {
    _db.updateSource(sourceData: sourceData);
  }

  Future<void> switchVisibility(int id) async {
    AlertSourceData? source = getSource(id);
    source = source?.copyWith(visible: !source.visible);
    if (source != null) {
      _updateSource(source);
    }
    _bgChannel.makeRequest(IsolateMessage(name: MessageName.sourcesChanged));
    _bgChannel.makeRequest(
      IsolateMessage(name: MessageName.alertFiltersChanged),
    );
  }

  Future<void> switchNotifications(int id) async {
    AlertSourceData? source = getSource(id);
    source = source?.copyWith(notifications: !source.notifications);
    if (source != null) {
      _updateSource(source);
    }
    _bgChannel.makeRequest(IsolateMessage(name: MessageName.sourcesChanged));
    _bgChannel.makeRequest(
      IsolateMessage(name: MessageName.alertFiltersChanged),
    );
  }
}

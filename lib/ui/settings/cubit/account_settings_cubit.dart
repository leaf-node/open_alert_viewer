/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';
import 'package:open_alert_viewer/data/services/network_fetch.dart';

import '../../../domain/alerts.dart';
import '../../../background/background.dart';
import '../../../utils/utils.dart';
import 'account_settings_state.dart';

class AccountSettingsCubit extends Cubit<AccountSettingsState>
    with NetworkFetch {
  AccountSettingsCubit({required BackgroundChannel bgChannel})
      : _bgChannel = bgChannel,
        accountCheckSerial = -1,
        lastNeedsCheck = true,
        super(AccountSettingsState.init()) {
    _listenForConfirmations();
  }

  final BackgroundChannel _bgChannel;
  int accountCheckSerial;
  bool lastNeedsCheck;

  void confirmSource(
      {required AlertSourceData sourceData, bool? needsCheck, bool? checkNow}) {
    needsCheck = lastNeedsCheck = needsCheck ?? false;
    checkNow = checkNow ?? false;
    if (needsCheck) {
      emit(AccountSettingsState(
          sourceData: sourceData, status: CheckStatus.needsCheck));
    } else if (checkNow) {
      emit(AccountSettingsState(
          sourceData: sourceData, status: CheckStatus.checkingNow));
      sourceData =
          sourceData.copyWith(serial: accountCheckSerial = Util.genRandom());
      _bgChannel.makeRequest(IsolateMessage(
          name: MessageName.confirmSources, sourceData: sourceData));
    }
  }

  void addSource(AlertSourceData sourceData) {
    _bgChannel.makeRequest(
        IsolateMessage(name: MessageName.addSource, sourceData: sourceData));
  }

  void updateSource(AlertSourceData sourceData) {
    _bgChannel.makeRequest(
        IsolateMessage(name: MessageName.updateSource, sourceData: sourceData));
  }

  void removeSource(int id) {
    _bgChannel
        .makeRequest(IsolateMessage(name: MessageName.removeSource, id: id));
  }

  void cleanOut() {
    accountCheckSerial = Util.genRandom();
    lastNeedsCheck = true;
    emit(AccountSettingsState.init());
  }

  Future<void> _listenForConfirmations() async {
    await for (final message in _bgChannel
        .isolateStreams[MessageDestination.accountSettings]!.stream) {
      if (message.name == MessageName.confirmSourcesReply) {
        if (message.sourceData!.serial == accountCheckSerial &&
            !lastNeedsCheck) {
          emit(AccountSettingsState(
              sourceData: message.sourceData, status: CheckStatus.responded));
        }
      } else {
        throw Exception(
            "OAV Invalid 'accounts' stream message name: ${message.name}");
      }
    }
  }
}

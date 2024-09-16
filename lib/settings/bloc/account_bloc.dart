/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:math';

import 'package:bloc/bloc.dart';

import '../../alerts/model/alerts.dart';
import '../../background/background.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({required BackgroundWorker bgWorker})
      : _bgWorker = bgWorker,
        accountCheckSerial = -1,
        random = Random(DateTime.now().microsecondsSinceEpoch),
        lastNeedsCheck = true,
        super(AccountInitial(
            sourceData: null,
            needsCheck: true,
            checkingNow: false,
            responded: false)) {
    on<CleanOutAccountEvent>(_cleanOut);
    on<ConfirmAccountEvent>(_confirmSource);
    on<ListenForAccountConfirmations>(_listenForConfirmations);

    add(ListenForAccountConfirmations());
  }

  final BackgroundWorker _bgWorker;
  int accountCheckSerial;
  Random random;
  bool lastNeedsCheck;

  int _genRandom() {
    return random.nextInt(1 << 32);
  }

  void _confirmSource(ConfirmAccountEvent event, Emitter<AccountState> emit) {
    bool needsCheck = lastNeedsCheck = event.needsCheck ?? false;
    bool checkNow = event.checkNow ?? false;
    if (needsCheck) {
      emit(AccountConfirmSourceState(
          sourceData: event.sourceData,
          needsCheck: true,
          checkingNow: false,
          responded: false));
    } else if (checkNow) {
      emit(AccountConfirmSourceState(
          sourceData: event.sourceData,
          needsCheck: false,
          checkingNow: true,
          responded: false));
      event.sourceData.serial = accountCheckSerial = _genRandom();
      _bgWorker.makeRequest(IsolateMessage(
          name: MessageName.confirmSources, sourceData: event.sourceData));
    }
  }

  Future<void> _listenForConfirmations(
      ListenForAccountConfirmations event, Emitter<AccountState> emit) async {
    await for (final message in _bgWorker
        .isolateStreams[MessageDestination.accountSettings]!.stream) {
      if (message.name == MessageName.confirmSourcesReply) {
        if (message.sourceData!.serial == accountCheckSerial &&
            !lastNeedsCheck) {
          emit(AccountConfirmSourceState(
              sourceData: message.sourceData!,
              needsCheck: false,
              checkingNow: false,
              responded: true));
        }
      } else {
        throw Exception(
            "OAV Invalid 'settings' stream message name: ${message.name}");
      }
    }
  }

  void _cleanOut(CleanOutAccountEvent event, Emitter<AccountState> emit) {
    accountCheckSerial = _genRandom();
    lastNeedsCheck = true;
    emit(AccountInitial(
        sourceData: null,
        needsCheck: true,
        checkingNow: false,
        responded: false));
  }
}

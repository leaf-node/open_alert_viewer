/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:open_alert_viewer/data/repositories/account_repo.dart';

import '../../../background/domain/background_external.dart';
import '../../../background/domain/background_shared.dart';
import 'root_settings_state.dart';

class RootSettingsCubit extends Cubit<RootSettingsCubitState> {
  RootSettingsCubit({
    required BackgroundChannel bgChannel,
    required AccountsRepo accountsRepo,
  }) : _bgChannel = bgChannel,
       _accountsRepo = accountsRepo,
       super(RootSettingsCubitState.init()) {
    _state = state;
    _listenForSourceChanges();
  }

  RootSettingsCubitState? _state;
  final BackgroundChannel _bgChannel;
  final AccountsRepo _accountsRepo;

  void accountUpdated() {
    _state = _state!.copyWith(accountUpdated: true);
    emit(_state!);
  }

  Future<void> _listenForSourceChanges() async {
    await for (final message
        in _bgChannel
            .isolateStreams[MessageDestination.sourceSettings]!
            .stream) {
      if (message.name == MessageName.initSources) {
        // pass
      } else if (message.name == MessageName.sourcesChanged) {
        // pass
      } else if (message.name == MessageName.sourcesFailure) {
        // pass
      } else {
        throw Exception(
          "OAV Invalid 'sources' stream message name: ${message.name}",
        );
      }
      _state = _state!.copyWith(sources: _accountsRepo.listSources());
      emit(_state!);
    }
  }
}

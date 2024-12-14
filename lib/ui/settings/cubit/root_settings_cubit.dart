/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../background/background.dart';
import '../../../domain/alerts.dart';
import 'root_settings_state.dart';

class RootSettingsCubit extends Cubit<RootSettingsCubitState> {
  RootSettingsCubit({required BackgroundChannel bgChannel})
      : _bgChannel = bgChannel,
        super(RootSettingsCubitState.init()) {
    _state = state;
    _listenForSourceChanges();
  }

  RootSettingsCubitState? _state;
  final BackgroundChannel _bgChannel;

  Future<void> _listenForSourceChanges() async {
    List<AlertSourceData> sources = [];
    await for (final message in _bgChannel
        .isolateStreams[MessageDestination.sourceSettings]!.stream) {
      sources = message.allSources ?? sources;
      if (message.name == MessageName.initSources) {
        _state = _state!.copyWith(sources: sources);
      } else if (message.name == MessageName.sourcesChanged) {
        _state = _state!.copyWith(sources: sources);
      } else if (message.name == MessageName.sourcesFailure) {
        _state = _state!.copyWith(sources: sources);
      } else {
        throw Exception(
            "OAV Invalid 'sources' stream message name: ${message.name}");
      }
      _state = _state!.copyWith(sources: sources);
      emit(_state!);
    }
  }
}

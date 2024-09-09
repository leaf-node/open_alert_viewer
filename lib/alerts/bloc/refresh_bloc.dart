/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../background/background.dart';

part 'refresh_event.dart';
part 'refresh_state.dart';

class RefreshIconBloc extends Bloc<RefreshIconEvent, RefreshIconState> {
  RefreshIconBloc({required bgWorker})
      : _bgWorker = bgWorker,
        super(RefresIconInitial()) {
    on<RefreshIconNow>(_refreshIconNow, transformer: droppable());
    on<RefreshIconFinish>(_refreshFinish);
    on<ListenForRefreshIcon>(_listenForRefreshIcon);
    add(ListenForRefreshIcon());
  }

  final BackgroundWorker _bgWorker;

  Future<void> _refreshIconNow(
      RefreshIconNow event, Emitter<RefreshIconState> emit) async {
    emit(RefreshIconTriggered(
        forceRefreshNow: event.forceRefreshNow,
        alreadyFetching: event.alreadyFetching ?? false));
  }

  Future<void> _refreshFinish(
      RefreshIconFinish event, Emitter<RefreshIconState> emit) async {
    emit(RefreshIconFinished());
  }

  Future<void> _listenForRefreshIcon(
      ListenForRefreshIcon event, Emitter<RefreshIconState> emit) async {
    await for (final message
        in _bgWorker.isolateStreams[MessageDestination.refreshIcon]!.stream) {
      if (message.name == MessageName.showRefreshIndicator) {
        emit(RefreshIconTriggered(
            forceRefreshNow: message.forceRefreshNow ?? false,
            alreadyFetching: message.alreadyFetching ?? false));
      } else {
        throw Exception(
            "OAV Invalid 'refresh' stream message name: ${message.name}");
      }
    }
  }
}

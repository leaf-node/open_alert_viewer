/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';
import '../../app/data_repository/app_repository.dart';
import '../../notifications/bloc/notification_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({required AppRepo appRepo, required NotificationBloc notifier})
      : _appRepo = appRepo,
        _notifier = notifier,
        super(SplashInit()) {
    on<InitSplashEvent>(_splashInit);
    on<RunningSplashEvent>(_splashRunning);
    on<CompleteSplashEvent>(_splashComplete);

    add(RunningSplashEvent());
  }

  final AppRepo _appRepo;
  final NotificationBloc _notifier;

  void _splashInit(SplashEvent event, Emitter<SplashState> emit) {
    emit(SplashInit());
  }

  void _splashRunning(SplashEvent event, Emitter<SplashState> emit) async {
    emit(SplashRunning());
    await _appRepo.open();
    await _appRepo.migrate();
    _notifier
        .add(InitializeNotificationEvent(askAgain: false, callback: () {}));
    await Future.delayed(const Duration(seconds: 1));
    add(CompleteSplashEvent());
  }

  void _splashComplete(SplashEvent event, Emitter<SplashState> emit) {
    emit(SplashComplete());
  }
}

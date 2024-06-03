/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';
import '../../app/data_repository/app_repository.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({required this.appRepo}) : super(const SplashInit()) {
    on<InitSplashEvent>(_splashInit);
    on<RunningSplashEvent>(_splashRunning);
    on<CompleteSplashEvent>(_splashComplete);

    add(RunningSplashEvent());
  }

  final AppRepo appRepo;

  void _splashInit(SplashEvent event, Emitter<SplashState> emit) {
    emit(const SplashInit());
  }

  void _splashRunning(SplashEvent event, Emitter<SplashState> emit) async {
    emit(const SplashRunning());
    await appRepo.open();
    await appRepo.migrate();
    await Future.delayed(const Duration(seconds: 1));
    add(CompleteSplashEvent());
  }

  void _splashComplete(SplashEvent event, Emitter<SplashState> emit) {
    emit(const SplashComplete());
  }
}

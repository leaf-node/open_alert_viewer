/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

enum Screens {
  none,
  alerts,
  rootSettings,
  generalSettings,
  accountSettings,
  about,
  licensing,
  licensingDetails,
  privacy
}

class Navigation {
  Navigation()
      : _streamController = StreamController(),
        ready = Completer() {
    stream = _streamController.stream;
    ready.complete();
  }

  final StreamController<(Screens, Object?)> _streamController;
  final Completer ready;
  Stream<(Screens, Object?)>? stream;

  void goTo(Screens screen, [Object? data]) {
    _streamController.add((screen, data));
  }
}

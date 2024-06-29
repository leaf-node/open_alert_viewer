/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer Authors
 *
 * SPDX-License-Identifier: MIT
 */

abstract class SplashState {
  const SplashState();
}

final class SplashInit extends SplashState {
  SplashInit();
}

final class SplashRunning extends SplashState {
  SplashRunning();
}

final class SplashComplete extends SplashState {
  SplashComplete();
}

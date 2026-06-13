import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:arrpilot/system/platform.dart';
import 'package:window_manager/window_manager.dart';

// ignore: always_use_package_imports
import '../window_manager.dart';

bool isPlatformSupported() => ArrPilotPlatform.isDesktop;
ArrPilotWindowManager getWindowManager() {
  switch (ArrPilotPlatform.current) {
    case ArrPilotPlatform.LINUX:
    case ArrPilotPlatform.MACOS:
    case ArrPilotPlatform.WINDOWS:
      return IO();
    default:
      throw UnsupportedError('ArrPilotWindowManager unsupported');
  }
}

class IO implements ArrPilotWindowManager {
  @override
  Future<void> initialize() async {
    if (kDebugMode) return;

    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await setWindowSize();
      await setWindowTitle('ArrPilot');
      windowManager.show();
    });
  }

  @override
  Future<void> setWindowTitle(String title) async {
    return windowManager
        .waitUntilReadyToShow()
        .then((_) async => await windowManager.setTitle(title));
  }

  Future<void> setWindowSize() async {
    const min = ArrPilotWindowManager.MINIMUM_WINDOW_SIZE;
    const init = ArrPilotWindowManager.INITIAL_WINDOW_SIZE;
    const minSize = Size(min, min);
    const initSize = Size(init, init);

    await windowManager.setSize(initSize);
    // Currently broken on Linux
    if (!ArrPilotPlatform.isLinux) {
      await windowManager.setMinimumSize(minSize);
    }
  }
}

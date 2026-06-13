import 'package:flutter/foundation.dart';

enum ArrPilotPlatform {
  ANDROID,
  IOS,
  LINUX,
  MACOS,
  WEB,
  WINDOWS;

  static bool get isAndroid {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  }

  static bool get isIOS {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;
  }

  static bool get isLinux {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.linux;
  }

  static bool get isMacOS {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.macOS;
  }

  static bool get isWeb {
    return kIsWeb;
  }

  static bool get isWindows {
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.windows;
  }

  static bool get isMobile => isAndroid || isIOS;
  static bool get isDesktop => isLinux || isMacOS || isWindows;

  static ArrPilotPlatform get current {
    if (isWeb) return ArrPilotPlatform.WEB;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return ArrPilotPlatform.ANDROID;
      case TargetPlatform.iOS:
        return ArrPilotPlatform.IOS;
      case TargetPlatform.linux:
        return ArrPilotPlatform.LINUX;
      case TargetPlatform.macOS:
        return ArrPilotPlatform.MACOS;
      case TargetPlatform.windows:
        return ArrPilotPlatform.WINDOWS;
      default:
        throw UnsupportedError('Platform is not supported');
    }
  }

  String get name {
    switch (this) {
      case ArrPilotPlatform.ANDROID:
        return 'Android';
      case ArrPilotPlatform.IOS:
        return 'iOS';
      case ArrPilotPlatform.LINUX:
        return 'Linux';
      case ArrPilotPlatform.MACOS:
        return 'macOS';
      case ArrPilotPlatform.WEB:
        return 'Web';
      case ArrPilotPlatform.WINDOWS:
        return 'Windows';
    }
  }
}

import 'package:flutter/material.dart';
import 'package:arrpilot/system/environment.dart';
import 'package:arrpilot/vendor.dart';
import 'package:arrpilot/widgets/ui.dart';

const FLAVOR_EDGE = 'edge';
const FLAVOR_BETA = 'beta';
const FLAVOR_STABLE = 'stable';

enum ArrPilotFlavor {
  EDGE(FLAVOR_EDGE),
  BETA(FLAVOR_BETA),
  STABLE(FLAVOR_STABLE);

  final String key;
  const ArrPilotFlavor(this.key);

  static ArrPilotFlavor fromKey(String key) {
    switch (key) {
      case FLAVOR_EDGE:
        return ArrPilotFlavor.EDGE;
      case FLAVOR_BETA:
        return ArrPilotFlavor.BETA;
      case FLAVOR_STABLE:
        return ArrPilotFlavor.STABLE;
    }
    throw Exception('Invalid ArrPilotFlavor');
  }

  static ArrPilotFlavor get current => ArrPilotFlavor.fromKey(ArrPilotEnvironment.flavor);

  static bool get isEdge => current == ArrPilotFlavor.EDGE;
  static bool get isBeta => current == ArrPilotFlavor.BETA;
  static bool get isStable => current == ArrPilotFlavor.STABLE;
}

extension ArrPilotFlavorExtension on ArrPilotFlavor {
  bool isRunningFlavor() {
    ArrPilotFlavor flavor = ArrPilotFlavor.current;
    if (flavor == this) return true;

    switch (this) {
      case ArrPilotFlavor.EDGE:
        return false;
      case ArrPilotFlavor.BETA:
        return flavor == ArrPilotFlavor.EDGE;
      case ArrPilotFlavor.STABLE:
        return true;
    }
  }

  String get downloadLink {
    String base = 'https://github.com/YOUR_USERNAME/arrpilot/releases/#latest';
    switch (this) {
      case ArrPilotFlavor.EDGE:
        return '$base/${this.key}/';
      case ArrPilotFlavor.BETA:
        return '$base/${this.key}/';
      case ArrPilotFlavor.STABLE:
        return '$base/${this.key}/';
    }
  }

  String get name {
    switch (this) {
      case ArrPilotFlavor.EDGE:
        return 'arrpilot.Edge'.tr();
      case ArrPilotFlavor.BETA:
        return 'arrpilot.Beta'.tr();
      case ArrPilotFlavor.STABLE:
        return 'arrpilot.Stable'.tr();
    }
  }

  Color get color {
    switch (this) {
      case ArrPilotFlavor.EDGE:
        return ArrPilotColours.red;
      case ArrPilotFlavor.BETA:
        return ArrPilotColours.blue;
      case ArrPilotFlavor.STABLE:
        return ArrPilotColours.accent;
    }
  }
}

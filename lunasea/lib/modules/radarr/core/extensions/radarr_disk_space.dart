import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/int/bytes.dart';
import 'package:arrpilot/modules/radarr.dart';

extension ArrPilotRadarrDiskSpaceExtension on RadarrDiskSpace {
  String? get lunaPath {
    if (this.path != null && this.path!.isNotEmpty) return this.path;
    return ArrPilotUI.TEXT_EMDASH;
  }

  String get lunaSpace {
    String numerator = this.freeSpace.asBytes();
    String denumerator = this.totalSpace.asBytes();
    return '$numerator / $denumerator\n';
  }

  int get lunaPercentage {
    int? _percentNumerator = this.freeSpace;
    int? _percentDenominator = this.totalSpace;
    if (_percentNumerator != null &&
        _percentDenominator != null &&
        _percentDenominator != 0) {
      int _val = ((_percentNumerator / _percentDenominator) * 100).round();
      return (_val - 100).abs();
    }
    return 0;
  }

  String get lunaPercentageString => '$lunaPercentage%';

  Color get lunaColor {
    int percentage = this.lunaPercentage;
    if (percentage >= 90) return ArrPilotColours.red;
    if (percentage >= 80) return ArrPilotColours.orange;
    return ArrPilotColours.accent;
  }
}

import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';

extension ArrPilotRadarrHealthCheckTypeExtension on RadarrHealthCheckType? {
  Color get lunaColour {
    switch (this) {
      case RadarrHealthCheckType.NOTICE:
        return ArrPilotColours.blue;
      case RadarrHealthCheckType.WARNING:
        return ArrPilotColours.orange;
      case RadarrHealthCheckType.ERROR:
        return ArrPilotColours.red;
      default:
        return Colors.white;
    }
  }
}

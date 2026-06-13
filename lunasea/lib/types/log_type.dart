import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/system/flavor.dart';

part 'log_type.g.dart';

const TYPE_DEBUG = 'debug';
const TYPE_WARNING = 'warning';
const TYPE_ERROR = 'error';
const TYPE_CRITICAL = 'critical';

@HiveType(typeId: 24, adapterName: 'ArrPilotLogTypeAdapter')
enum ArrPilotLogType {
  @HiveField(0)
  WARNING(TYPE_WARNING),
  @HiveField(1)
  ERROR(TYPE_ERROR),
  @HiveField(2)
  CRITICAL(TYPE_CRITICAL),
  @HiveField(3)
  DEBUG(TYPE_DEBUG);

  final String key;
  const ArrPilotLogType(this.key);

  String get description => 'settings.ViewTypeLogs'.tr(args: [title]);

  bool get enabled {
    switch (this) {
      case ArrPilotLogType.DEBUG:
        return ArrPilotFlavor.BETA.isRunningFlavor();
      default:
        return true;
    }
  }

  String get title {
    switch (this) {
      case ArrPilotLogType.WARNING:
        return 'arrpilot.Warning'.tr();
      case ArrPilotLogType.ERROR:
        return 'arrpilot.Error'.tr();
      case ArrPilotLogType.CRITICAL:
        return 'arrpilot.Critical'.tr();
      case ArrPilotLogType.DEBUG:
        return 'arrpilot.Debug'.tr();
    }
  }

  IconData get icon {
    switch (this) {
      case ArrPilotLogType.WARNING:
        return ArrPilotIcons.WARNING;
      case ArrPilotLogType.ERROR:
        return ArrPilotIcons.ERROR;
      case ArrPilotLogType.CRITICAL:
        return ArrPilotIcons.CRITICAL;
      case ArrPilotLogType.DEBUG:
        return ArrPilotIcons.DEBUG;
    }
  }

  Color get color {
    switch (this) {
      case ArrPilotLogType.WARNING:
        return ArrPilotColours.orange;
      case ArrPilotLogType.ERROR:
        return ArrPilotColours.red;
      case ArrPilotLogType.CRITICAL:
        return ArrPilotColours.accent;
      case ArrPilotLogType.DEBUG:
        return ArrPilotColours.blueGrey;
    }
  }

  static ArrPilotLogType? fromKey(String key) {
    switch (key) {
      case TYPE_WARNING:
        return ArrPilotLogType.WARNING;
      case TYPE_ERROR:
        return ArrPilotLogType.ERROR;
      case TYPE_CRITICAL:
        return ArrPilotLogType.CRITICAL;
      case TYPE_DEBUG:
        return ArrPilotLogType.DEBUG;
    }
    return null;
  }
}

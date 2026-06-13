import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/sonarr.dart';

extension ArrPilotSonarrSeriesMonitorTypeExtension on SonarrSeriesMonitorType {
  String get lunaName {
    switch (this) {
      case SonarrSeriesMonitorType.ALL:
        return 'All Episodes';
      case SonarrSeriesMonitorType.FUTURE:
        return 'Future Episodes';
      case SonarrSeriesMonitorType.MISSING:
        return 'Missing Episodes';
      case SonarrSeriesMonitorType.EXISTING:
        return 'Existing Episodes';
      case SonarrSeriesMonitorType.PILOT:
        return 'Pilot Episode';
      case SonarrSeriesMonitorType.FIRST_SEASON:
        return 'Only First Season';
      case SonarrSeriesMonitorType.LATEST_SEASON:
        return 'Only Latest Season';
      case SonarrSeriesMonitorType.NONE:
        return 'None';
      default:
        return 'arrpilot.Unknown'.tr();
    }
  }
}

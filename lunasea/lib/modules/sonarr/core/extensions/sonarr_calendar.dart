import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/sonarr.dart';

extension SonarrCalendarExtension on SonarrCalendar {
  String get lunaAirTime {
    if (this.airDateUtc != null)
      return ArrPilotDatabase.USE_24_HOUR_TIME.read()
          ? DateFormat.Hm().format(this.airDateUtc!.toLocal())
          : DateFormat('hh:mm\na').format(this.airDateUtc!.toLocal());
    return ArrPilotUI.TEXT_EMDASH;
  }

  bool get lunaHasAired {
    if (this.airDateUtc != null)
      return DateTime.now().isAfter(this.airDateUtc!.toLocal());
    return false;
  }
}

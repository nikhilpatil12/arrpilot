import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/sonarr.dart';

extension ArrPilotSonarrProtocolExtension on SonarrProtocol {
  Color lunaProtocolColor({
    SonarrRelease? release,
  }) {
    if (this == SonarrProtocol.USENET) return ArrPilotColours.accent;
    if (release == null) return ArrPilotColours.blue;

    int seeders = release.seeders ?? 0;
    if (seeders > 10) return ArrPilotColours.blue;
    if (seeders > 0) return ArrPilotColours.orange;
    return ArrPilotColours.red;
  }

  String lunaReadable() {
    switch (this) {
      case SonarrProtocol.USENET:
        return 'sonarr.Usenet'.tr();
      case SonarrProtocol.TORRENT:
        return 'sonarr.Torrent'.tr();
    }
  }
}

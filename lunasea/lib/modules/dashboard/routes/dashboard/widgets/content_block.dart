import 'package:flutter/material.dart';

import 'package:arrpilot/database/models/profile.dart';
import 'package:arrpilot/widgets/ui.dart';
import 'package:arrpilot/modules/dashboard/core/api/data/abstract.dart';
import 'package:arrpilot/modules/dashboard/core/api/data/lidarr.dart';
import 'package:arrpilot/modules/dashboard/core/api/data/radarr.dart';
import 'package:arrpilot/modules/dashboard/core/api/data/sonarr.dart';

class ContentBlock extends StatelessWidget {
  final CalendarData data;
  const ContentBlock(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headers = getHeaders();
    return ArrPilotBlock(
      title: data.title,
      body: data.body,
      posterHeaders: headers,
      backgroundHeaders: headers,
      posterUrl: data.posterUrl(context),
      posterPlaceholderIcon: ArrPilotIcons.VIDEO_CAM,
      backgroundUrl: data.backgroundUrl(context),
      trailing: data.trailing(context),
      onTap: () async => data.enterContent(context),
    );
  }

  Map getHeaders() {
    switch (data.runtimeType) {
      case CalendarLidarrData:
        return ArrPilotProfile.current.lidarrHeaders;
      case CalendarRadarrData:
        return ArrPilotProfile.current.radarrHeaders;
      case CalendarSonarrData:
        return ArrPilotProfile.current.sonarrHeaders;
      default:
        return const {};
    }
  }
}

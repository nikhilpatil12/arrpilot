import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/tautulli.dart';

class TautulliActivityDetailsPlayerBlock extends StatelessWidget {
  final TautulliSession session;

  const TautulliActivityDetailsPlayerBlock({
    Key? key,
    required this.session,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotTableCard(
      content: [
        ArrPilotTableContent(
            title: 'tautulli.Location'.tr(), body: session.lunaIPAddress),
        ArrPilotTableContent(
            title: 'tautulli.Platform'.tr(), body: session.lunaPlatform),
        ArrPilotTableContent(
            title: 'tautulli.Product'.tr(), body: session.lunaProduct),
        ArrPilotTableContent(
            title: 'tautulli.Player'.tr(), body: session.lunaPlayer),
        ArrPilotTableContent(
            title: 'tautulli.Quality'.tr(), body: session.lunaQuality),
      ],
    );
  }
}

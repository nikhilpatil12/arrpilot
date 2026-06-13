import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/tautulli.dart';

class TautulliActivityDetailsMetadataBlock extends StatelessWidget {
  final TautulliSession session;

  const TautulliActivityDetailsMetadataBlock({
    Key? key,
    required this.session,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotTableCard(
      content: [
        ArrPilotTableContent(
            title: 'tautulli.Title'.tr(), body: session.lunaFullTitle),
        if (session.year != null)
          ArrPilotTableContent(title: 'tautulli.Year'.tr(), body: session.lunaYear),
        ArrPilotTableContent(
            title: 'tautulli.Duration'.tr(), body: session.lunaDuration),
        ArrPilotTableContent(title: 'tautulli.ETA'.tr(), body: session.lunaETA),
        ArrPilotTableContent(
            title: 'tautulli.Library'.tr(), body: session.lunaLibraryName),
        ArrPilotTableContent(
            title: 'tautulli.User'.tr(), body: session.lunaFriendlyName),
      ],
    );
  }
}

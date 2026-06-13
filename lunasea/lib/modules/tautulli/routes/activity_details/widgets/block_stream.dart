import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/tautulli.dart';

class TautulliActivityDetailsStreamBlock extends StatelessWidget {
  final TautulliSession session;

  const TautulliActivityDetailsStreamBlock({
    Key? key,
    required this.session,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotTableCard(
      content: [
        ArrPilotTableContent(
          title: 'tautulli.Bandwidth'.tr(),
          body: session.lunaBandwidth,
        ),
        ArrPilotTableContent(
          title: 'tautulli.Stream'.tr(),
          body: session.formattedStream(),
        ),
        ArrPilotTableContent(
          title: 'tautulli.Container'.tr(),
          body: session.formattedContainer(),
        ),
        if (session.hasVideo())
          ArrPilotTableContent(
            title: 'tautulli.Video'.tr(),
            body: session.formattedVideo(),
          ),
        if (session.hasAudio())
          ArrPilotTableContent(
            title: 'tautulli.Audio'.tr(),
            body: session.formattedAudio(),
          ),
        if (session.hasSubtitles())
          ArrPilotTableContent(
            title: 'tautulli.Subtitle'.tr(),
            body: session.formattedSubtitles(),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/tautulli.dart';

class TautulliCheckForUpdatesPMSTile extends StatelessWidget {
  final TautulliPMSUpdate update;

  const TautulliCheckForUpdatesPMSTile({
    Key? key,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      title: 'Plex Media Server',
      body: _subtitle(),
      trailing: _trailing(),
    );
  }

  Widget _trailing() {
    return Column(
      children: [
        ArrPilotIconButton(
          icon: ArrPilotIcons.PLEX,
          iconSize: ArrPilotUI.ICON_SIZE - 2.0,
          color: ArrPilotColours().byListIndex(0),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  List<TextSpan> _subtitle() {
    return [
      if (!(update.updateAvailable ?? false))
        const TextSpan(
          text: 'No Updates Available',
          style: TextStyle(
            color: ArrPilotColours.accent,
            fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
          ),
        ),
      if (!(update.updateAvailable ?? false))
        TextSpan(
            text: 'Current Version: ${update.version ?? ArrPilotUI.TEXT_EMDASH}'),
      if (update.updateAvailable ?? false)
        const TextSpan(
          text: 'Update Available',
          style: TextStyle(
            color: ArrPilotColours.orange,
            fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
          ),
        ),
      if (update.updateAvailable ?? false)
        TextSpan(
            text: 'Latest Version: ${update.version ?? ArrPilotUI.TEXT_EMDASH}'),
    ];
  }
}

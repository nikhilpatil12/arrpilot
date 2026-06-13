import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/datetime.dart';
import 'package:arrpilot/modules/tautulli.dart';

class TautulliLogsNewsletterLogTile extends StatelessWidget {
  final TautulliNewsletterLogRecord newsletter;

  const TautulliLogsNewsletterLogTile({
    Key? key,
    required this.newsletter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      title: newsletter.agentName,
      body: _body(),
      trailing: _trailing(),
    );
  }

  List<TextSpan> _body() {
    return [
      TextSpan(text: newsletter.notifyAction),
      TextSpan(text: newsletter.subjectText),
      TextSpan(text: newsletter.bodyText),
      TextSpan(
        text: newsletter.timestamp!.asDateTime(),
        style: const TextStyle(
          color: ArrPilotColours.accent,
          fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
        ),
      ),
    ];
  }

  Widget _trailing() => Column(
        children: [
          ArrPilotIconButton(
            icon: newsletter.success!
                ? Icons.check_circle_rounded
                : Icons.cancel_rounded,
            color: newsletter.success! ? ArrPilotColours.white : ArrPilotColours.red,
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
      );
}

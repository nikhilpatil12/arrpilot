import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/datetime.dart';
import 'package:arrpilot/modules/tautulli.dart';

class TautulliLogsNotificationLogTile extends StatelessWidget {
  final TautulliNotificationLogRecord notification;

  const TautulliLogsNotificationLogTile({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      title: notification.agentName,
      body: _body(),
      trailing: _trailing(),
    );
  }

  List<TextSpan> _body() {
    return [
      TextSpan(text: notification.notifyAction),
      TextSpan(text: notification.subjectText),
      TextSpan(text: notification.bodyText),
      TextSpan(
        text: notification.timestamp!.asDateTime(),
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
            icon: notification.success!
                ? Icons.check_circle_rounded
                : Icons.cancel_rounded,
            color: notification.success! ? ArrPilotColours.white : ArrPilotColours.red,
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
      );
}

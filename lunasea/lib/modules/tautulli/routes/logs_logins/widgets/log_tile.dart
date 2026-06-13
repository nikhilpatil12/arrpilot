import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/datetime.dart';
import 'package:arrpilot/modules/tautulli.dart';

class TautulliLogsLoginsLogTile extends StatelessWidget {
  final TautulliUserLoginRecord login;

  const TautulliLogsLoginsLogTile({
    Key? key,
    required this.login,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      title: login.friendlyName,
      body: _body(),
      trailing: _trailing(),
    );
  }

  List<TextSpan> _body() {
    return [
      TextSpan(text: '${login.ipAddress}\n'),
      TextSpan(text: '${login.os}\n'),
      TextSpan(text: '${login.host}\n'),
      TextSpan(
        text: login.timestamp!.asDateTime(),
        style: const TextStyle(
          color: ArrPilotColours.accent,
          fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
        ),
      ),
    ];
  }

  Widget _trailing() {
    return Column(
      children: [
        ArrPilotIconButton(
          icon: login.success!
              ? Icons.check_circle_rounded
              : Icons.cancel_rounded,
          color: login.success! ? Colors.white : ArrPilotColours.red,
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}

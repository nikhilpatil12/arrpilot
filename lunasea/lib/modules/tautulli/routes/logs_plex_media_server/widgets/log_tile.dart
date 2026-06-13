import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/tautulli.dart';

class TautulliLogsPlexMediaServerLogTile extends StatelessWidget {
  final TautulliPlexLog log;

  const TautulliLogsPlexMediaServerLogTile({
    Key? key,
    required this.log,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotExpandableListTile(
      title: log.message!.trim(),
      collapsedSubtitles: [
        _subtitle1(),
        _subtitle2(),
      ],
      expandedTableContent: _tableContent(),
    );
  }

  TextSpan _subtitle1() => TextSpan(text: log.timestamp ?? ArrPilotUI.TEXT_EMDASH);

  TextSpan _subtitle2() {
    return TextSpan(
      text: log.level ?? ArrPilotUI.TEXT_EMDASH,
      style: const TextStyle(
        color: ArrPilotColours.accent,
        fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
      ),
    );
  }

  List<ArrPilotTableContent> _tableContent() {
    return [
      ArrPilotTableContent(title: 'level', body: log.level),
      ArrPilotTableContent(title: 'timestamp', body: log.timestamp),
    ];
  }
}

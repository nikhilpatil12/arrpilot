import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/database/models/log.dart';
import 'package:arrpilot/extensions/datetime.dart';

class SettingsSystemLogTile extends StatelessWidget {
  final ArrPilotLog log;

  const SettingsSystemLogTile({
    Key? key,
    required this.log,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dateTime =
        DateTime.fromMillisecondsSinceEpoch(log.timestamp).asDateTime();
    return ArrPilotExpandableListTile(
      title: log.message,
      collapsedSubtitles: [
        TextSpan(text: dateTime),
        TextSpan(
          text: log.type.title.toUpperCase(),
          style: TextStyle(
            color: log.type.color,
            fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
          ),
        ),
      ],
      expandedHighlightedNodes: [
        ArrPilotHighlightedNode(
          text: log.type.title.toUpperCase(),
          backgroundColor: log.type.color,
        ),
        ArrPilotHighlightedNode(
          text: dateTime,
          backgroundColor: ArrPilotColours.blueGrey,
        ),
      ],
      expandedTableContent: [
        if (log.className != null && log.className!.isNotEmpty)
          ArrPilotTableContent(title: 'settings.Class'.tr(), body: log.className),
        if (log.methodName != null && log.methodName!.isNotEmpty)
          ArrPilotTableContent(title: 'settings.Method'.tr(), body: log.methodName),
        if (log.error != null && log.error!.isNotEmpty)
          ArrPilotTableContent(title: 'settings.Exception'.tr(), body: log.error),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/string/links.dart';
import 'package:arrpilot/modules/radarr.dart';

class RadarrHealthCheckTile extends StatelessWidget {
  final RadarrHealthCheck healthCheck;

  const RadarrHealthCheckTile({
    Key? key,
    required this.healthCheck,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotExpandableListTile(
      title: healthCheck.message!,
      collapsedSubtitles: [
        subtitle1(),
        subtitle2(),
      ],
      expandedTableContent: expandedTable(),
      expandedHighlightedNodes: highlightedNodes(),
      onLongPress: healthCheck.wikiUrl!.openLink,
    );
  }

  TextSpan subtitle1() {
    return TextSpan(text: healthCheck.source);
  }

  TextSpan subtitle2() {
    return TextSpan(
      text: healthCheck.type!.readable,
      style: TextStyle(
        color: healthCheck.type.lunaColour,
        fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
        fontSize: ArrPilotUI.FONT_SIZE_H3,
      ),
    );
  }

  List<ArrPilotHighlightedNode> highlightedNodes() {
    return [
      ArrPilotHighlightedNode(
        text: healthCheck.type!.readable!,
        backgroundColor: healthCheck.type.lunaColour,
      ),
    ];
  }

  List<ArrPilotTableContent> expandedTable() {
    return [
      ArrPilotTableContent(title: 'Source', body: healthCheck.source),
    ];
  }
}

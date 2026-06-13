import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/datetime.dart';
import 'package:arrpilot/extensions/string/string.dart';
import 'package:arrpilot/modules/radarr.dart';
import 'package:arrpilot/router/routes/radarr.dart';

class RadarrHistoryTile extends StatelessWidget {
  final RadarrHistoryRecord history;
  final bool movieHistory;
  final String title;

  /// If [movieHistory] is false (default), you must supply a title or else a dash will be shown.
  const RadarrHistoryTile({
    Key? key,
    required this.history,
    this.movieHistory = false,
    this.title = ArrPilotUI.TEXT_EMDASH,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotExpandableListTile(
      title: movieHistory ? history.sourceTitle! : title,
      collapsedSubtitles: [
        TextSpan(
          text: [
            history.date?.asAge() ?? ArrPilotUI.TEXT_EMDASH,
            history.date?.asDateTime() ?? ArrPilotUI.TEXT_EMDASH,
          ].join(ArrPilotUI.TEXT_BULLET.pad()),
        ),
        TextSpan(
          text: history.eventType?.lunaReadable(history) ?? ArrPilotUI.TEXT_EMDASH,
          style: TextStyle(
            color: history.eventType?.lunaColour ?? ArrPilotColours.blueGrey,
            fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
          ),
        ),
      ],
      expandedHighlightedNodes: [
        ArrPilotHighlightedNode(
          text: history.eventType!.readable!,
          backgroundColor: history.eventType!.lunaColour,
        ),
        ...history.customFormats!
            .map<ArrPilotHighlightedNode>((format) => ArrPilotHighlightedNode(
                  text: format.name!,
                  backgroundColor: ArrPilotColours.blueGrey,
                )),
      ],
      expandedTableContent: history.eventType?.lunaTableContent(
            history,
            movieHistory: movieHistory,
          ) ??
          [],
      onLongPress: movieHistory
          ? null
          : () => RadarrRoutes.MOVIE.go(params: {
                'movie': history.movieId!.toString(),
              }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/datetime.dart';
import 'package:arrpilot/extensions/duration/timestamp.dart';
import 'package:arrpilot/modules/tautulli.dart';
import 'package:arrpilot/router/routes/tautulli.dart';

class TautulliStatisticsMediaTile extends StatefulWidget {
  final Map<String, dynamic> data;
  final TautulliMediaType mediaType;

  const TautulliStatisticsMediaTile({
    Key? key,
    required this.data,
    required this.mediaType,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliStatisticsMediaTile> {
  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      title: widget.data['title'] ?? 'lunasea.Unknown'.tr(),
      body: _body(),
      onTap: _onTap,
      posterUrl: context
          .read<TautulliState>()
          .getImageURLFromPath(widget.data['thumb']),
      posterHeaders: context.watch<TautulliState>().headers,
      posterPlaceholderIcon: ArrPilotIcons.VIDEO_CAM,
      backgroundUrl:
          context.read<TautulliState>().getImageURLFromPath(widget.data['art']),
      backgroundHeaders: context.watch<TautulliState>().headers,
    );
  }

  List<TextSpan> _body() {
    return [
      TextSpan(
        text: widget.data['total_plays'].toString() +
            (widget.data['total_plays'] == 1 ? ' Play' : ' Plays'),
        style: TextStyle(
          color: context.watch<TautulliState>().statisticsType ==
                  TautulliStatsType.PLAYS
              ? ArrPilotColours.accent
              : null,
          fontWeight: context.watch<TautulliState>().statisticsType ==
                  TautulliStatsType.PLAYS
              ? ArrPilotUI.FONT_WEIGHT_BOLD
              : null,
        ),
      ),
      widget.data['total_duration'] != null
          ? TextSpan(
              text: Duration(seconds: widget.data['total_duration'])
                  .asWordsTimestamp(),
              style: TextStyle(
                color: context.watch<TautulliState>().statisticsType ==
                        TautulliStatsType.DURATION
                    ? ArrPilotColours.accent
                    : null,
                fontWeight: context.watch<TautulliState>().statisticsType ==
                        TautulliStatsType.DURATION
                    ? ArrPilotUI.FONT_WEIGHT_BOLD
                    : null,
              ),
            )
          : const TextSpan(text: ArrPilotUI.TEXT_EMDASH),
      widget.data['last_play'] != null
          ? TextSpan(
              text:
                  'Last Played ${DateTime.fromMillisecondsSinceEpoch(widget.data['last_play'] * 1000).asAge()}',
            )
          : const TextSpan(text: ArrPilotUI.TEXT_EMDASH)
    ];
  }

  void _onTap() {
    TautulliRoutes.MEDIA_DETAILS.go(params: {
      'rating_key': widget.data['rating_key'].toString(),
      'media_type': widget.mediaType.value,
    });
  }
}

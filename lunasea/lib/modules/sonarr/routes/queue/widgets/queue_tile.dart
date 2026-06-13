import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/int/bytes.dart';
import 'package:arrpilot/extensions/string/string.dart';
import 'package:arrpilot/modules/sonarr.dart';
import 'package:arrpilot/router/routes/sonarr.dart';

enum SonarrQueueTileType {
  ALL,
  EPISODE,
}

class SonarrQueueTile extends StatefulWidget {
  final SonarrQueueRecord queueRecord;
  final SonarrQueueTileType type;

  const SonarrQueueTile({
    Key? key,
    required this.queueRecord,
    required this.type,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrQueueTile> {
  @override
  Widget build(BuildContext context) {
    return ArrPilotExpandableListTile(
      title: widget.queueRecord.title!,
      collapsedSubtitles: [
        if (widget.type == SonarrQueueTileType.ALL) _subtitle1(),
        if (widget.type == SonarrQueueTileType.ALL) _subtitle2(),
        _subtitle3(),
        _subtitle4(),
      ],
      expandedTableContent: _expandedTableContent(),
      expandedHighlightedNodes: _expandedHighlightedNodes(),
      expandedTableButtons: _tableButtons(),
      collapsedTrailing: _collapsedTrailing(),
      onLongPress: _onLongPress,
    );
  }

  Future<void> _onLongPress() async {
    switch (widget.type) {
      case SonarrQueueTileType.ALL:
        SonarrRoutes.SERIES.go(params: {
          'series': widget.queueRecord.seriesId!.toString(),
        });
        break;
      case SonarrQueueTileType.EPISODE:
        SonarrRoutes.QUEUE.go();
        break;
    }
  }

  Widget _collapsedTrailing() {
    Tuple3<String, IconData, Color> _status =
        widget.queueRecord.lunaStatusParameters();
    return ArrPilotIconButton(
      icon: _status.item2,
      color: _status.item3,
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(
      text: widget.queueRecord.series!.title ?? ArrPilotUI.TEXT_EMDASH,
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      children: [
        TextSpan(
            text: widget.queueRecord.episode?.lunaSeasonEpisode() ??
                ArrPilotUI.TEXT_EMDASH),
        const TextSpan(text: ': '),
        TextSpan(
            text: widget.queueRecord.episode!.title ?? ArrPilotUI.TEXT_EMDASH,
            style: const TextStyle(fontStyle: FontStyle.italic)),
      ],
    );
  }

  TextSpan _subtitle3() {
    return TextSpan(
      children: [
        TextSpan(
          text: widget.queueRecord.quality?.quality?.name ?? ArrPilotUI.TEXT_EMDASH,
        ),
        TextSpan(text: ArrPilotUI.TEXT_BULLET.pad()),
        if (widget.queueRecord.language != null)
          TextSpan(
            text: widget.queueRecord.language?.name ?? ArrPilotUI.TEXT_EMDASH,
          ),
        if (widget.queueRecord.language != null)
          TextSpan(text: ArrPilotUI.TEXT_BULLET.pad()),
        TextSpan(
          text: widget.queueRecord.lunaTimeLeft(),
        ),
      ],
    );
  }

  TextSpan _subtitle4() {
    Tuple3<String, IconData, Color> _params =
        widget.queueRecord.lunaStatusParameters(canBeWhite: false);
    return TextSpan(
      style: TextStyle(
        color: _params.item3,
        fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
      ),
      children: [
        TextSpan(text: widget.queueRecord.lunaPercentage()),
        TextSpan(text: ArrPilotUI.TEXT_EMDASH.pad()),
        TextSpan(text: _params.item1),
      ],
    );
  }

  List<ArrPilotHighlightedNode> _expandedHighlightedNodes() {
    Tuple3<String, IconData, Color> _status =
        widget.queueRecord.lunaStatusParameters(canBeWhite: false);
    return [
      ArrPilotHighlightedNode(
        text: widget.queueRecord.protocol!.lunaReadable(),
        backgroundColor: widget.queueRecord.protocol!.lunaProtocolColor(),
      ),
      ArrPilotHighlightedNode(
        text: widget.queueRecord.lunaPercentage(),
        backgroundColor: _status.item3,
      ),
      ArrPilotHighlightedNode(
        text: widget.queueRecord.status!.lunaStatus(),
        backgroundColor: _status.item3,
      ),
    ];
  }

  List<ArrPilotTableContent> _expandedTableContent() {
    return [
      if (widget.type == SonarrQueueTileType.ALL)
        ArrPilotTableContent(
          title: 'sonarr.Series'.tr(),
          body: widget.queueRecord.series?.title ?? ArrPilotUI.TEXT_EMDASH,
        ),
      if (widget.type == SonarrQueueTileType.ALL)
        ArrPilotTableContent(
          title: 'sonarr.Episode'.tr(),
          body: widget.queueRecord.episode?.lunaSeasonEpisode() ??
              ArrPilotUI.TEXT_EMDASH,
        ),
      if (widget.type == SonarrQueueTileType.ALL)
        ArrPilotTableContent(
          title: 'sonarr.Title'.tr(),
          body: widget.queueRecord.episode?.title ?? ArrPilotUI.TEXT_EMDASH,
        ),
      if (widget.type == SonarrQueueTileType.ALL)
        ArrPilotTableContent(title: '', body: ''),
      ArrPilotTableContent(
        title: 'sonarr.Quality'.tr(),
        body: widget.queueRecord.quality?.quality?.name ?? ArrPilotUI.TEXT_EMDASH,
      ),
      if (widget.queueRecord.language != null)
        ArrPilotTableContent(
          title: 'sonarr.Language'.tr(),
          body: widget.queueRecord.language?.name ?? ArrPilotUI.TEXT_EMDASH,
        ),
      ArrPilotTableContent(
        title: 'sonarr.Client'.tr(),
        body: widget.queueRecord.downloadClient ?? ArrPilotUI.TEXT_EMDASH,
      ),
      ArrPilotTableContent(
        title: 'sonarr.Size'.tr(),
        body: widget.queueRecord.size?.floor().asBytes() ?? ArrPilotUI.TEXT_EMDASH,
      ),
      ArrPilotTableContent(
        title: 'sonarr.TimeLeft'.tr(),
        body: widget.queueRecord.lunaTimeLeft(),
      ),
    ];
  }

  List<ArrPilotButton> _tableButtons() {
    return [
      if ((widget.queueRecord.statusMessages ?? []).isNotEmpty)
        ArrPilotButton.text(
          icon: Icons.messenger_outline_rounded,
          color: ArrPilotColours.orange,
          text: 'sonarr.Messages'.tr(),
          onTap: () async {
            SonarrDialogs().showQueueStatusMessages(
              context,
              widget.queueRecord.statusMessages!,
            );
          },
        ),
      // if (widget.queueRecord.status == SonarrQueueStatus.COMPLETED &&
      //     widget.queueRecord?.trackedDownloadStatus ==
      //         SonarrTrackedDownloadStatus.WARNING)
      //   ArrPilotButton.text(
      //     icon: Icons.download_done_rounded,
      //     text: 'sonarr.Import'.tr(),
      //     onTap: () async {},
      //   ),
      ArrPilotButton.text(
        icon: Icons.delete_rounded,
        color: ArrPilotColours.red,
        text: 'arrpilot.Remove'.tr(),
        onTap: () async {
          bool result = await SonarrDialogs().removeFromQueue(context);
          if (result) {
            SonarrAPIController()
                .removeFromQueue(
              context: context,
              queueRecord: widget.queueRecord,
            )
                .then((_) {
              switch (widget.type) {
                case SonarrQueueTileType.ALL:
                  context.read<SonarrQueueState>().fetchQueue(
                        context,
                        hardCheck: true,
                      );
                  break;
                case SonarrQueueTileType.EPISODE:
                  context.read<SonarrSeasonDetailsState>().fetchState(
                        context,
                        shouldFetchEpisodes: false,
                        shouldFetchFiles: false,
                      );
                  break;
              }
            });
          }
        },
      ),
    ];
  }
}

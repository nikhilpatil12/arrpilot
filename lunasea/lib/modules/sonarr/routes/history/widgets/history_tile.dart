import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/datetime.dart';
import 'package:arrpilot/extensions/string/string.dart';
import 'package:arrpilot/modules/sonarr.dart';
import 'package:arrpilot/router/routes/sonarr.dart';

enum SonarrHistoryTileType {
  ALL,
  SERIES,
  SEASON,
  EPISODE,
}

class SonarrHistoryTile extends StatelessWidget {
  final SonarrHistoryRecord history;
  final SonarrHistoryTileType type;
  final SonarrSeries? series;
  final SonarrEpisode? episode;

  const SonarrHistoryTile({
    Key? key,
    required this.history,
    required this.type,
    this.series,
    this.episode,
  }) : super(key: key);

  bool _hasEpisodeInfo() {
    if (history.episode != null || episode != null) return true;
    return false;
  }

  bool _hasLongPressAction() {
    switch (type) {
      case SonarrHistoryTileType.ALL:
        return true;
      case SonarrHistoryTileType.SERIES:
        return _hasEpisodeInfo();
      case SonarrHistoryTileType.SEASON:
      case SonarrHistoryTileType.EPISODE:
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _isThreeLine =
        _hasEpisodeInfo() && type != SonarrHistoryTileType.EPISODE;
    return ArrPilotExpandableListTile(
      title: type != SonarrHistoryTileType.ALL
          ? history.sourceTitle!
          : series?.title ?? ArrPilotUI.TEXT_EMDASH,
      collapsedSubtitles: [
        if (_isThreeLine) _subtitle1(),
        _subtitle2(),
        _subtitle3(),
      ],
      expandedHighlightedNodes: [
        ArrPilotHighlightedNode(
          text: history.eventType?.readable ?? ArrPilotUI.TEXT_EMDASH,
          backgroundColor: history.eventType!.lunaColour(),
        ),
        if (history.lunaHasPreferredWordScore())
          ArrPilotHighlightedNode(
            text: history.lunaPreferredWordScore(),
            backgroundColor: ArrPilotColours.purple,
          ),
        if (history.episode?.seasonNumber != null)
          ArrPilotHighlightedNode(
            text: 'sonarr.SeasonNumber'.tr(
              args: [history.episode!.seasonNumber.toString()],
            ),
            backgroundColor: ArrPilotColours.blueGrey,
          ),
        if (episode?.seasonNumber != null)
          ArrPilotHighlightedNode(
            text: 'sonarr.SeasonNumber'.tr(
              args: [episode?.seasonNumber?.toString() ?? ArrPilotUI.TEXT_EMDASH],
            ),
            backgroundColor: ArrPilotColours.blueGrey,
          ),
        if (history.episode?.episodeNumber != null)
          ArrPilotHighlightedNode(
            text: 'sonarr.EpisodeNumber'.tr(
              args: [history.episode!.episodeNumber.toString()],
            ),
            backgroundColor: ArrPilotColours.blueGrey,
          ),
        if (episode?.episodeNumber != null)
          ArrPilotHighlightedNode(
            text: 'sonarr.EpisodeNumber'.tr(
              args: [episode?.episodeNumber?.toString() ?? ArrPilotUI.TEXT_EMDASH],
            ),
            backgroundColor: ArrPilotColours.blueGrey,
          ),
      ],
      expandedTableContent: history.eventType?.lunaTableContent(
            history: history,
            showSourceTitle: type != SonarrHistoryTileType.ALL,
          ) ??
          [],
      onLongPress:
          _hasLongPressAction() ? () async => _onLongPress(context) : null,
    );
  }

  Future<void> _onLongPress(BuildContext context) async {
    switch (type) {
      case SonarrHistoryTileType.ALL:
        final id = history.series?.id ?? series?.id ?? -1;
        return SonarrRoutes.SERIES.go(params: {
          'series': id.toString(),
        });
      case SonarrHistoryTileType.SERIES:
        if (_hasEpisodeInfo()) {
          final seriesId =
              history.seriesId ?? history.series?.id ?? series!.id ?? -1;
          final seasonNum =
              history.episode?.seasonNumber ?? episode?.seasonNumber ?? -1;
          return SonarrRoutes.SERIES_SEASON.go(params: {
            'series': seriesId.toString(),
            'season': seasonNum.toString(),
          });
        }
        break;
      default:
        break;
    }
  }

  TextSpan _subtitle1() {
    return TextSpan(children: [
      TextSpan(
        text: history.lunaSeasonEpisode() ??
            episode?.lunaSeasonEpisode() ??
            ArrPilotUI.TEXT_EMDASH,
      ),
      const TextSpan(text: ': '),
      TextSpan(
        text: history.episode?.title ?? episode?.title ?? ArrPilotUI.TEXT_EMDASH,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
    ]);
  }

  TextSpan _subtitle2() {
    return TextSpan(
      text: [
        history.date?.asAge() ?? ArrPilotUI.TEXT_EMDASH,
        history.date?.asDateTime() ?? ArrPilotUI.TEXT_EMDASH,
      ].join(ArrPilotUI.TEXT_BULLET.pad()),
    );
  }

  TextSpan _subtitle3() {
    return TextSpan(
      text: history.eventType?.lunaReadable(history) ?? ArrPilotUI.TEXT_EMDASH,
      style: TextStyle(
        color: history.eventType?.lunaColour() ?? ArrPilotColours.blueGrey,
        fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
      ),
    );
  }
}

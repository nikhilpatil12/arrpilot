import 'package:flutter/material.dart';
import 'package:arrpilot/extensions/string/links.dart';
import 'package:arrpilot/modules/sonarr.dart';
import 'package:arrpilot/utils/links.dart';
import 'package:arrpilot/widgets/ui.dart';

class LinksSheet extends ArrPilotBottomModalSheet {
  SonarrSeries series;

  LinksSheet({
    required this.series,
  });

  @override
  Widget builder(BuildContext context) {
    final imdb = ArrPilotLinkedContent.imdb(series.imdbId);
    final tvdb =
        ArrPilotLinkedContent.theTVDB(series.tvdbId, LinkedContentType.SERIES);
    final trakt =
        ArrPilotLinkedContent.trakt(series.tvdbId, LinkedContentType.SERIES);
    final tvMaze = ArrPilotLinkedContent.tvMaze(series.tvMazeId);

    return ArrPilotListViewModal(
      children: [
        if (imdb != null)
          ArrPilotBlock(
            title: 'IMDb',
            leading: const ArrPilotIconButton(icon: ArrPilotIcons.IMDB),
            onTap: imdb.openLink,
          ),
        if (tvdb != null)
          ArrPilotBlock(
            title: 'TheTVDB',
            leading: const ArrPilotIconButton(icon: ArrPilotIcons.THETVDB),
            onTap: tvdb.openLink,
          ),
        if (trakt != null)
          ArrPilotBlock(
            title: 'Trakt',
            leading: const ArrPilotIconButton(icon: ArrPilotIcons.TRAKT),
            onTap: trakt.openLink,
          ),
        if (tvMaze != null)
          ArrPilotBlock(
            title: 'TVmaze',
            leading: const ArrPilotIconButton(icon: ArrPilotIcons.TVMAZE),
            onTap: tvMaze.openLink,
          ),
      ],
    );
  }
}

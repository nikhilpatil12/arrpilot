import 'package:flutter/material.dart';
import 'package:arrpilot/extensions/string/links.dart';
import 'package:arrpilot/modules/sonarr.dart';
import 'package:arrpilot/utils/links.dart';
import 'package:arrpilot/widgets/ui.dart';

class LinksSheet extends LunaBottomModalSheet {
  SonarrSeries series;

  LinksSheet({
    required this.series,
  });

  @override
  Widget builder(BuildContext context) {
    final imdb = LunaLinkedContent.imdb(series.imdbId);
    final tvdb =
        LunaLinkedContent.theTVDB(series.tvdbId, LinkedContentType.SERIES);
    final trakt =
        LunaLinkedContent.trakt(series.tvdbId, LinkedContentType.SERIES);
    final tvMaze = LunaLinkedContent.tvMaze(series.tvMazeId);

    return LunaListViewModal(
      children: [
        if (imdb != null)
          LunaBlock(
            title: 'IMDb',
            leading: const LunaIconButton(icon: LunaIcons.IMDB),
            onTap: imdb.openLink,
          ),
        if (tvdb != null)
          LunaBlock(
            title: 'TheTVDB',
            leading: const LunaIconButton(icon: LunaIcons.THETVDB),
            onTap: tvdb.openLink,
          ),
        if (trakt != null)
          LunaBlock(
            title: 'Trakt',
            leading: const LunaIconButton(icon: LunaIcons.TRAKT),
            onTap: trakt.openLink,
          ),
        if (tvMaze != null)
          LunaBlock(
            title: 'TVmaze',
            leading: const LunaIconButton(icon: LunaIcons.TVMAZE),
            onTap: tvMaze.openLink,
          ),
      ],
    );
  }
}

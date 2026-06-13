import 'package:flutter/material.dart';
import 'package:arrpilot/api/radarr/models.dart';
import 'package:arrpilot/extensions/string/links.dart';
import 'package:arrpilot/utils/links.dart';
import 'package:arrpilot/widgets/ui.dart';

class LinksSheet extends ArrPilotBottomModalSheet {
  RadarrMovie movie;

  LinksSheet({
    required this.movie,
  });

  @override
  Widget builder(BuildContext context) {
    final imdb = ArrPilotLinkedContent.imdb(movie.imdbId);
    final tmdb =
        ArrPilotLinkedContent.theMovieDB(movie.tmdbId, LinkedContentType.MOVIE);
    final letterboxd = ArrPilotLinkedContent.letterboxd(movie.tmdbId);
    final trakt =
        ArrPilotLinkedContent.trakt(movie.tmdbId, LinkedContentType.MOVIE);
    final youtube = ArrPilotLinkedContent.youtube(movie.youTubeTrailerId);

    return ArrPilotListViewModal(
      children: [
        if (imdb != null)
          ArrPilotBlock(
            title: 'IMDb',
            leading: const ArrPilotIconButton(icon: ArrPilotIcons.IMDB),
            onTap: imdb.openLink,
          ),
        if (letterboxd != null)
          ArrPilotBlock(
            title: 'Letterboxd',
            leading: const ArrPilotIconButton(icon: ArrPilotIcons.LETTERBOXD),
            onTap: letterboxd.openLink,
          ),
        if (tmdb != null)
          ArrPilotBlock(
            title: 'The Movie Database',
            leading: const ArrPilotIconButton(icon: ArrPilotIcons.THEMOVIEDATABASE),
            onTap: tmdb.openLink,
          ),
        if (trakt != null)
          ArrPilotBlock(
            title: 'Trakt',
            leading: const ArrPilotIconButton(icon: ArrPilotIcons.TRAKT),
            onTap: trakt.openLink,
          ),
        if (youtube != null)
          ArrPilotBlock(
            title: 'YouTube',
            leading: const ArrPilotIconButton(icon: ArrPilotIcons.YOUTUBE),
            onTap: youtube.openLink,
          ),
      ],
    );
  }
}

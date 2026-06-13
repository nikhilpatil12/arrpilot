import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';
import 'package:arrpilot/router/router.dart';
import 'package:arrpilot/router/routes/radarr.dart';

class RadarrAddMovieDetailsActionBar extends StatelessWidget {
  const RadarrAddMovieDetailsActionBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotBottomActionBar(
      actions: [
        ArrPilotActionBarCard(
          title: 'arrpilot.Options'.tr(),
          subtitle: 'radarr.StartSearchFor'.tr(),
          onTap: () async => RadarrDialogs().addMovieOptions(context),
        ),
        ArrPilotButton(
          type: ArrPilotButtonType.TEXT,
          text: 'arrpilot.Add'.tr(),
          icon: Icons.add_rounded,
          onTap: () async => _onTap(context),
          loadingState: context.watch<RadarrAddMovieDetailsState>().state,
        ),
      ],
    );
  }

  Future<void> _onTap(BuildContext context) async {
    if (context.read<RadarrAddMovieDetailsState>().canExecuteAction) {
      context.read<RadarrAddMovieDetailsState>().state =
          ArrPilotLoadingState.ACTIVE;
      await RadarrAPIHelper()
          .addMovie(
        context: context,
        movie: context.read<RadarrAddMovieDetailsState>().movie,
        rootFolder: context.read<RadarrAddMovieDetailsState>().rootFolder,
        monitored: context.read<RadarrAddMovieDetailsState>().monitored,
        qualityProfile:
            context.read<RadarrAddMovieDetailsState>().qualityProfile,
        availability: context.read<RadarrAddMovieDetailsState>().availability,
        tags: context.read<RadarrAddMovieDetailsState>().tags,
        searchForMovie: RadarrDatabase.ADD_MOVIE_SEARCH_FOR_MISSING.read(),
      )
          .then((movie) async {
        context.read<RadarrState>().fetchMovies();
        context.read<RadarrAddMovieDetailsState>().movie.id = movie!.id;
        ArrPilotRouter.router.pop();
        RadarrRoutes.MOVIE.go(params: {
          'movie': movie.id!.toString(),
        });
      }).catchError((error, stack) {
        context.read<RadarrAddMovieDetailsState>().state =
            ArrPilotLoadingState.ERROR;
      });
      context.read<RadarrAddMovieDetailsState>().state =
          ArrPilotLoadingState.INACTIVE;
    }
  }
}

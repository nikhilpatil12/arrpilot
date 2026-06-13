import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';
import 'package:arrpilot/router/router.dart';

class RadarrEditMovieActionBar extends StatelessWidget {
  const RadarrEditMovieActionBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotBottomActionBar(
      actions: [
        ArrPilotButton(
          type: ArrPilotButtonType.TEXT,
          text: 'arrpilot.Update'.tr(),
          icon: Icons.edit_rounded,
          loadingState: context.watch<RadarrMoviesEditState>().state,
          onTap: () async => _updateOnTap(context),
        )
      ],
    );
  }

  Future<void> _updateOnTap(BuildContext context) async {
    final state = context.read<RadarrMoviesEditState>();
    state.state = ArrPilotLoadingState.ACTIVE;

    if (state.canExecuteAction && state.movie != null) {
      bool moveFiles = false;
      if (state.path != state.movie?.path) {
        moveFiles = await RadarrDialogs().moveFiles();
      }

      final movie = state.movie!.updateEdits(state);
      bool result = await RadarrAPIHelper().updateMovie(
        context: context,
        movie: movie,
        moveFiles: moveFiles,
      );
      if (result) ArrPilotRouter().popSafely();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';
import 'package:arrpilot/router/routes/radarr.dart';

class RadarrMovieDetailsNavigationBar extends StatefulWidget {
  static const List<IconData> icons = [
    Icons.subject_rounded,
    Icons.insert_drive_file_outlined,
    Icons.history_rounded,
    Icons.person_rounded
  ];
  static const List<String> titles = [
    'Overview',
    'Files',
    'History',
    'Cast & Crew'
  ];
  static List<ScrollController> scrollControllers =
      List.generate(icons.length, (_) => ScrollController());
  final PageController? pageController;
  final RadarrMovie? movie;

  const RadarrMovieDetailsNavigationBar({
    Key? key,
    required this.pageController,
    required this.movie,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMovieDetailsNavigationBar> {
  ArrPilotLoadingState _automaticLoadingState = ArrPilotLoadingState.INACTIVE;

  @override
  Widget build(BuildContext context) {
    return ArrPilotBottomNavigationBar(
      pageController: widget.pageController,
      scrollControllers: RadarrMovieDetailsNavigationBar.scrollControllers,
      icons: RadarrMovieDetailsNavigationBar.icons,
      titles: RadarrMovieDetailsNavigationBar.titles,
      topActions: [
        ArrPilotButton(
          type: ArrPilotButtonType.TEXT,
          text: 'Automatic',
          icon: Icons.search_rounded,
          onTap: _automatic,
          loadingState: _automaticLoadingState,
        ),
        ArrPilotButton.text(
          text: 'Interactive',
          icon: Icons.person_rounded,
          onTap: _manual,
        ),
      ],
    );
  }

  Future<void> _automatic() async {
    setState(() => _automaticLoadingState = ArrPilotLoadingState.ACTIVE);
    RadarrAPIHelper()
        .automaticSearch(
            context: context,
            movieId: widget.movie!.id!,
            title: widget.movie!.title!)
        .then((value) {
      if (mounted)
        setState(() {
          _automaticLoadingState =
              value ? ArrPilotLoadingState.INACTIVE : ArrPilotLoadingState.ERROR;
        });
    });
  }

  Future<void> _manual() async {
    RadarrRoutes.MOVIE_RELEASES.go(params: {
      'movie': widget.movie!.id!.toString(),
    });
  }
}

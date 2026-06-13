import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';

class RadarrMovieDetailsOverviewInformationBlock extends StatelessWidget {
  final RadarrMovie? movie;
  final RadarrQualityProfile? qualityProfile;
  final List<RadarrTag> tags;

  const RadarrMovieDetailsOverviewInformationBlock({
    Key? key,
    required this.movie,
    required this.qualityProfile,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotTableCard(
      content: [
        ArrPilotTableContent(
          title: 'monitoring',
          body: (movie?.monitored ?? false) ? 'Yes' : 'No',
        ),
        ArrPilotTableContent(title: 'path', body: movie?.path),
        ArrPilotTableContent(title: 'quality', body: qualityProfile?.name),
        ArrPilotTableContent(
          title: 'availability',
          body: movie?.lunaMinimumAvailability,
        ),
        ArrPilotTableContent(title: 'tags', body: movie?.lunaTags(tags)),
        ArrPilotTableContent(title: '', body: ''),
        ArrPilotTableContent(title: 'status', body: movie?.status?.readable),
        ArrPilotTableContent(title: 'in cinemas', body: movie?.lunaInCinemasOn()),
        ArrPilotTableContent(
          title: 'digital',
          body: movie?.lunaDigitalReleaseDate(),
        ),
        ArrPilotTableContent(
          title: 'physical',
          body: movie?.lunaPhysicalReleaseDate(),
        ),
        ArrPilotTableContent(title: 'added on', body: movie?.lunaDateAdded()),
        ArrPilotTableContent(title: '', body: ''),
        ArrPilotTableContent(title: 'year', body: movie?.lunaYear),
        ArrPilotTableContent(title: 'studio', body: movie?.lunaStudio),
        ArrPilotTableContent(title: 'runtime', body: movie?.lunaRuntime),
        ArrPilotTableContent(title: 'rating', body: movie?.certification),
        ArrPilotTableContent(title: 'genres', body: movie?.lunaGenres),
        ArrPilotTableContent(
            title: 'alternate titles', body: movie?.lunaAlternateTitles),
      ],
    );
  }
}

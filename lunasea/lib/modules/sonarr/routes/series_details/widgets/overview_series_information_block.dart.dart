import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/string/string.dart';
import 'package:arrpilot/modules/sonarr.dart';

class SonarrSeriesDetailsOverviewInformationBlock extends StatelessWidget {
  final SonarrSeries? series;
  final SonarrQualityProfile? qualityProfile;
  final SonarrLanguageProfile? languageProfile;
  final List<SonarrTag> tags;

  const SonarrSeriesDetailsOverviewInformationBlock({
    Key? key,
    required this.series,
    required this.qualityProfile,
    required this.languageProfile,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotTableCard(
      content: [
        ArrPilotTableContent(
          title: 'sonarr.Monitoring'.tr(),
          body: (series?.monitored ?? false) ? 'Yes' : 'No',
        ),
        ArrPilotTableContent(
          title: 'type',
          body: series?.lunaSeriesType,
        ),
        ArrPilotTableContent(
          title: 'path',
          body: series?.path,
        ),
        ArrPilotTableContent(
          title: 'quality',
          body: qualityProfile?.name,
        ),
        ArrPilotTableContent(
          title: 'language',
          body: languageProfile?.name,
        ),
        ArrPilotTableContent(
          title: 'tags',
          body: series?.lunaTags(tags),
        ),
        ArrPilotTableContent(title: '', body: ''),
        ArrPilotTableContent(
          title: 'status',
          body: series?.status?.toTitleCase(),
        ),
        ArrPilotTableContent(
          title: 'next airing',
          body: series?.lunaNextAiring(),
        ),
        ArrPilotTableContent(
          title: 'added on',
          body: series?.lunaDateAdded,
        ),
        ArrPilotTableContent(title: '', body: ''),
        ArrPilotTableContent(
          title: 'year',
          body: series?.lunaYear,
        ),
        ArrPilotTableContent(
          title: 'network',
          body: series?.lunaNetwork,
        ),
        ArrPilotTableContent(
          title: 'runtime',
          body: series?.lunaRuntime,
        ),
        ArrPilotTableContent(
          title: 'rating',
          body: series?.certification,
        ),
        ArrPilotTableContent(
          title: 'genres',
          body: series?.lunaGenres,
        ),
        ArrPilotTableContent(
          title: 'alternate titles',
          body: series?.lunaAlternateTitles,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/sonarr.dart';

class SonarrSeriesDetailsOverviewDescriptionTile extends StatelessWidget {
  final SonarrSeries? series;

  const SonarrSeriesDetailsOverviewDescriptionTile({
    Key? key,
    required this.series,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      posterPlaceholderIcon: ArrPilotIcons.VIDEO_CAM,
      backgroundUrl: context.read<SonarrState>().getFanartURL(series!.id),
      posterUrl: context.read<SonarrState>().getPosterURL(series!.id),
      posterHeaders: context.read<SonarrState>().headers,
      title: series!.title,
      body: [
        ArrPilotTextSpan.extended(
          text: series!.overview == null || series!.overview!.isEmpty
              ? 'sonarr.NoSummaryAvailable'.tr()
              : series!.overview,
        ),
      ],
      customBodyMaxLines: 3,
      onTap: () async => ArrPilotDialogs().textPreview(
        context,
        series!.title,
        series!.overview!,
      ),
    );
  }
}

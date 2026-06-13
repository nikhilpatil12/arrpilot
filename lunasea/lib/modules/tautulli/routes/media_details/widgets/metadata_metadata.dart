import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/datetime.dart';
import 'package:arrpilot/extensions/duration/timestamp.dart';
import 'package:arrpilot/modules/tautulli.dart';

class TautulliMediaDetailsMetadataMetadata extends StatelessWidget {
  final TautulliMetadata? metadata;

  const TautulliMediaDetailsMetadataMetadata({
    Key? key,
    required this.metadata,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotTableCard(
      content: [
        if (metadata!.originallyAvailableAt != null &&
            metadata!.originallyAvailableAt!.isNotEmpty)
          ArrPilotTableContent(
            title: 'released',
            body: metadata!.originallyAvailableAt,
          ),
        if (metadata!.addedAt != null)
          ArrPilotTableContent(
            title: 'added',
            body: metadata!.addedAt!.asPoleDate(),
          ),
        if (metadata!.duration != null)
          ArrPilotTableContent(
            title: 'duration',
            body: metadata!.duration!.asNumberTimestamp(),
          ),
        if (metadata?.mediaInfo?.isNotEmpty ?? false)
          ArrPilotTableContent(
            title: 'bitrate',
            body:
                '${metadata!.mediaInfo![0].bitrate ?? ArrPilotUI.TEXT_EMDASH} kbps',
          ),
        if (metadata!.rating != null)
          ArrPilotTableContent(
              title: 'rating',
              body: '${(((metadata?.rating ?? 0) * 10).truncate())}%'),
        if (metadata!.studio != null && metadata!.studio!.isNotEmpty)
          ArrPilotTableContent(
            title: 'studio',
            body: metadata!.studio,
          ),
        if (metadata?.genres?.isNotEmpty ?? false)
          ArrPilotTableContent(
            title: 'genres',
            body: metadata!.genres!.take(5).join('\n'),
          ),
        if (metadata?.directors?.isNotEmpty ?? false)
          ArrPilotTableContent(
            title: 'directors',
            body: metadata!.directors!.take(5).join('\n'),
          ),
        if (metadata?.writers?.isNotEmpty ?? false)
          ArrPilotTableContent(
            title: 'writers',
            body: metadata!.writers!.take(5).join('\n'),
          ),
        if (metadata?.actors?.isNotEmpty ?? false)
          ArrPilotTableContent(
            title: 'actors',
            body: metadata!.actors!.take(5).join('\n'),
          ),
      ],
    );
  }
}

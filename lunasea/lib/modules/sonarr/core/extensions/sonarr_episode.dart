import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/int/bytes.dart';
import 'package:arrpilot/modules/sonarr.dart';

extension SonarrEpisodeExtension on SonarrEpisode {
  bool _hasAired() {
    return this.airDateUtc?.toLocal().isAfter(DateTime.now()) ?? true;
  }

  /// Creates a clone of the [SonarrEpisode] object (deep copy).
  SonarrEpisode clone() => SonarrEpisode.fromJson(this.toJson());

  String lunaAirDate() {
    if (this.airDateUtc == null) return 'arrpilot.UnknownDate'.tr();
    return DateFormat.yMMMMd().format(this.airDateUtc!.toLocal());
  }

  String lunaDownloadedQuality(
    SonarrEpisodeFile? file,
    SonarrQueueRecord? queueRecord,
  ) {
    if (queueRecord != null) {
      return [
        queueRecord.lunaPercentage(),
        ArrPilotUI.TEXT_EMDASH,
        queueRecord.lunaStatusParameters().item1,
      ].join(' ');
    }

    if (!this.hasFile!) {
      if (_hasAired()) return 'sonarr.Unaired'.tr();
      return 'sonarr.Missing'.tr();
    }
    if (file == null) return 'arrpilot.Unknown'.tr();
    String quality = file.quality?.quality?.name ?? 'arrpilot.Unknown'.tr();
    String size = file.size?.asBytes() ?? '0.00 B';
    return '$quality ${ArrPilotUI.TEXT_EMDASH} $size';
  }

  Color lunaDownloadedQualityColor(
    SonarrEpisodeFile? file,
    SonarrQueueRecord? queueRecord,
  ) {
    if (queueRecord != null) {
      return queueRecord.lunaStatusParameters(canBeWhite: false).item3;
    }

    if (!this.hasFile!) {
      if (_hasAired()) return ArrPilotColours.blue;
      return ArrPilotColours.red;
    }
    if (file == null) return ArrPilotColours.blueGrey;
    if (file.qualityCutoffNotMet!) return ArrPilotColours.orange;
    return ArrPilotColours.accent;
  }

  String lunaSeasonEpisode() {
    String season = this.seasonNumber != null
        ? 'sonarr.SeasonNumber'.tr(
            args: [this.seasonNumber.toString()],
          )
        : 'arrpilot.Unknown'.tr();
    String episode = this.episodeNumber != null
        ? 'sonarr.EpisodeNumber'.tr(
            args: [this.episodeNumber.toString()],
          )
        : 'arrpilot.Unknown'.tr();
    return '$season ${ArrPilotUI.TEXT_BULLET} $episode';
  }
}

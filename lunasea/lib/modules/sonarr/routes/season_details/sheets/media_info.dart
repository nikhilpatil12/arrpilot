import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/sonarr.dart';

class SonarrMediaInfoSheet extends ArrPilotBottomModalSheet {
  final SonarrEpisodeFileMediaInfo? mediaInfo;

  SonarrMediaInfoSheet({
    required this.mediaInfo,
  });

  @override
  Widget builder(BuildContext context) {
    return ArrPilotListViewModal(
      children: [
        ArrPilotHeader(text: 'sonarr.Video'.tr()),
        ArrPilotTableCard(
          content: [
            ArrPilotTableContent(
              title: 'sonarr.BitDepth'.tr(),
              body: mediaInfo!.lunaVideoBitDepth,
            ),
            ArrPilotTableContent(
              title: 'sonarr.Bitrate'.tr(),
              body: mediaInfo!.lunaVideoBitrate,
            ),
            ArrPilotTableContent(
              title: 'sonarr.Codec'.tr(),
              body: mediaInfo!.lunaVideoCodec,
            ),
            ArrPilotTableContent(
              title: 'sonarr.FPS'.tr(),
              body: mediaInfo!.lunaVideoFps,
            ),
            ArrPilotTableContent(
              title: 'sonarr.Resolution'.tr(),
              body: mediaInfo!.lunaVideoResolution,
            ),
            ArrPilotTableContent(
              title: 'sonarr.ScanType'.tr(),
              body: mediaInfo!.lunaVideoScanType,
            ),
          ],
        ),
        ArrPilotHeader(text: 'sonarr.Audio'.tr()),
        ArrPilotTableCard(
          content: [
            ArrPilotTableContent(
              title: 'sonarr.Bitrate'.tr(),
              body: mediaInfo!.lunaAudioBitrate,
            ),
            ArrPilotTableContent(
              title: 'sonarr.Channels'.tr(),
              body: mediaInfo!.lunaAudioChannels,
            ),
            ArrPilotTableContent(
              title: 'sonarr.Codec'.tr(),
              body: mediaInfo!.lunaAudioCodec,
            ),
            ArrPilotTableContent(
              title: 'sonarr.Languages'.tr(),
              body: mediaInfo!.lunaAudioLanguages,
            ),
            ArrPilotTableContent(
              title: 'sonarr.Streams'.tr(),
              body: mediaInfo!.lunaAudioStreamCount,
            ),
          ],
        ),
        ArrPilotHeader(text: 'sonarr.Other'.tr()),
        ArrPilotTableCard(
          content: [
            ArrPilotTableContent(
              title: 'sonarr.Runtime'.tr(),
              body: mediaInfo!.lunaRunTime,
            ),
            ArrPilotTableContent(
              title: 'sonarr.Subtitles'.tr(),
              body: mediaInfo!.lunaSubtitles,
            ),
          ],
        ),
      ],
    );
  }
}

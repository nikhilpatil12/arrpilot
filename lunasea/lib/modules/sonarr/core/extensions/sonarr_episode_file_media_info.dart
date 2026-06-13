import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/int/bytes.dart';
import 'package:arrpilot/modules/sonarr.dart';

extension SonarrEpisodeFileMediaInfoExtension on SonarrEpisodeFileMediaInfo {
  String get lunaVideoBitDepth {
    if (videoBitDepth != null) return videoBitDepth.toString();
    return ArrPilotUI.TEXT_EMDASH;
  }

  String get lunaVideoBitrate {
    if (videoBitrate != null) return '${videoBitrate.asBits()}/s';
    return ArrPilotUI.TEXT_EMDASH;
  }

  String? get lunaVideoCodec {
    if (videoCodec != null && videoCodec!.isNotEmpty) return videoCodec;
    return ArrPilotUI.TEXT_EMDASH;
  }

  String get lunaVideoFps {
    if (videoFps != null) return videoFps.toString();
    return ArrPilotUI.TEXT_EMDASH;
  }

  String? get lunaVideoResolution {
    if (resolution != null && resolution!.isNotEmpty) return resolution;
    return ArrPilotUI.TEXT_EMDASH;
  }

  String? get lunaVideoScanType {
    if (scanType != null && scanType!.isNotEmpty) return scanType;
    return ArrPilotUI.TEXT_EMDASH;
  }

  String get lunaAudioBitrate {
    if (audioBitrate != null) return '${audioBitrate.asBits()}/s';
    return ArrPilotUI.TEXT_EMDASH;
  }

  String get lunaAudioChannels {
    if (audioChannels != null) return audioChannels.toString();
    return ArrPilotUI.TEXT_EMDASH;
  }

  String? get lunaAudioCodec {
    if (audioCodec != null && audioCodec!.isNotEmpty) return audioCodec;
    return ArrPilotUI.TEXT_EMDASH;
  }

  String? get lunaAudioLanguages {
    if (audioLanguages != null && audioLanguages!.isNotEmpty)
      return audioLanguages;
    return ArrPilotUI.TEXT_EMDASH;
  }

  String get lunaAudioStreamCount {
    if (audioStreamCount != null) return audioStreamCount.toString();
    return ArrPilotUI.TEXT_EMDASH;
  }

  String? get lunaRunTime {
    if (runTime != null && runTime!.isNotEmpty) return runTime;
    return ArrPilotUI.TEXT_EMDASH;
  }

  String? get lunaSubtitles {
    if (subtitles != null && subtitles!.isNotEmpty) return subtitles;
    return ArrPilotUI.TEXT_EMDASH;
  }
}

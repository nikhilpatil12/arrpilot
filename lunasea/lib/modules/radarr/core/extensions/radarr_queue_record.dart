import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';

extension ArrPilotRadarrQueueRecord on RadarrQueueRecord {
  String get lunaQuality {
    return this.quality?.quality?.name ?? ArrPilotUI.TEXT_EMDASH;
  }

  String get lunaLanguage {
    if ((this.languages?.length ?? 0) == 0) return ArrPilotUI.TEXT_EMDASH;
    if (this.languages!.length == 1)
      return this.languages![0].name ?? ArrPilotUI.TEXT_EMDASH;
    return 'Multi-Language';
  }

  String lunaMovieTitle(RadarrMovie movie) {
    String title = movie.title ?? ArrPilotUI.TEXT_EMDASH;
    String year = movie.lunaYear;
    return '$title ($year)';
  }

  String? get lunaDownloadClient {
    if ((this.downloadClient ?? '').isNotEmpty) return this.downloadClient;
    return ArrPilotUI.TEXT_EMDASH;
  }

  String? get lunaIndexer {
    if ((this.indexer ?? '').isNotEmpty) return this.indexer;
    return ArrPilotUI.TEXT_EMDASH;
  }

  Color get lunaProtocolColor {
    if (this.protocol == RadarrProtocol.USENET) return ArrPilotColours.accent;
    return ArrPilotColours.blue;
  }

  int get lunaPercentageComplete {
    if (this.sizeLeft == null || this.size == null || this.size == 0) return 0;
    double sizeFetched = this.size! - this.sizeLeft!;
    return ((sizeFetched / this.size!) * 100).round();
  }

  IconData get lunaStatusIcon {
    switch (this.status) {
      case RadarrQueueRecordStatus.DELAY:
        return Icons.access_time_rounded;
      case RadarrQueueRecordStatus.DOWNLOAD_CLIENT_UNAVAILABLE:
        return Icons.access_time_rounded;
      case RadarrQueueRecordStatus.FAILED:
        return Icons.cloud_download_rounded;
      case RadarrQueueRecordStatus.PAUSED:
        return Icons.pause_rounded;
      case RadarrQueueRecordStatus.QUEUED:
        return Icons.cloud_rounded;
      case RadarrQueueRecordStatus.WARNING:
        return Icons.cloud_download_rounded;
      case RadarrQueueRecordStatus.COMPLETED:
        return Icons.download_done_rounded;
      case RadarrQueueRecordStatus.DOWNLOADING:
        return Icons.cloud_download_rounded;
      default:
        return Icons.cloud_download_rounded;
    }
  }

  Color get lunaStatusColor {
    Color color = Colors.white;
    if (this.status == RadarrQueueRecordStatus.COMPLETED)
      switch (this.trackedDownloadState) {
        case RadarrTrackedDownloadState.FAILED_PENDING:
          color = ArrPilotColours.red;
          break;
        case RadarrTrackedDownloadState.IMPORT_PENDING:
          color = ArrPilotColours.purple;
          break;
        case RadarrTrackedDownloadState.IMPORTING:
          color = ArrPilotColours.purple;
          break;
        default:
          break;
      }
    if (this.trackedDownloadStatus == RadarrTrackedDownloadStatus.WARNING)
      color = ArrPilotColours.orange;
    switch (this.status) {
      case RadarrQueueRecordStatus.DOWNLOAD_CLIENT_UNAVAILABLE:
        color = ArrPilotColours.orange;
        break;
      case RadarrQueueRecordStatus.FAILED:
        color = ArrPilotColours.red;
        break;
      case RadarrQueueRecordStatus.WARNING:
        color = ArrPilotColours.orange;
        break;
      default:
        break;
    }
    if (this.trackedDownloadStatus == RadarrTrackedDownloadStatus.ERROR)
      color = ArrPilotColours.red;
    return color;
  }
}

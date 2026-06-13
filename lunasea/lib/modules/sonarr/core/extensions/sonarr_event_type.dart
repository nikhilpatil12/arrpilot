import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/datetime.dart';
import 'package:arrpilot/extensions/double/time.dart';
import 'package:arrpilot/modules/sonarr.dart';

extension SonarrEventTypeLunaExtension on SonarrEventType {
  Color lunaColour() {
    switch (this) {
      case SonarrEventType.EPISODE_FILE_RENAMED:
        return ArrPilotColours.blue;
      case SonarrEventType.EPISODE_FILE_DELETED:
        return ArrPilotColours.red;
      case SonarrEventType.DOWNLOAD_FOLDER_IMPORTED:
        return ArrPilotColours.accent;
      case SonarrEventType.DOWNLOAD_FAILED:
        return ArrPilotColours.red;
      case SonarrEventType.DOWNLOAD_IGNORED:
        return ArrPilotColours.purple;
      case SonarrEventType.GRABBED:
        return ArrPilotColours.orange;
      case SonarrEventType.SERIES_FOLDER_IMPORTED:
        return ArrPilotColours.accent;
    }
  }

  IconData lunaIcon() {
    switch (this) {
      case SonarrEventType.EPISODE_FILE_RENAMED:
        return Icons.drive_file_rename_outline_rounded;
      case SonarrEventType.EPISODE_FILE_DELETED:
        return Icons.delete_rounded;
      case SonarrEventType.DOWNLOAD_FOLDER_IMPORTED:
        return Icons.download_rounded;
      case SonarrEventType.DOWNLOAD_FAILED:
        return Icons.cloud_download_rounded;
      case SonarrEventType.DOWNLOAD_IGNORED:
        return Icons.cancel_rounded;
      case SonarrEventType.GRABBED:
        return Icons.cloud_download_rounded;
      case SonarrEventType.SERIES_FOLDER_IMPORTED:
        return Icons.download_rounded;
    }
  }

  Color lunaIconColour() {
    switch (this) {
      case SonarrEventType.EPISODE_FILE_RENAMED:
        return Colors.white;
      case SonarrEventType.EPISODE_FILE_DELETED:
        return Colors.white;
      case SonarrEventType.DOWNLOAD_FOLDER_IMPORTED:
        return Colors.white;
      case SonarrEventType.DOWNLOAD_FAILED:
        return ArrPilotColours.red;
      case SonarrEventType.DOWNLOAD_IGNORED:
        return Colors.white;
      case SonarrEventType.GRABBED:
        return Colors.white;
      case SonarrEventType.SERIES_FOLDER_IMPORTED:
        return Colors.white;
    }
  }

  String? lunaReadable(SonarrHistoryRecord record) {
    switch (this) {
      case SonarrEventType.EPISODE_FILE_RENAMED:
        return 'sonarr.EpisodeFileRenamed'.tr();
      case SonarrEventType.EPISODE_FILE_DELETED:
        return 'sonarr.EpisodeFileDeleted'.tr();
      case SonarrEventType.DOWNLOAD_FOLDER_IMPORTED:
        return 'sonarr.EpisodeImported'.tr(
          args: [record.quality?.quality?.name ?? 'lunasea.Unknown'.tr()],
        );
      case SonarrEventType.DOWNLOAD_FAILED:
        return 'sonarr.DownloadFailed'.tr();
      case SonarrEventType.GRABBED:
        return 'sonarr.GrabbedFrom'.tr(
          args: [record.data!['indexer'] ?? 'lunasea.Unknown'.tr()],
        );
      case SonarrEventType.DOWNLOAD_IGNORED:
        return 'sonarr.DownloadIgnored'.tr();
      case SonarrEventType.SERIES_FOLDER_IMPORTED:
        return 'sonarr.SeriesFolderImported'.tr();
    }
  }

  List<ArrPilotTableContent> lunaTableContent({
    required SonarrHistoryRecord history,
    required bool showSourceTitle,
  }) {
    switch (this) {
      case SonarrEventType.DOWNLOAD_FAILED:
        return _downloadFailedTableContent(history, showSourceTitle);
      case SonarrEventType.DOWNLOAD_FOLDER_IMPORTED:
        return _downloadFolderImportedTableContent(history, showSourceTitle);
      case SonarrEventType.DOWNLOAD_IGNORED:
        return _downloadIgnoredTableContent(history, showSourceTitle);
      case SonarrEventType.EPISODE_FILE_DELETED:
        return _episodeFileDeletedTableContent(history, showSourceTitle);
      case SonarrEventType.EPISODE_FILE_RENAMED:
        return _episodeFileRenamedTableContent(history);
      case SonarrEventType.GRABBED:
        return _grabbedTableContent(history, showSourceTitle);
      case SonarrEventType.SERIES_FOLDER_IMPORTED:
      default:
        return _defaultTableContent(history, showSourceTitle);
    }
  }

  List<ArrPilotTableContent> _downloadFailedTableContent(
    SonarrHistoryRecord history,
    bool showSourceTitle,
  ) {
    return [
      if (showSourceTitle)
        ArrPilotTableContent(
          title: 'sonarr.SourceTitle'.tr(),
          body: history.sourceTitle,
        ),
      ArrPilotTableContent(
        title: 'sonarr.Message'.tr(),
        body: history.data!['message'],
      ),
    ];
  }

  List<ArrPilotTableContent> _downloadFolderImportedTableContent(
    SonarrHistoryRecord history,
    bool showSourceTitle,
  ) {
    return [
      if (showSourceTitle)
        ArrPilotTableContent(
          title: 'sonarr.SourceTitle'.tr(),
          body: history.sourceTitle,
        ),
      ArrPilotTableContent(
        title: 'sonarr.Quality'.tr(),
        body: history.quality?.quality?.name ?? ArrPilotUI.TEXT_EMDASH,
      ),
      if (history.language != null)
        ArrPilotTableContent(
          title: 'sonarr.Languages'.tr(),
          body: history.language?.name ?? ArrPilotUI.TEXT_EMDASH,
        ),
      ArrPilotTableContent(
        title: 'sonarr.Client'.tr(),
        body: history.data!['downloadClient'] ?? ArrPilotUI.TEXT_EMDASH,
      ),
      ArrPilotTableContent(
        title: 'sonarr.Source'.tr(),
        body: history.data!['droppedPath'],
      ),
      ArrPilotTableContent(
        title: 'sonarr.ImportedTo'.tr(),
        body: history.data!['importedPath'],
      ),
    ];
  }

  List<ArrPilotTableContent> _downloadIgnoredTableContent(
    SonarrHistoryRecord history,
    bool showSourceTitle,
  ) {
    return [
      if (showSourceTitle)
        ArrPilotTableContent(
          title: 'sonarr.Name'.tr(),
          body: history.sourceTitle,
        ),
      ArrPilotTableContent(
        title: 'sonarr.Message'.tr(),
        body: history.data!['message'],
      ),
    ];
  }

  List<ArrPilotTableContent> _episodeFileDeletedTableContent(
    SonarrHistoryRecord history,
    bool showSourceTitle,
  ) {
    String _reasonMapping(String? reason) {
      switch (reason) {
        case 'Upgrade':
          return 'sonarr.DeleteReasonUpgrade'.tr();
        case 'MissingFromDisk':
          return 'sonarr.DeleteReasonMissingFromDisk'.tr();
        case 'Manual':
          return 'sonarr.DeleteReasonManual'.tr();
        default:
          return 'lunasea.Unknown'.tr();
      }
    }

    return [
      if (showSourceTitle)
        ArrPilotTableContent(
          title: 'sonarr.SourceTitle'.tr(),
          body: history.sourceTitle,
        ),
      ArrPilotTableContent(
        title: 'sonarr.Reason'.tr(),
        body: _reasonMapping(history.data!['reason']),
      ),
    ];
  }

  List<ArrPilotTableContent> _episodeFileRenamedTableContent(
    SonarrHistoryRecord history,
  ) {
    return [
      ArrPilotTableContent(
        title: 'sonarr.Source'.tr(),
        body: history.data!['sourcePath'],
      ),
      ArrPilotTableContent(
        title: 'sonarr.SourceRelative'.tr(),
        body: history.data!['sourceRelativePath'],
      ),
      ArrPilotTableContent(
        title: 'sonarr.Destination'.tr(),
        body: history.data!['path'],
      ),
      ArrPilotTableContent(
        title: 'sonarr.DestinationRelative'.tr(),
        body: history.data!['relativePath'],
      ),
    ];
  }

  List<ArrPilotTableContent> _grabbedTableContent(
    SonarrHistoryRecord history,
    bool showSourceTitle,
  ) {
    return [
      if (showSourceTitle)
        ArrPilotTableContent(
          title: 'sonarr.SourceTitle'.tr(),
          body: history.sourceTitle,
        ),
      ArrPilotTableContent(
        title: 'sonarr.Quality'.tr(),
        body: history.quality?.quality?.name ?? ArrPilotUI.TEXT_EMDASH,
      ),
      if (history.language != null)
        ArrPilotTableContent(
          title: 'sonarr.Languages'.tr(),
          body: history.language?.name ?? ArrPilotUI.TEXT_EMDASH,
        ),
      ArrPilotTableContent(
        title: 'sonarr.Indexer'.tr(),
        body: history.data!['indexer'],
      ),
      ArrPilotTableContent(
        title: 'sonarr.ReleaseGroup'.tr(),
        body: history.data!['releaseGroup'],
      ),
      ArrPilotTableContent(
        title: 'sonarr.InfoURL'.tr(),
        body: history.data!['nzbInfoUrl'],
        bodyIsUrl: history.data!['nzbInfoUrl'] != null,
      ),
      ArrPilotTableContent(
        title: 'sonarr.Client'.tr(),
        body: history.data!['downloadClientName'],
      ),
      ArrPilotTableContent(
        title: 'sonarr.DownloadID'.tr(),
        body: history.data!['downloadId'],
      ),
      ArrPilotTableContent(
        title: 'sonarr.Age'.tr(),
        body: double.tryParse(history.data!['ageHours'])?.asTimeAgo(),
      ),
      ArrPilotTableContent(
          title: 'sonarr.PublishedDate'.tr(),
          body: DateTime.tryParse(history.data!['publishedDate'])
              ?.asDateTime(delimiter: '\n')),
    ];
  }

  List<ArrPilotTableContent> _defaultTableContent(
    SonarrHistoryRecord history,
    bool showSourceTitle,
  ) {
    return [
      if (showSourceTitle)
        ArrPilotTableContent(
          title: 'sonarr.Name'.tr(),
          body: history.sourceTitle,
        ),
    ];
  }
}

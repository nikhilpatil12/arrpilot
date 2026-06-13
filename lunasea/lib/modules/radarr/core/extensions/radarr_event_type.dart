import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/datetime.dart';
import 'package:arrpilot/extensions/double/time.dart';
import 'package:arrpilot/modules/radarr.dart';

extension ArrPilotRadarrEventType on RadarrEventType {
  // Get ArrPilot associated colour of the event type.
  Color get lunaColour {
    switch (this) {
      case RadarrEventType.GRABBED:
        return ArrPilotColours.orange;
      case RadarrEventType.DOWNLOAD_FAILED:
        return ArrPilotColours.red;
      case RadarrEventType.DOWNLOAD_FOLDER_IMPORTED:
        return ArrPilotColours.accent;
      case RadarrEventType.DOWNLOAD_IGNORED:
        return ArrPilotColours.purple;
      case RadarrEventType.MOVIE_FILE_DELETED:
        return ArrPilotColours.red;
      case RadarrEventType.MOVIE_FILE_RENAMED:
        return ArrPilotColours.blue;
      case RadarrEventType.MOVIE_FOLDER_IMPORTED:
        return ArrPilotColours.accent;
    }
  }

  IconData get lunaIcon {
    switch (this) {
      case RadarrEventType.GRABBED:
        return Icons.cloud_download_rounded;
      case RadarrEventType.DOWNLOAD_FAILED:
        return Icons.cloud_download_rounded;
      case RadarrEventType.DOWNLOAD_FOLDER_IMPORTED:
        return Icons.download_rounded;
      case RadarrEventType.MOVIE_FOLDER_IMPORTED:
        return Icons.download_rounded;
      case RadarrEventType.MOVIE_FILE_DELETED:
        return Icons.delete_rounded;
      case RadarrEventType.DOWNLOAD_IGNORED:
        return Icons.cancel_rounded;
      case RadarrEventType.MOVIE_FILE_RENAMED:
        return Icons.drive_file_rename_outline_rounded;
    }
  }

  Color get lunaIconColour {
    switch (this) {
      case RadarrEventType.GRABBED:
        return Colors.white;
      case RadarrEventType.DOWNLOAD_FAILED:
        return ArrPilotColours.red;
      case RadarrEventType.DOWNLOAD_FOLDER_IMPORTED:
        return Colors.white;
      case RadarrEventType.DOWNLOAD_IGNORED:
        return Colors.white;
      case RadarrEventType.MOVIE_FILE_DELETED:
        return Colors.white;
      case RadarrEventType.MOVIE_FILE_RENAMED:
        return Colors.white;
      case RadarrEventType.MOVIE_FOLDER_IMPORTED:
        return Colors.white;
    }
  }

  String? lunaReadable(RadarrHistoryRecord record) {
    switch (this) {
      case RadarrEventType.GRABBED:
        return 'radarr.GrabbedFrom'
            .tr(args: [(record.data ?? {})['indexer'] ?? ArrPilotUI.TEXT_EMDASH]);
      case RadarrEventType.DOWNLOAD_FAILED:
        return 'radarr.DownloadFailed'.tr();
      case RadarrEventType.DOWNLOAD_FOLDER_IMPORTED:
        return 'radarr.MovieImported'
            .tr(args: [record.quality?.quality?.name ?? ArrPilotUI.TEXT_EMDASH]);
      case RadarrEventType.DOWNLOAD_IGNORED:
        return 'radarr.DownloadIgnored'.tr();
      case RadarrEventType.MOVIE_FILE_DELETED:
        return 'radarr.MovieFileDeleted'.tr();
      case RadarrEventType.MOVIE_FILE_RENAMED:
        return 'radarr.MovieFileRenamed'.tr();
      case RadarrEventType.MOVIE_FOLDER_IMPORTED:
        return 'radarr.MovieImported'
            .tr(args: [record.quality?.quality?.name ?? ArrPilotUI.TEXT_EMDASH]);
    }
  }

  List<ArrPilotTableContent> lunaTableContent(
    RadarrHistoryRecord record, {
    bool movieHistory = false,
  }) {
    switch (this) {
      case RadarrEventType.GRABBED:
        return _grabbedTableContent(record, !movieHistory);
      case RadarrEventType.DOWNLOAD_FAILED:
        return _downloadFailedTableContent(record, !movieHistory);
      case RadarrEventType.DOWNLOAD_FOLDER_IMPORTED:
        return _downloadFolderImportedTableContent(record);
      case RadarrEventType.DOWNLOAD_IGNORED:
        return _downloadIgnoredTableContent(record, !movieHistory);
      case RadarrEventType.MOVIE_FILE_DELETED:
        return _movieFileDeletedTableContent(record, !movieHistory);
      case RadarrEventType.MOVIE_FILE_RENAMED:
        return _movieFileRenamedTableContent(record);
      case RadarrEventType.MOVIE_FOLDER_IMPORTED:
        return _movieFolderImportedTableContent(record);
      default:
        return [];
    }
  }

  List<ArrPilotTableContent> _grabbedTableContent(
    RadarrHistoryRecord record,
    bool showSourceTitle,
  ) {
    return [
      if (showSourceTitle)
        ArrPilotTableContent(
          title: 'source title',
          body: record.sourceTitle ?? ArrPilotUI.TEXT_EMDASH,
        ),
      ArrPilotTableContent(
        title: 'quality',
        body: record.quality?.quality?.name ?? ArrPilotUI.TEXT_EMDASH,
      ),
      ArrPilotTableContent(
        title: 'languages',
        body: record.languages
            ?.map<String?>((language) => language.name)
            .join('\n'),
      ),
      ArrPilotTableContent(
        title: 'indexer',
        body: record.data!['indexer'] ?? ArrPilotUI.TEXT_EMDASH,
      ),
      ArrPilotTableContent(
        title: 'group',
        body: record.data!['releaseGroup'] ?? ArrPilotUI.TEXT_EMDASH,
      ),
      ArrPilotTableContent(
        title: 'client',
        body: record.data!['downloadClientName'] ?? ArrPilotUI.TEXT_EMDASH,
      ),
      ArrPilotTableContent(
        title: 'age',
        body: record.data!['ageHours'] != null
            ? double.tryParse((record.data!['ageHours'] as String))
                    ?.asTimeAgo() ??
                ArrPilotUI.TEXT_EMDASH
            : ArrPilotUI.TEXT_EMDASH,
      ),
      ArrPilotTableContent(
        title: 'published date',
        body: DateTime.tryParse(record.data!['publishedDate']) != null
            ? DateTime.tryParse(record.data!['publishedDate'])
                    ?.asDateTime(delimiter: '\n') ??
                ArrPilotUI.TEXT_EMDASH
            : ArrPilotUI.TEXT_EMDASH,
      ),
      ArrPilotTableContent(
        title: 'info url',
        body: record.data!['nzbInfoUrl'] ?? ArrPilotUI.TEXT_EMDASH,
        bodyIsUrl: record.data!['nzbInfoUrl'] != null,
      ),
    ];
  }

  List<ArrPilotTableContent> _downloadFailedTableContent(
    RadarrHistoryRecord record,
    bool showSourceTitle,
  ) {
    return [
      if (showSourceTitle)
        ArrPilotTableContent(
          title: 'source title',
          body: record.sourceTitle ?? ArrPilotUI.TEXT_EMDASH,
        ),
      ArrPilotTableContent(
        title: 'client',
        body: record.data!['downloadClientName'] ?? ArrPilotUI.TEXT_EMDASH,
      ),
      ArrPilotTableContent(
        title: 'message',
        body: record.data!['message'] ?? ArrPilotUI.TEXT_EMDASH,
      ),
    ];
  }

  List<ArrPilotTableContent> _downloadFolderImportedTableContent(
    RadarrHistoryRecord record,
  ) {
    return [
      ArrPilotTableContent(
        title: 'source title',
        body: record.sourceTitle ?? ArrPilotUI.TEXT_EMDASH,
      ),
      ArrPilotTableContent(
        title: 'quality',
        body: record.quality?.quality?.name ?? ArrPilotUI.TEXT_EMDASH,
      ),
      ArrPilotTableContent(
        title: 'languages',
        body: record.languages
                ?.map<String?>((language) => language.name)
                .join('\n') ??
            ArrPilotUI.TEXT_EMDASH,
      ),
      ArrPilotTableContent(
        title: 'client',
        body: record.data!['downloadClientName'] ?? ArrPilotUI.TEXT_EMDASH,
      ),
      ArrPilotTableContent(
        title: 'source',
        body: record.data!['droppedPath'] ?? ArrPilotUI.TEXT_EMDASH,
      ),
      ArrPilotTableContent(
        title: 'imported to',
        body: record.data!['importedPath'] ?? ArrPilotUI.TEXT_EMDASH,
      ),
    ];
  }

  List<ArrPilotTableContent> _downloadIgnoredTableContent(
    RadarrHistoryRecord record,
    bool showSourceTitle,
  ) {
    return [
      if (showSourceTitle)
        ArrPilotTableContent(
          title: 'source title',
          body: record.sourceTitle ?? ArrPilotUI.TEXT_EMDASH,
        ),
      ArrPilotTableContent(
        title: 'message',
        body: record.data!['message'] ?? ArrPilotUI.TEXT_EMDASH,
      ),
    ];
  }

  List<ArrPilotTableContent> _movieFileDeletedTableContent(
    RadarrHistoryRecord record,
    bool showSourceTitle,
  ) {
    return [
      if (showSourceTitle)
        ArrPilotTableContent(
          title: 'source title',
          body: record.sourceTitle ?? ArrPilotUI.TEXT_EMDASH,
        ),
      ArrPilotTableContent(
        title: 'reason',
        body: record.lunaFileDeletedReasonMessage,
      ),
    ];
  }

  List<ArrPilotTableContent> _movieFileRenamedTableContent(
    RadarrHistoryRecord record,
  ) {
    return [
      ArrPilotTableContent(
        title: 'source',
        body: record.data!['sourceRelativePath'] ?? ArrPilotUI.TEXT_EMDASH,
      ),
      ArrPilotTableContent(
        title: 'destination',
        body: record.data!['relativePath'] ?? ArrPilotUI.TEXT_EMDASH,
      ),
    ];
  }

  List<ArrPilotTableContent> _movieFolderImportedTableContent(
    RadarrHistoryRecord record,
  ) {
    return [
      ArrPilotTableContent(
        title: 'source title',
        body: record.sourceTitle ?? ArrPilotUI.TEXT_EMDASH,
      ),
      ArrPilotTableContent(
        title: 'quality',
        body: record.quality?.quality?.name ?? ArrPilotUI.TEXT_EMDASH,
      ),
      ArrPilotTableContent(
        title: 'languages',
        body: ([RadarrLanguage(name: ArrPilotUI.TEXT_EMDASH)])
            .map<String?>((language) => language.name)
            .join('\n'),
      ),
      ArrPilotTableContent(
        title: 'client',
        body: record.data!['downloadClientName'] ?? ArrPilotUI.TEXT_EMDASH,
      ),
      ArrPilotTableContent(
        title: 'source',
        body: record.data!['droppedPath'] ?? ArrPilotUI.TEXT_EMDASH,
      ),
      ArrPilotTableContent(
        title: 'imported to',
        body: record.data!['importedPath'] ?? ArrPilotUI.TEXT_EMDASH,
      ),
    ];
  }
}

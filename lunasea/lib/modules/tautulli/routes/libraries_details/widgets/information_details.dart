import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/datetime.dart';
import 'package:arrpilot/modules/tautulli.dart';

class TautulliLibrariesDetailsInformationDetails extends StatelessWidget {
  final TautulliTableLibrary library;

  const TautulliLibrariesDetailsInformationDetails({
    Key? key,
    required this.library,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotTableCard(
      content: [
        ArrPilotTableContent(title: 'name', body: library.sectionName),
        if (library.count != null)
          ArrPilotTableContent(
              title: _count(library.count),
              body: '${library.count} ${_count(library.count)}'),
        if (library.parentCount != null)
          ArrPilotTableContent(
              title: _parentCount(library.parentCount),
              body:
                  '${library.parentCount} ${_parentCount(library.parentCount)}'),
        if (library.childCount != null)
          ArrPilotTableContent(
              title: _childCount(library.childCount),
              body: '${library.childCount} ${_childCount(library.childCount)}'),
        ArrPilotTableContent(
          title: 'last played',
          body: [
            library.lastPlayed ?? ArrPilotUI.TEXT_EMDASH,
            library.lastAccessed?.asAge() ?? 'Unknown',
          ].join('\n'),
        ),
      ],
    );
  }

  String _count(int? value) {
    switch (library.sectionType) {
      case TautulliSectionType.MOVIE:
        return value == 1 ? 'Movie' : 'Movies';
      case TautulliSectionType.SHOW:
        return 'Series';
      case TautulliSectionType.ARTIST:
        return value == 1 ? 'Artist' : 'Artists';
      case TautulliSectionType.PHOTO:
        return value == 1 ? 'Photo' : 'Photos';
      case TautulliSectionType.NULL:
      default:
        return 'Unknown';
    }
  }

  String? _childCount(int? value) {
    switch (library.sectionType) {
      case TautulliSectionType.MOVIE:
        return null;
      case TautulliSectionType.SHOW:
        return value == 1 ? 'Episode' : 'Episodes';
      case TautulliSectionType.ARTIST:
        return value == 1 ? 'Track' : 'Tracks';
      case TautulliSectionType.PHOTO:
        return null;
      case TautulliSectionType.NULL:
      default:
        return 'Unknown';
    }
  }

  String? _parentCount(int? value) {
    switch (library.sectionType) {
      case TautulliSectionType.MOVIE:
        return null;
      case TautulliSectionType.SHOW:
        return value == 1 ? 'Season' : 'Seasons';
      case TautulliSectionType.ARTIST:
        return value == 1 ? 'Album' : 'Albums';
      case TautulliSectionType.PHOTO:
        return null;
      case TautulliSectionType.NULL:
      default:
        return 'Unknown';
    }
  }
}

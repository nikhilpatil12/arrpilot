import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';

class RadarrMovieDetailsFilesExtraFileBlock extends StatelessWidget {
  final RadarrExtraFile file;

  const RadarrMovieDetailsFilesExtraFileBlock({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotTableCard(
      content: [
        ArrPilotTableContent(title: 'relative path', body: file.lunaRelativePath),
        ArrPilotTableContent(title: 'type', body: file.lunaType),
        ArrPilotTableContent(title: 'extension', body: file.lunaExtension),
      ],
    );
  }
}

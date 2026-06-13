import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';

class RadarrRootFolderTile extends StatelessWidget {
  final RadarrRootFolder rootFolder;

  const RadarrRootFolderTile({
    Key? key,
    required this.rootFolder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      title: rootFolder.lunaPath,
      body: [
        TextSpan(text: rootFolder.lunaSpace),
        TextSpan(
          text: rootFolder.lunaUnmappedFolders,
          style: const TextStyle(
            color: ArrPilotColours.accent,
            fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
          ),
        )
      ],
    );
  }
}

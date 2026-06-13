import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';

class RadarrManualImportParentDirectoryTile extends StatefulWidget {
  final RadarrFileSystem? fileSystem;

  const RadarrManualImportParentDirectoryTile({
    Key? key,
    required this.fileSystem,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrManualImportParentDirectoryTile> {
  ArrPilotLoadingState _loadingState = ArrPilotLoadingState.INACTIVE;

  @override
  Widget build(BuildContext context) {
    if (widget.fileSystem == null ||
        widget.fileSystem!.parent == null ||
        widget.fileSystem!.parent!.isEmpty) return const SizedBox(height: 0.0);
    return ArrPilotBlock(
      title: ArrPilotUI.TEXT_ELLIPSIS,
      body: [TextSpan(text: 'radarr.ParentDirectory'.tr())],
      trailing: ArrPilotIconButton(
        icon: Icons.arrow_upward_rounded,
        loadingState: _loadingState,
      ),
      onTap: () async {
        if (_loadingState == ArrPilotLoadingState.INACTIVE) {
          if (mounted) setState(() => _loadingState = ArrPilotLoadingState.ACTIVE);
          context.read<RadarrManualImportState>().fetchDirectories(
                context,
                widget.fileSystem!.parent,
              );
        }
      },
    );
  }
}

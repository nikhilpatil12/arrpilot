import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';

class RadarrManualImportDirectoryTile extends StatefulWidget {
  final RadarrFileSystemDirectory directory;

  const RadarrManualImportDirectoryTile({
    Key? key,
    required this.directory,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrManualImportDirectoryTile> {
  ArrPilotLoadingState _loadingState = ArrPilotLoadingState.INACTIVE;

  @override
  Widget build(BuildContext context) {
    RadarrFileSystemDirectory _dir = widget.directory;
    if (_dir.path?.isEmpty ?? true) return const SizedBox(height: 0.0);
    return ArrPilotBlock(
      title: _dir.name ?? ArrPilotUI.TEXT_EMDASH,
      body: [TextSpan(text: _dir.path)],
      trailing: ArrPilotIconButton.arrow(loadingState: _loadingState),
      onTap: () async {
        if (_loadingState == ArrPilotLoadingState.INACTIVE) {
          if (mounted) setState(() => _loadingState = ArrPilotLoadingState.ACTIVE);
          context.read<RadarrManualImportState>().fetchDirectories(
                context,
                _dir.path,
              );
        }
      },
    );
  }
}

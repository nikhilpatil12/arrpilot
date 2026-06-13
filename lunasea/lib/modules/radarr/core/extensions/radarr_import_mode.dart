import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';

extension LunaRadarrImportMode on RadarrImportMode {
  String get lunaReadable {
    switch (this) {
      case RadarrImportMode.COPY:
        return 'radarr.CopyFull'.tr();
      case RadarrImportMode.MOVE:
        return 'radarr.MoveFull'.tr();
    }
  }

  IconData get lunaIcon {
    switch (this) {
      case RadarrImportMode.COPY:
        return Icons.copy_rounded;
      case RadarrImportMode.MOVE:
        return Icons.drive_file_move_outline;
    }
  }
}

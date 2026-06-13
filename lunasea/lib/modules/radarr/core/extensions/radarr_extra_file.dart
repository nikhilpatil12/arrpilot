import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/string/string.dart';
import 'package:arrpilot/modules/radarr.dart';

extension ArrPilotRadarrExtraFileExtension on RadarrExtraFile {
  String get lunaRelativePath {
    if (this.relativePath?.isNotEmpty ?? false) return this.relativePath!;
    return ArrPilotUI.TEXT_EMDASH;
  }

  String get lunaExtension {
    if (this.extension?.isNotEmpty ?? false) return this.extension!;
    return ArrPilotUI.TEXT_EMDASH;
  }

  String get lunaType {
    if (this.type?.isNotEmpty ?? false) return this.type!.toTitleCase();
    return ArrPilotUI.TEXT_EMDASH;
  }
}

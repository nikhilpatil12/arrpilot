import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/datetime.dart';
import 'package:arrpilot/extensions/int/bytes.dart';
import 'package:arrpilot/modules/radarr.dart';

extension ArrPilotRadarrMovieFileExtension on RadarrMovieFile {
  String get lunaRelativePath {
    if (this.relativePath?.isNotEmpty ?? false) return this.relativePath!;
    return ArrPilotUI.TEXT_EMDASH;
  }

  String get lunaSize {
    if ((this.size ?? 0) != 0) return this.size.asBytes(decimals: 1);
    return ArrPilotUI.TEXT_EMDASH;
  }

  String get lunaLanguage {
    if (this.languages?.isEmpty ?? true) return ArrPilotUI.TEXT_EMDASH;
    return this.languages!.map<String?>((lang) => lang.name).join('\n');
  }

  String get lunaQuality {
    if (this.quality?.quality?.name != null)
      return this.quality!.quality!.name!;
    return ArrPilotUI.TEXT_EMDASH;
  }

  String get lunaDateAdded {
    if (this.dateAdded != null)
      return this.dateAdded!.asDateTime(delimiter: '\n');
    return ArrPilotUI.TEXT_EMDASH;
  }

  String get lunaCustomFormats {
    if (this.customFormats != null && this.customFormats!.isNotEmpty)
      return this
          .customFormats!
          .map<String?>((format) => format.name)
          .join('\n');
    return ArrPilotUI.TEXT_EMDASH;
  }
}

import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/int/bytes.dart';
import 'package:arrpilot/modules/radarr.dart';

extension ArrPilotRadarrManualImportExtension on RadarrManualImport {
  String? get lunaLanguage {
    if ((this.languages?.length ?? 0) > 1) return 'Multi-Language';
    if ((this.languages?.length ?? 0) == 1) return this.languages![0].name;
    return ArrPilotUI.TEXT_EMDASH;
  }

  String get lunaQualityProfile {
    return this.quality?.quality?.name ?? ArrPilotUI.TEXT_EMDASH;
  }

  String get lunaSize {
    return this.size.asBytes();
  }

  String get lunaMovie {
    if (this.movie == null) return ArrPilotUI.TEXT_EMDASH;
    String title = this.movie!.title ?? ArrPilotUI.TEXT_EMDASH;
    int? year = (this.movie!.year ?? 0) == 0 ? null : this.movie!.year;
    return [
      title,
      if (year != null) '($year)',
    ].join(' ');
  }
}

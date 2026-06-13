import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';

extension RadarrQualityProfileExtension on RadarrQualityProfile {
  String? get lunaName {
    if (this.name != null && this.name!.isNotEmpty) return this.name;
    return ArrPilotUI.TEXT_EMDASH;
  }
}

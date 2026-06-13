import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/tautulli.dart';

extension ArrPilotTautulliTranscodeDecisionExtension on TautulliTranscodeDecision? {
  String get localizedName {
    switch (this) {
      case TautulliTranscodeDecision.TRANSCODE:
        return 'tautulli.Transcode'.tr();
      case TautulliTranscodeDecision.COPY:
        return 'tautulli.DirectStream'.tr();
      case TautulliTranscodeDecision.DIRECT_PLAY:
        return 'tautulli.DirectPlay'.tr();
      case TautulliTranscodeDecision.BURN:
        return 'tautulli.Burn'.tr();
      case TautulliTranscodeDecision.NULL:
      default:
        return 'tautulli.None'.tr();
    }
  }
}

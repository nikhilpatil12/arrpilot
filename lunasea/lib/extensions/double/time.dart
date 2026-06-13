import 'package:arrpilot/core.dart';

extension DoubleAsTimeExtension on double? {
  String asTimeAgo() {
    if (this == null || this! < 0) return ArrPilotUI.TEXT_EMDASH;

    double hours = this!;
    double minutes = (this! * 60);
    double days = (this! / 24);

    if (minutes <= 2) {
      return 'arrpilot.JustNow'.tr();
    }

    if (minutes <= 120) {
      return 'arrpilot.MinutesAgo'.tr(args: [minutes.round().toString()]);
    }

    if (hours <= 48) {
      return 'arrpilot.HoursAgo'.tr(args: [hours.toStringAsFixed(1)]);
    }

    return 'arrpilot.DaysAgo'.tr(args: [days.round().toString()]);
  }
}

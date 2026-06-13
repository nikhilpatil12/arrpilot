import 'package:arrpilot/database/tables/arrpilot.dart';
import 'package:arrpilot/extensions/string/string.dart';
import 'package:arrpilot/vendor.dart';
import 'package:arrpilot/widgets/ui.dart';

extension DateTimeExtension on DateTime {
  String _formatted(String format) {
    return DateFormat(format, 'en').format(this.toLocal());
  }

  DateTime floor() {
    return DateTime(this.year, this.month, this.day);
  }

  String asTimeOnly() {
    if (ArrPilotDatabase.USE_24_HOUR_TIME.read()) return _formatted('Hm');
    return _formatted('jm');
  }

  String asDateOnly({
    shortenMonth = false,
  }) {
    final format = shortenMonth ? 'MMM dd, y' : 'MMMM dd, y';
    return _formatted(format);
  }

  String asDateTime({
    bool showSeconds = true,
    bool shortenMonth = false,
    String? delimiter,
  }) {
    final format = StringBuffer(shortenMonth ? 'MMM dd, y' : 'MMMM dd, y');
    format.write(delimiter ?? ArrPilotUI.TEXT_BULLET.pad());
    format.write(ArrPilotDatabase.USE_24_HOUR_TIME.read() ? 'HH:mm' : 'hh:mm');
    if (showSeconds) format.write(':ss');
    if (!ArrPilotDatabase.USE_24_HOUR_TIME.read()) format.write(' a');

    return _formatted(format.toString());
  }

  String asPoleDate() {
    final year = this.year.toString().padLeft(4, '0');
    final month = this.month.toString().padLeft(2, '0');
    final day = this.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  String asAge() {
    final diff = DateTime.now().difference(this);
    if (diff.inSeconds < 15) return 'arrpilot.JustNow'.tr();

    final days = diff.inDays.abs();
    if (days >= 1) {
      final years = (days / 365).floor();
      if (years == 1) return 'arrpilot.OneYearAgo'.tr();
      if (years > 1) return 'arrpilot.YearsAgo'.tr(args: [years.toString()]);

      final months = (days / 30).floor();
      if (months == 1) return 'arrpilot.OneMonthAgo'.tr();
      if (months > 1) return 'arrpilot.MonthsAgo'.tr(args: [months.toString()]);

      if (days == 1) return 'arrpilot.OneDayAgo'.tr();
      if (days > 1) return 'arrpilot.DaysAgo'.tr(args: [days.toString()]);
    }

    final hours = diff.inHours.abs();
    if (hours == 1) return 'arrpilot.OneHourAgo'.tr();
    if (hours > 1) return 'arrpilot.HoursAgo'.tr(args: [hours.toString()]);

    final mins = diff.inMinutes.abs();
    if (mins == 1) return 'arrpilot.OneMinuteAgo'.tr();
    if (mins > 1) return 'arrpilot.MinutesAgo'.tr(args: [mins.toString()]);

    final secs = diff.inSeconds.abs();
    if (secs == 1) return 'arrpilot.OneSecondAgo'.tr();
    return 'arrpilot.SecondsAgo'.tr(args: [secs.toString()]);
  }

  String asDaysDifference() {
    final diff = DateTime.now().difference(this);
    final days = diff.inDays.abs();
    if (days == 0) return 'arrpilot.Today'.tr();

    final years = (days / 365).floor();
    if (years == 1) return 'arrpilot.OneYear'.tr();
    if (years > 1) return 'arrpilot.Years'.tr(args: [years.toString()]);

    final months = (days / 30).floor();
    if (months == 1) return 'arrpilot.OneMonth'.tr();
    if (months > 1) return 'arrpilot.Months'.tr(args: [months.toString()]);

    if (days == 1) return 'arrpilot.OneDay'.tr();
    return 'arrpilot.Days'.tr(args: [days.toString()]);
  }
}

import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/duration/timestamp.dart';
import 'package:arrpilot/extensions/string/string.dart';
import 'package:arrpilot/modules/radarr.dart';

extension RadarrSystemStatusExtension on RadarrSystemStatus {
  String get lunaVersion {
    if (this.version != null && this.version!.isNotEmpty) return this.version!;
    return ArrPilotUI.TEXT_EMDASH;
  }

  String get lunaPackageVersion {
    String? packageAuthor, packageVersion;
    if (this.packageVersion != null && this.packageVersion!.isNotEmpty)
      packageVersion = this.packageVersion;
    if (this.packageAuthor != null && this.packageAuthor!.isNotEmpty)
      packageAuthor = this.packageAuthor;
    return '${packageVersion ?? ArrPilotUI.TEXT_EMDASH} by ${packageAuthor ?? ArrPilotUI.TEXT_EMDASH}';
  }

  String get lunaNetCore {
    if (this.isNetCore ?? false)
      return 'Yes (${this.runtimeVersion ?? ArrPilotUI.TEXT_EMDASH})';
    return 'No';
  }

  bool get lunaIsDocker {
    return this.isDocker ?? false;
  }

  String get lunaDBMigration {
    if (this.migrationVersion != null) return '${this.migrationVersion}';
    return ArrPilotUI.TEXT_EMDASH;
  }

  String get lunaAppDataDirectory {
    if (this.appData != null && this.appData!.isNotEmpty) return this.appData!;
    return ArrPilotUI.TEXT_EMDASH;
  }

  String get lunaStartupDirectory {
    if (this.startupPath != null && this.startupPath!.isNotEmpty)
      return this.startupPath!;
    return ArrPilotUI.TEXT_EMDASH;
  }

  String get lunaMode {
    if (this.mode != null && this.mode!.isNotEmpty)
      return this.mode!.toTitleCase();
    return ArrPilotUI.TEXT_EMDASH;
  }

  String get lunaUptime {
    if (this.startTime != null && this.startTime!.isNotEmpty) {
      DateTime? _start = DateTime.tryParse(this.startTime!);
      if (_start != null)
        return DateTime.now().difference(_start).asWordsTimestamp();
    }
    return ArrPilotUI.TEXT_EMDASH;
  }
}

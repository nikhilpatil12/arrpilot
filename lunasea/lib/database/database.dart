import 'package:arrpilot/database/box.dart';
import 'package:arrpilot/database/models/profile.dart';
import 'package:arrpilot/database/table.dart';
import 'package:arrpilot/database/tables/arrpilot.dart';
import 'package:arrpilot/system/filesystem/filesystem.dart';
import 'package:arrpilot/system/platform.dart';
import 'package:arrpilot/vendor.dart';

class ArrPilotDatabaseService {
  static const String _DATABASE_LEGACY_PATH = 'database';
  static const String _DATABASE_PATH = 'ArrPilot/database';

  String get path {
    if (ArrPilotPlatform.isWindows || ArrPilotPlatform.isLinux)
      return _DATABASE_PATH;
    return _DATABASE_LEGACY_PATH;
  }

  Future<void> initialize() async {
    await Hive.initFlutter(path);
    ArrPilotTable.register();
    await open();
  }

  Future<void> open() async {
    await ArrPilotBox.open();
    if (ArrPilotBox.profiles.isEmpty) await bootstrap();
  }

  Future<void> nuke() async {
    await Hive.close();

    for (final box in ArrPilotBox.values) {
      await Hive.deleteBoxFromDisk(box.key, path: path);
    }

    if (ArrPilotFileSystem.isSupported) {
      await ArrPilotFileSystem().nuke();
    }
  }

  Future<void> bootstrap() async {
    const defaultProfile = ArrPilotProfile.DEFAULT_PROFILE;
    await clear();

    ArrPilotBox.profiles.update(defaultProfile, ArrPilotProfile());
    ArrPilotDatabase.ENABLED_PROFILE.update(defaultProfile);
  }

  Future<void> clear() async {
    for (final box in ArrPilotBox.values) await box.clear();
  }

  Future<void> deinitialize() async {
    await Hive.close();
  }
}

import 'package:arrpilot/database/box.dart';
import 'package:arrpilot/database/models/profile.dart';
import 'package:arrpilot/database/table.dart';
import 'package:arrpilot/database/tables/lunasea.dart';
import 'package:arrpilot/system/filesystem/filesystem.dart';
import 'package:arrpilot/system/platform.dart';
import 'package:arrpilot/vendor.dart';

class LunaDatabase {
  static const String _DATABASE_LEGACY_PATH = 'database';
  static const String _DATABASE_PATH = 'LunaSea/database';

  String get path {
    if (LunaPlatform.isWindows || LunaPlatform.isLinux) return _DATABASE_PATH;
    return _DATABASE_LEGACY_PATH;
  }

  Future<void> initialize() async {
    await Hive.initFlutter(path);
    LunaTable.register();
    await open();
  }

  Future<void> open() async {
    await LunaBox.open();
    if (LunaBox.profiles.isEmpty) await bootstrap();
  }

  Future<void> nuke() async {
    await Hive.close();

    for (final box in LunaBox.values) {
      await Hive.deleteBoxFromDisk(box.key, path: path);
    }

    if (LunaFileSystem.isSupported) {
      await LunaFileSystem().nuke();
    }
  }

  Future<void> bootstrap() async {
    const defaultProfile = LunaProfile.DEFAULT_PROFILE;
    await clear();

    LunaBox.profiles.update(defaultProfile, LunaProfile());
    LunaSeaDatabase.ENABLED_PROFILE.update(defaultProfile);
  }

  Future<void> clear() async {
    for (final box in LunaBox.values) await box.clear();
  }

  Future<void> deinitialize() async {
    await Hive.close();
  }
}

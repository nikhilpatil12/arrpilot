import 'package:arrpilot/database/models/external_module.dart';
import 'package:arrpilot/database/models/indexer.dart';
import 'package:arrpilot/database/models/log.dart';
import 'package:arrpilot/database/models/profile.dart';
import 'package:arrpilot/types/indexer_icon.dart';
import 'package:arrpilot/types/list_view_option.dart';
import 'package:arrpilot/modules.dart';
import 'package:arrpilot/database/table.dart';
import 'package:arrpilot/types/log_type.dart';
import 'package:arrpilot/vendor.dart';
import 'package:arrpilot/widgets/ui.dart';

enum ArrPilotDatabase<T> with ArrPilotTableMixin<T> {
  ANDROID_BACK_OPENS_DRAWER<bool>(true),
  DRAWER_AUTOMATIC_MANAGE<bool>(true),
  DRAWER_MANUAL_ORDER<List>([]),
  ENABLED_PROFILE<String>(ArrPilotProfile.DEFAULT_PROFILE),
  NETWORKING_TLS_VALIDATION<bool>(false),
  THEME_AMOLED<bool>(false),
  THEME_AMOLED_BORDER<bool>(false),
  THEME_IMAGE_BACKGROUND_OPACITY<int>(20),
  QUICK_ACTIONS_LIDARR<bool>(false),
  QUICK_ACTIONS_RADARR<bool>(false),
  QUICK_ACTIONS_SONARR<bool>(false),
  QUICK_ACTIONS_NZBGET<bool>(false),
  QUICK_ACTIONS_SABNZBD<bool>(false),
  QUICK_ACTIONS_OVERSEERR<bool>(false),
  QUICK_ACTIONS_TAUTULLI<bool>(false),
  QUICK_ACTIONS_SEARCH<bool>(false),
  USE_24_HOUR_TIME<bool>(false),
  ENABLE_IN_APP_NOTIFICATIONS<bool>(true),
  CHANGELOG_LAST_BUILD_VERSION<int>(0);

  @override
  ArrPilotTable get table => ArrPilotTable.arrpilot;

  @override
  final T fallback;

  const ArrPilotDatabase(this.fallback);

  @override
  void register() {
    Hive.registerAdapter(ArrPilotExternalModuleAdapter());
    Hive.registerAdapter(ArrPilotIndexerAdapter());
    Hive.registerAdapter(ArrPilotProfileAdapter());
    Hive.registerAdapter(ArrPilotLogAdapter());
    Hive.registerAdapter(ArrPilotIndexerIconAdapter());
    Hive.registerAdapter(ArrPilotLogTypeAdapter());
    Hive.registerAdapter(ArrPilotModuleAdapter());
    Hive.registerAdapter(ArrPilotListViewOptionAdapter());
  }

  @override
  dynamic export() {
    ArrPilotDatabase db = this;
    switch (db) {
      case ArrPilotDatabase.DRAWER_MANUAL_ORDER:
        return ArrPilotDrawer.moduleOrderedList()
            .map<String>((module) => module.key)
            .toList();
      default:
        return super.export();
    }
  }

  @override
  void import(dynamic value) {
    ArrPilotDatabase db = this;
    dynamic result;

    switch (db) {
      case ArrPilotDatabase.DRAWER_MANUAL_ORDER:
        List<ArrPilotModule> item = [];
        (value as List).cast<String>().forEach((val) {
          ArrPilotModule? module = ArrPilotModule.fromKey(val);
          if (module != null) item.add(module);
        });
        result = item;
        break;
      default:
        result = value;
        break;
    }

    return super.import(result);
  }
}

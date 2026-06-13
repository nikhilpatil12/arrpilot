import 'package:arrpilot/database/tables/lunasea.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:arrpilot/modules.dart';
import 'package:arrpilot/system/platform.dart';

// ignore: always_use_package_imports
import '../quick_actions.dart';

bool isPlatformSupported() => ArrPilotPlatform.isMobile;
ArrPilotQuickActions getQuickActions() {
  if (isPlatformSupported()) return IO();
  throw UnsupportedError('ArrPilotQuickActions unsupported');
}

class IO implements ArrPilotQuickActions {
  final QuickActions _quickActions = const QuickActions();

  @override
  Future<void> initialize() async {
    _quickActions.initialize(actionHandler);
    setActionItems();
  }

  @override
  void actionHandler(String action) {
    ArrPilotModule.fromKey(action)?.launch();
  }

  @override
  void setActionItems() {
    _quickActions.setShortcutItems(<ShortcutItem>[
      if (ArrPilotDatabase.QUICK_ACTIONS_TAUTULLI.read())
        ArrPilotModule.TAUTULLI.shortcutItem,
      if (ArrPilotDatabase.QUICK_ACTIONS_SONARR.read())
        ArrPilotModule.SONARR.shortcutItem,
      if (ArrPilotDatabase.QUICK_ACTIONS_SEARCH.read())
        ArrPilotModule.SEARCH.shortcutItem,
      if (ArrPilotDatabase.QUICK_ACTIONS_SABNZBD.read())
        ArrPilotModule.SABNZBD.shortcutItem,
      if (ArrPilotDatabase.QUICK_ACTIONS_RADARR.read())
        ArrPilotModule.RADARR.shortcutItem,
      if (ArrPilotDatabase.QUICK_ACTIONS_OVERSEERR.read())
        ArrPilotModule.OVERSEERR.shortcutItem,
      if (ArrPilotDatabase.QUICK_ACTIONS_NZBGET.read())
        ArrPilotModule.NZBGET.shortcutItem,
      if (ArrPilotDatabase.QUICK_ACTIONS_LIDARR.read())
        ArrPilotModule.LIDARR.shortcutItem,
      ArrPilotModule.SETTINGS.shortcutItem,
    ]);
  }
}

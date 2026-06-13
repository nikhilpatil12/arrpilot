import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:arrpilot/modules/dashboard/core/state.dart';
import 'package:arrpilot/modules/lidarr/core/state.dart';
import 'package:arrpilot/modules/radarr/core/state.dart';
import 'package:arrpilot/modules/search/core/state.dart';
import 'package:arrpilot/modules/settings/core/state.dart';
import 'package:arrpilot/modules/sonarr/core/state.dart';
import 'package:arrpilot/modules/sabnzbd/core/state.dart';
import 'package:arrpilot/modules/nzbget/core/state.dart';
import 'package:arrpilot/modules/tautulli/core/state.dart';
import 'package:arrpilot/modules.dart';
import 'package:arrpilot/router/router.dart';

class LunaState {
  LunaState._();

  static BuildContext get context => LunaRouter.navigator.currentContext!;

  /// Calls `.reset()` on all states which extend [LunaModuleState].
  static void reset([BuildContext? context]) {
    final ctx = context ?? LunaState.context;
    LunaModule.values.forEach((module) => module.state(ctx)?.reset());
  }

  static MultiProvider providers({required Widget child}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardState()),
        ChangeNotifierProvider(create: (_) => SettingsState()),
        ChangeNotifierProvider(create: (_) => SearchState()),
        ChangeNotifierProvider(create: (_) => LidarrState()),
        ChangeNotifierProvider(create: (_) => RadarrState()),
        ChangeNotifierProvider(create: (_) => SonarrState()),
        ChangeNotifierProvider(create: (_) => NZBGetState()),
        ChangeNotifierProvider(create: (_) => SABnzbdState()),
        ChangeNotifierProvider(create: (_) => TautulliState()),
      ],
      child: child,
    );
  }
}

abstract class LunaModuleState extends ChangeNotifier {
  /// Reset the state back to the default
  void reset();
}

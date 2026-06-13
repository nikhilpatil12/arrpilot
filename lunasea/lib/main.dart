import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:device_preview/device_preview.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/database/database.dart';
import 'package:arrpilot/router/router.dart';
import 'package:arrpilot/system/cache/image/image_cache.dart';
import 'package:arrpilot/system/cache/memory/memory_store.dart';
import 'package:arrpilot/system/network/network.dart';
import 'package:arrpilot/system/recovery_mode/main.dart';
import 'package:arrpilot/system/window_manager/window_manager.dart';
import 'package:arrpilot/system/platform.dart';

/// ArrPilot Entry Point: Bootstrap & Run Application
///
/// Runs app in guarded zone to attempt to capture fatal (crashing) errors
Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      try {
        await bootstrap();
        runApp(const ArrPilotBIOS());
      } catch (error) {
        runApp(const ArrPilotRecoveryMode());
      }
    },
    (error, stack) => ArrPilotLogger().critical(error, stack),
  );
}

/// Bootstrap the core
///
Future<void> bootstrap() async {
  await ArrPilotDatabaseService().initialize();
  ArrPilotLogger().initialize();
  ArrPilotTheme().initialize();
  if (ArrPilotWindowManager.isSupported)
    await ArrPilotWindowManager().initialize();
  if (ArrPilotNetwork.isSupported) ArrPilotNetwork().initialize();
  if (ArrPilotImageCache.isSupported) ArrPilotImageCache().initialize();
  ArrPilotRouter().initialize();
  await ArrPilotMemoryStore().initialize();
}

class ArrPilotBIOS extends StatelessWidget {
  const ArrPilotBIOS({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ArrPilotTheme();
    final router = ArrPilotRouter.router;

    return ArrPilotState.providers(
      child: DevicePreview(
        enabled: kDebugMode && ArrPilotPlatform.isDesktop,
        builder: (context) => EasyLocalization(
          supportedLocales: [Locale('en')],
          path: 'assets/localization',
          fallbackLocale: Locale('en'),
          startLocale: Locale('en'),
          useFallbackTranslations: true,
          child: ArrPilotBox.arrpilot.listenableBuilder(
            selectItems: [
              ArrPilotDatabase.THEME_AMOLED,
              ArrPilotDatabase.THEME_AMOLED_BORDER,
            ],
            builder: (context, _) {
              return MaterialApp.router(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                builder: DevicePreview.appBuilder,
                darkTheme: theme.activeTheme(),
                theme: theme.activeTheme(),
                title: 'ArrPilot',
                routeInformationProvider: router.routeInformationProvider,
                routeInformationParser: router.routeInformationParser,
                routerDelegate: router.routerDelegate,
              );
            },
          ),
        ),
      ),
    );
  }
}

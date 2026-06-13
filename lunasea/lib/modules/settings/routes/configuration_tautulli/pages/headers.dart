import 'package:flutter/material.dart';
import 'package:arrpilot/modules.dart';
import 'package:arrpilot/modules/settings.dart';

class ConfigurationTautulliConnectionDetailsHeadersRoute
    extends StatelessWidget {
  const ConfigurationTautulliConnectionDetailsHeadersRoute({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SettingsHeaderRoute(module: LunaModule.TAUTULLI);
  }
}

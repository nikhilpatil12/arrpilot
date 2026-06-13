import 'package:flutter/material.dart';
import 'package:arrpilot/modules.dart';
import 'package:arrpilot/modules/settings.dart';

class ConfigurationRadarrConnectionDetailsHeadersRoute extends StatelessWidget {
  const ConfigurationRadarrConnectionDetailsHeadersRoute({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SettingsHeaderRoute(module: ArrPilotModule.RADARR);
  }
}

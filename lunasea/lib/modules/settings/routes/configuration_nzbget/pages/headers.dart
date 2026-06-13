import 'package:flutter/material.dart';
import 'package:arrpilot/modules.dart';
import 'package:arrpilot/modules/settings.dart';

class ConfigurationNZBGetConnectionDetailsHeadersRoute extends StatelessWidget {
  const ConfigurationNZBGetConnectionDetailsHeadersRoute({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SettingsHeaderRoute(module: ArrPilotModule.NZBGET);
  }
}

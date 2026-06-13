import 'package:flutter/material.dart';

import 'package:arrpilot/core.dart';
import 'package:arrpilot/router/routes/settings.dart';

class SettingsRoute extends StatefulWidget {
  const SettingsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsRoute> createState() => _State();
}

class _State extends State<SettingsRoute> with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      drawer: _drawer(),
      body: _body(),
    );
  }

  Widget _drawer() => ArrPilotDrawer(page: ArrPilotModule.SETTINGS.key);

  PreferredSizeWidget _appBar() {
    return ArrPilotAppBar(
      useDrawer: true,
      scrollControllers: [scrollController],
      title: ArrPilotModule.SETTINGS.title,
    );
  }

  Widget _body() {
    return ArrPilotListView(
      controller: scrollController,
      children: [
        ArrPilotBlock(
          title: 'settings.Configuration'.tr(),
          body: [TextSpan(text: 'settings.ConfigurationDescription'.tr())],
          trailing: const ArrPilotIconButton(icon: Icons.device_hub_rounded),
          onTap: SettingsRoutes.CONFIGURATION.go,
        ),
        ArrPilotBlock(
          title: 'settings.Profiles'.tr(),
          body: [TextSpan(text: 'settings.ProfilesDescription'.tr())],
          trailing: const ArrPilotIconButton(icon: Icons.switch_account_rounded),
          onTap: SettingsRoutes.PROFILES.go,
        ),
        ArrPilotBlock(
          title: 'settings.System'.tr(),
          body: [TextSpan(text: 'settings.SystemDescription'.tr())],
          trailing: const ArrPilotIconButton(icon: Icons.settings_rounded),
          onTap: SettingsRoutes.SYSTEM.go,
        ),
      ],
    );
  }
}

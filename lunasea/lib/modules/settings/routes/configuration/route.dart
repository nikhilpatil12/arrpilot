import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/settings.dart';
import 'package:arrpilot/router/routes/settings.dart';
import 'package:arrpilot/system/quick_actions/quick_actions.dart';
import 'package:arrpilot/utils/profile_tools.dart';

class ConfigurationRoute extends StatefulWidget {
  const ConfigurationRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationRoute> createState() => _State();
}

class _State extends State<ConfigurationRoute> with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return ArrPilotAppBar(
      title: 'settings.Configuration'.tr(),
      scrollControllers: [scrollController],
      actions: [_enabledProfile()],
    );
  }

  Widget _enabledProfile() {
    return ArrPilotBox.profiles.listenableBuilder(
      builder: (context, _) {
        if (ArrPilotBox.profiles.size < 2) return const SizedBox();
        return ArrPilotIconButton(
          icon: Icons.switch_account_rounded,
          onPressed: () async {
            final dialogs = SettingsDialogs();
            final enabledProfile = ArrPilotDatabase.ENABLED_PROFILE.read();
            final profiles = ArrPilotProfile.list;
            profiles.removeWhere((p) => p == enabledProfile);

            if (profiles.isEmpty) {
              showLunaInfoSnackBar(
                title: 'settings.NoProfilesFound'.tr(),
                message: 'settings.NoAdditionalProfilesAdded'.tr(),
              );
              return;
            }

            final selected = await dialogs.enabledProfile(
              ArrPilotState.context,
              profiles,
            );
            if (selected.item1) {
              ArrPilotProfileTools().changeTo(selected.item2);
            }
          },
        );
      },
    );
  }

  Widget _body() {
    return ArrPilotListView(
      controller: scrollController,
      children: [
        ArrPilotBlock(
          title: 'settings.General'.tr(),
          body: [TextSpan(text: 'settings.GeneralDescription'.tr())],
          trailing: const ArrPilotIconButton(icon: Icons.brush_rounded),
          onTap: SettingsRoutes.CONFIGURATION_GENERAL.go,
        ),
        ArrPilotBlock(
          title: 'settings.Drawer'.tr(),
          body: [TextSpan(text: 'settings.DrawerDescription'.tr())],
          trailing: const ArrPilotIconButton(icon: Icons.menu_rounded),
          onTap: SettingsRoutes.CONFIGURATION_DRAWER.go,
        ),
        if (ArrPilotQuickActions.isSupported)
          ArrPilotBlock(
            title: 'settings.QuickActions'.tr(),
            body: [TextSpan(text: 'settings.QuickActionsDescription'.tr())],
            trailing: const ArrPilotIconButton(icon: Icons.rounded_corner_rounded),
            onTap: SettingsRoutes.CONFIGURATION_QUICK_ACTIONS.go,
          ),
        ArrPilotDivider(),
        ..._moduleList(),
      ],
    );
  }

  List<Widget> _moduleList() {
    return ([ArrPilotModule.DASHBOARD, ...ArrPilotModule.active])
        .map(_tileFromModuleMap)
        .toList();
  }

  Widget _tileFromModuleMap(ArrPilotModule module) {
    return ArrPilotBlock(
      title: module.title,
      body: [
        TextSpan(text: 'settings.ConfigureModule'.tr(args: [module.title]))
      ],
      trailing: ArrPilotIconButton(icon: module.icon),
      onTap: module.settingsRoute!.go,
    );
  }
}

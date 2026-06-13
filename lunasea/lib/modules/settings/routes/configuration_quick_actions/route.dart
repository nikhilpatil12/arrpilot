import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/settings.dart';
import 'package:arrpilot/system/quick_actions/quick_actions.dart';

class ConfigurationQuickActionsRoute extends StatefulWidget {
  const ConfigurationQuickActionsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationQuickActionsRoute> createState() => _State();
}

class _State extends State<ConfigurationQuickActionsRoute>
    with ArrPilotScrollControllerMixin {
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
      scrollControllers: [scrollController],
      title: 'settings.QuickActions'.tr(),
    );
  }

  Widget _body() {
    return ArrPilotListView(
      controller: scrollController,
      children: [
        SettingsBanners.QUICK_ACTIONS_SUPPORT.banner(),
        _actionTile(
          ArrPilotModule.LIDARR.title,
          ArrPilotDatabase.QUICK_ACTIONS_LIDARR,
        ),
        _actionTile(
          ArrPilotModule.NZBGET.title,
          ArrPilotDatabase.QUICK_ACTIONS_NZBGET,
        ),
        if (ArrPilotModule.OVERSEERR.featureFlag)
          _actionTile(
            ArrPilotModule.OVERSEERR.title,
            ArrPilotDatabase.QUICK_ACTIONS_OVERSEERR,
          ),
        _actionTile(
          ArrPilotModule.RADARR.title,
          ArrPilotDatabase.QUICK_ACTIONS_RADARR,
        ),
        _actionTile(
          ArrPilotModule.SABNZBD.title,
          ArrPilotDatabase.QUICK_ACTIONS_SABNZBD,
        ),
        _actionTile(
          ArrPilotModule.SEARCH.title,
          ArrPilotDatabase.QUICK_ACTIONS_SEARCH,
        ),
        _actionTile(
          ArrPilotModule.SONARR.title,
          ArrPilotDatabase.QUICK_ACTIONS_SONARR,
        ),
        _actionTile(
          ArrPilotModule.TAUTULLI.title,
          ArrPilotDatabase.QUICK_ACTIONS_TAUTULLI,
        ),
      ],
    );
  }

  Widget _actionTile(String title, ArrPilotDatabase action) {
    return ArrPilotBlock(
      title: title,
      trailing: ArrPilotBox.arrpilot.listenableBuilder(
        selectKeys: [action.key],
        builder: (context, _) => ArrPilotSwitch(
          value: action.read(),
          onChanged: (value) {
            action.update(value);
            if (ArrPilotQuickActions.isSupported)
              ArrPilotQuickActions().setActionItems();
          },
        ),
      ),
    );
  }
}

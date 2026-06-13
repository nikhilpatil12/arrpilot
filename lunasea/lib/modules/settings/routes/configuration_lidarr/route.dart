import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/lidarr.dart';
import 'package:arrpilot/router/routes/settings.dart';

class ConfigurationLidarrRoute extends StatefulWidget {
  const ConfigurationLidarrRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationLidarrRoute> createState() => _State();
}

class _State extends State<ConfigurationLidarrRoute>
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
      title: ArrPilotModule.LIDARR.title,
    );
  }

  Widget _body() {
    return ArrPilotListView(
      controller: scrollController,
      children: [
        ArrPilotModule.LIDARR.informationBanner(),
        _enabledToggle(),
        _connectionDetailsPage(),
        ArrPilotDivider(),
        _defaultPagesPage(),
        //_defaultPagesPage(),
      ],
    );
  }

  Widget _enabledToggle() {
    return ArrPilotBox.profiles.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'settings.EnableModule'.tr(args: [ArrPilotModule.LIDARR.title]),
        trailing: ArrPilotSwitch(
          value: ArrPilotProfile.current.lidarrEnabled,
          onChanged: (value) {
            ArrPilotProfile.current.lidarrEnabled = value;
            ArrPilotProfile.current.save();
            context.read<LidarrState>().reset();
          },
        ),
      ),
    );
  }

  Widget _connectionDetailsPage() {
    return ArrPilotBlock(
      title: 'settings.ConnectionDetails'.tr(),
      body: [
        TextSpan(
          text: 'settings.ConnectionDetailsDescription'.tr(
            args: [ArrPilotModule.LIDARR.title],
          ),
        ),
      ],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_LIDARR_CONNECTION_DETAILS.go,
    );
  }

  Widget _defaultPagesPage() {
    return ArrPilotBlock(
      title: 'settings.DefaultPages'.tr(),
      body: [TextSpan(text: 'settings.DefaultPagesDescription'.tr())],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_LIDARR_DEFAULT_PAGES.go,
    );
  }
}

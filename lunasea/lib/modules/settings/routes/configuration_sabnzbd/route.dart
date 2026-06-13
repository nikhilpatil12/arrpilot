import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/sabnzbd.dart';
import 'package:arrpilot/router/routes/settings.dart';

class ConfigurationSABnzbdRoute extends StatefulWidget {
  const ConfigurationSABnzbdRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationSABnzbdRoute> createState() => _State();
}

class _State extends State<ConfigurationSABnzbdRoute>
    with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return ArrPilotAppBar(
      title: ArrPilotModule.SABNZBD.title,
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return ArrPilotListView(
      controller: scrollController,
      children: [
        ArrPilotModule.SABNZBD.informationBanner(),
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
        title: 'settings.EnableModule'.tr(args: [ArrPilotModule.SABNZBD.title]),
        trailing: ArrPilotSwitch(
          value: ArrPilotProfile.current.sabnzbdEnabled,
          onChanged: (value) {
            ArrPilotProfile.current.sabnzbdEnabled = value;
            ArrPilotProfile.current.save();
            context.read<SABnzbdState>().reset();
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
            args: [ArrPilotModule.SABNZBD.title],
          ),
        )
      ],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_SABNZBD_CONNECTION_DETAILS.go,
    );
  }

  Widget _defaultPagesPage() {
    return ArrPilotBlock(
      title: 'settings.DefaultPages'.tr(),
      body: [TextSpan(text: 'settings.DefaultPagesDescription'.tr())],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_SABNZBD_DEFAULT_PAGES.go,
    );
  }
}

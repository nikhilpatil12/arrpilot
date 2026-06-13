import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/nzbget.dart';
import 'package:arrpilot/router/routes/settings.dart';

class ConfigurationNZBGetRoute extends StatefulWidget {
  const ConfigurationNZBGetRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationNZBGetRoute> createState() => _State();
}

class _State extends State<ConfigurationNZBGetRoute>
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
      title: ArrPilotModule.NZBGET.title,
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return ArrPilotListView(
      controller: scrollController,
      children: [
        ArrPilotModule.NZBGET.informationBanner(),
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
        title: 'settings.EnableModule'.tr(args: [ArrPilotModule.NZBGET.title]),
        trailing: ArrPilotSwitch(
          value: ArrPilotProfile.current.nzbgetEnabled,
          onChanged: (value) {
            ArrPilotProfile.current.nzbgetEnabled = value;
            ArrPilotProfile.current.save();
            context.read<NZBGetState>().reset();
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
          text: 'settings.ConnectionDetailsDescription'
              .tr(args: [ArrPilotModule.NZBGET.title]),
        ),
      ],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_NZBGET_CONNECTION_DETAILS.go,
    );
  }

  Widget _defaultPagesPage() {
    return ArrPilotBlock(
      title: 'settings.DefaultPages'.tr(),
      body: [TextSpan(text: 'settings.DefaultPagesDescription'.tr())],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_NZBGET_DEFAULT_PAGES.go,
    );
  }
}

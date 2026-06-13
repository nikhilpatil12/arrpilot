import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/sonarr.dart';
import 'package:arrpilot/router/routes/settings.dart';

class ConfigurationSonarrRoute extends StatefulWidget {
  const ConfigurationSonarrRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationSonarrRoute> createState() => _State();
}

class _State extends State<ConfigurationSonarrRoute>
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
      title: ArrPilotModule.SONARR.title,
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return ArrPilotListView(
      controller: scrollController,
      children: [
        ArrPilotModule.SONARR.informationBanner(),
        _enabledToggle(),
        _connectionDetailsPage(),
        ArrPilotDivider(),
        _defaultOptionsPage(),
        _defaultPagesPage(),
        _queueSize(),
      ],
    );
  }

  Widget _enabledToggle() {
    return ArrPilotBox.profiles.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'settings.EnableModule'.tr(args: [ArrPilotModule.SONARR.title]),
        trailing: ArrPilotSwitch(
          value: ArrPilotProfile.current.sonarrEnabled,
          onChanged: (value) {
            ArrPilotProfile.current.sonarrEnabled = value;
            ArrPilotProfile.current.save();
            context.read<SonarrState>().reset();
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
            args: [ArrPilotModule.SONARR.title],
          ),
        )
      ],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_SONARR_CONNECTION_DETAILS.go,
    );
  }

  Widget _defaultPagesPage() {
    return ArrPilotBlock(
      title: 'settings.DefaultPages'.tr(),
      body: [TextSpan(text: 'settings.DefaultPagesDescription'.tr())],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_SONARR_DEFAULT_PAGES.go,
    );
  }

  Widget _defaultOptionsPage() {
    return ArrPilotBlock(
      title: 'settings.DefaultOptions'.tr(),
      body: [
        TextSpan(text: 'settings.DefaultOptionsDescription'.tr()),
      ],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_SONARR_DEFAULT_OPTIONS.go,
    );
  }

  Widget _queueSize() {
    const _db = SonarrDatabase.QUEUE_PAGE_SIZE;
    return _db.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'sonarr.QueueSize'.tr(),
        body: [
          TextSpan(
            text: _db.read() == 1
                ? 'lunasea.OneItem'.tr()
                : 'lunasea.Items'.tr(args: [_db.read().toString()]),
          ),
        ],
        trailing: const ArrPilotIconButton(icon: Icons.queue_play_next_rounded),
        onTap: () async {
          Tuple2<bool, int> result =
              await SonarrDialogs().setQueuePageSize(context);
          if (result.item1) _db.update(result.item2);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';
import 'package:arrpilot/router/routes/settings.dart';

class ConfigurationRadarrRoute extends StatefulWidget {
  const ConfigurationRadarrRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationRadarrRoute> createState() => _State();
}

class _State extends State<ConfigurationRadarrRoute>
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
      title: ArrPilotModule.RADARR.title,
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return ArrPilotListView(
      controller: scrollController,
      children: [
        ArrPilotModule.RADARR.informationBanner(),
        _enabledToggle(),
        _connectionDetailsPage(),
        ArrPilotDivider(),
        _defaultOptionsPage(),
        _defaultPagesPage(),
        _discoverUseRadarrSuggestionsToggle(),
        _queueSize(),
      ],
    );
  }

  Widget _enabledToggle() {
    return ArrPilotBox.profiles.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'settings.EnableModule'.tr(args: [ArrPilotModule.RADARR.title]),
        trailing: ArrPilotSwitch(
          value: ArrPilotProfile.current.radarrEnabled,
          onChanged: (value) {
            ArrPilotProfile.current.radarrEnabled = value;
            ArrPilotProfile.current.save();
            context.read<RadarrState>().reset();
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
            args: [ArrPilotModule.RADARR.title],
          ),
        ),
      ],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_RADARR_CONNECTION_DETAILS.go,
    );
  }

  Widget _defaultOptionsPage() {
    return ArrPilotBlock(
      title: 'settings.DefaultOptions'.tr(),
      body: [TextSpan(text: 'settings.DefaultOptionsDescription'.tr())],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_RADARR_DEFAULT_OPTIONS.go,
    );
  }

  Widget _defaultPagesPage() {
    return ArrPilotBlock(
      title: 'settings.DefaultPages'.tr(),
      body: [TextSpan(text: 'settings.DefaultPagesDescription'.tr())],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_RADARR_DEFAULT_PAGES.go,
    );
  }

  Widget _discoverUseRadarrSuggestionsToggle() {
    const _db = RadarrDatabase.ADD_DISCOVER_USE_SUGGESTIONS;
    return _db.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'radarr.DiscoverSuggestions'.tr(),
        body: [TextSpan(text: 'radarr.DiscoverSuggestionsDescription'.tr())],
        trailing: ArrPilotSwitch(
          value: _db.read(),
          onChanged: (value) => _db.update(value),
        ),
      ),
    );
  }

  Widget _queueSize() {
    const _db = RadarrDatabase.QUEUE_PAGE_SIZE;
    return _db.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'radarr.QueueSize'.tr(),
        body: [
          TextSpan(
            text: _db.read() == 1
                ? 'arrpilot.OneItem'.tr()
                : 'arrpilot.Items'.tr(args: [_db.read().toString()]),
          ),
        ],
        trailing: const ArrPilotIconButton(icon: Icons.queue_play_next_rounded),
        onTap: () async {
          Tuple2<bool, int> result =
              await RadarrDialogs().setQueuePageSize(context);
          if (result.item1) _db.update(result.item2);
        },
      ),
    );
  }
}

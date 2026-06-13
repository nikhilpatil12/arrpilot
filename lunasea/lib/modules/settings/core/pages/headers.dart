import 'package:flutter/material.dart';

import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';
import 'package:arrpilot/modules/sonarr.dart';
import 'package:arrpilot/modules/settings.dart';
import 'package:arrpilot/modules/tautulli.dart';

class SettingsHeaderRoute extends StatefulWidget {
  final ArrPilotModule module;

  const SettingsHeaderRoute({
    Key? key,
    required this.module,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsHeaderRoute> with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
      bottomNavigationBar: _bottomActionBar(),
    );
  }

  Widget _bottomActionBar() {
    return ArrPilotBottomActionBar(
      actions: [
        ArrPilotButton.text(
            text: 'settings.AddHeader'.tr(),
            icon: Icons.add_rounded,
            onTap: () async {
              await HeaderUtility().addHeader(context, headers: _headers());
              _resetState();
            }),
      ],
    );
  }

  Widget _appBar() {
    return ArrPilotAppBar(
      title: 'settings.CustomHeaders'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return ArrPilotBox.profiles.listenableBuilder(
      builder: (context, _) => ArrPilotListView(
        controller: scrollController,
        children: [
          if ((_headers()).isEmpty) _noHeadersFound(),
          ..._headerList(),
        ],
      ),
    );
  }

  Widget _noHeadersFound() =>
      ArrPilotMessage.inList(text: 'settings.NoHeadersAdded'.tr());

  List<ArrPilotBlock> _headerList() {
    final headers = _headers();
    List<String> _sortedKeys = headers.keys.toList()..sort();
    return _sortedKeys
        .map<ArrPilotBlock>((key) => _headerBlock(key, headers[key]))
        .toList();
  }

  ArrPilotBlock _headerBlock(String key, String? value) {
    return ArrPilotBlock(
      title: key,
      body: [TextSpan(text: value)],
      trailing: ArrPilotIconButton(
          icon: ArrPilotIcons.DELETE,
          color: ArrPilotColours.red,
          onPressed: () async {
            await HeaderUtility().deleteHeader(
              context,
              key: key,
              headers: _headers(),
            );
            _resetState();
          }),
    );
  }

  Map<String, String> _headers() {
    switch (widget.module) {
      case ArrPilotModule.DASHBOARD:
        throw Exception('Dashboard does not have a headers page');
      case ArrPilotModule.EXTERNAL_MODULES:
        throw Exception('External modules do not have a headers page');
      case ArrPilotModule.LIDARR:
        return ArrPilotProfile.current.lidarrHeaders;
      case ArrPilotModule.RADARR:
        return ArrPilotProfile.current.radarrHeaders;
      case ArrPilotModule.SONARR:
        return ArrPilotProfile.current.sonarrHeaders;
      case ArrPilotModule.SABNZBD:
        return ArrPilotProfile.current.sabnzbdHeaders;
      case ArrPilotModule.NZBGET:
        return ArrPilotProfile.current.nzbgetHeaders;
      case ArrPilotModule.SEARCH:
        throw Exception('Search does not have a headers page');
      case ArrPilotModule.SETTINGS:
        throw Exception('Settings does not have a headers page');
      case ArrPilotModule.WAKE_ON_LAN:
        throw Exception('Wake on LAN does not have a headers page');
      case ArrPilotModule.OVERSEERR:
        throw Exception('Overseerr does not have a headers page');
      case ArrPilotModule.TAUTULLI:
        return ArrPilotProfile.current.tautulliHeaders;
    }
  }

  Future<void> _resetState() async {
    switch (widget.module) {
      case ArrPilotModule.DASHBOARD:
        throw Exception('Dashboard does not have a global state');
      case ArrPilotModule.EXTERNAL_MODULES:
        throw Exception('External modules do not have a global state');
      case ArrPilotModule.LIDARR:
        return;
      case ArrPilotModule.RADARR:
        return context.read<RadarrState>().reset();
      case ArrPilotModule.SONARR:
        return context.read<SonarrState>().reset();
      case ArrPilotModule.SABNZBD:
        return;
      case ArrPilotModule.NZBGET:
        return;
      case ArrPilotModule.SEARCH:
        throw Exception('Search does not have a global state');
      case ArrPilotModule.SETTINGS:
        throw Exception('Settings does not have a global state');
      case ArrPilotModule.WAKE_ON_LAN:
        throw Exception('Wake on LAN does not have a global state');
      case ArrPilotModule.TAUTULLI:
        return context.read<TautulliState>().reset();
      case ArrPilotModule.OVERSEERR:
        return;
    }
  }
}

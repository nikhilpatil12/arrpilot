import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/settings.dart';
import 'package:arrpilot/modules/sonarr.dart';
import 'package:arrpilot/router/routes/settings.dart';

class ConfigurationSonarrConnectionDetailsRoute extends StatefulWidget {
  const ConfigurationSonarrConnectionDetailsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationSonarrConnectionDetailsRoute> createState() => _State();
}

class _State extends State<ConfigurationSonarrConnectionDetailsRoute>
    with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: _bottomActionBar(),
    );
  }

  PreferredSizeWidget _appBar() {
    return ArrPilotAppBar(
      title: 'settings.ConnectionDetails'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _bottomActionBar() {
    return ArrPilotBottomActionBar(
      actions: [
        _testConnection(),
      ],
    );
  }

  Widget _body() {
    return ArrPilotBox.profiles.listenableBuilder(
      builder: (context, _) => ArrPilotListView(
        controller: scrollController,
        children: [
          _host(),
          _apiKey(),
          _customHeaders(),
        ],
      ),
    );
  }

  Widget _host() {
    String host = ArrPilotProfile.current.sonarrHost;
    return ArrPilotBlock(
      title: 'settings.Host'.tr(),
      body: [TextSpan(text: host.isEmpty ? 'lunasea.NotSet'.tr() : host)],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values = await SettingsDialogs().editHost(
          context,
          prefill: host,
        );
        if (_values.item1) {
          ArrPilotProfile.current.sonarrHost = _values.item2;
          ArrPilotProfile.current.save();
          context.read<SonarrState>().reset();
        }
      },
    );
  }

  Widget _apiKey() {
    String apiKey = ArrPilotProfile.current.sonarrKey;
    return ArrPilotBlock(
      title: 'settings.ApiKey'.tr(),
      body: [
        TextSpan(
          text: apiKey.isEmpty
              ? 'lunasea.NotSet'.tr()
              : ArrPilotUI.TEXT_OBFUSCATED_PASSWORD,
        ),
      ],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values = await ArrPilotDialogs().editText(
          context,
          'settings.ApiKey'.tr(),
          prefill: apiKey,
        );
        if (_values.item1) {
          ArrPilotProfile.current.sonarrKey = _values.item2;
          ArrPilotProfile.current.save();
          context.read<SonarrState>().reset();
        }
      },
    );
  }

  Widget _testConnection() {
    return ArrPilotButton.text(
      text: 'settings.TestConnection'.tr(),
      icon: ArrPilotIcons.CONNECTION_TEST,
      onTap: () async {
        ArrPilotProfile _profile = ArrPilotProfile.current;
        if (_profile.sonarrHost.isEmpty) {
          showLunaErrorSnackBar(
            title: 'settings.HostRequired'.tr(),
            message: 'settings.HostRequiredMessage'
                .tr(args: [ArrPilotModule.SONARR.title]),
          );
          return;
        }
        if (_profile.sonarrKey.isEmpty) {
          showLunaErrorSnackBar(
            title: 'settings.ApiKeyRequired'.tr(),
            message: 'settings.ApiKeyRequiredMessage'
                .tr(args: [ArrPilotModule.SONARR.title]),
          );
          return;
        }
        SonarrAPI(
          host: _profile.sonarrHost,
          apiKey: _profile.sonarrKey,
          headers: Map<String, dynamic>.from(
            _profile.sonarrHeaders,
          ),
        ).system.getStatus().then((_) {
          showLunaSuccessSnackBar(
            title: 'settings.ConnectedSuccessfully'.tr(),
            message: 'settings.ConnectedSuccessfullyMessage'
                .tr(args: [ArrPilotModule.SONARR.title]),
          );
        }).catchError((error, trace) {
          ArrPilotLogger().error(
            'Connection Test Failed',
            error,
            trace,
          );
          showLunaErrorSnackBar(
            title: 'settings.ConnectionTestFailed'.tr(),
            error: error,
          );
        });
      },
    );
  }

  Widget _customHeaders() {
    return ArrPilotBlock(
      title: 'settings.CustomHeaders'.tr(),
      body: [TextSpan(text: 'settings.CustomHeadersDescription'.tr())],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_SONARR_CONNECTION_DETAILS_HEADERS.go,
    );
  }
}

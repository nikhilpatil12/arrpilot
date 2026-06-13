import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';
import 'package:arrpilot/modules/settings.dart';
import 'package:arrpilot/router/routes/settings.dart';

class ConfigurationRadarrConnectionDetailsRoute extends StatefulWidget {
  const ConfigurationRadarrConnectionDetailsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationRadarrConnectionDetailsRoute> createState() => _State();
}

class _State extends State<ConfigurationRadarrConnectionDetailsRoute>
    with ArrPilotScrollControllerMixin {
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

  Widget _appBar() {
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
    String host = ArrPilotProfile.current.radarrHost;
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
          ArrPilotProfile.current.radarrHost = _values.item2;
          ArrPilotProfile.current.save();
          context.read<RadarrState>().reset();
        }
      },
    );
  }

  Widget _apiKey() {
    String apiKey = ArrPilotProfile.current.radarrKey;
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
          ArrPilotProfile.current.radarrKey = _values.item2;
          ArrPilotProfile.current.save();
          context.read<RadarrState>().reset();
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
        if (_profile.radarrHost.isEmpty) {
          showLunaErrorSnackBar(
            title: 'settings.HostRequired'.tr(),
            message: 'settings.HostRequiredMessage'
                .tr(args: [ArrPilotModule.RADARR.title]),
          );
          return;
        }
        if (_profile.radarrKey.isEmpty) {
          showLunaErrorSnackBar(
            title: 'settings.ApiKeyRequired'.tr(),
            message: 'settings.ApiKeyRequiredMessage'
                .tr(args: [ArrPilotModule.RADARR.title]),
          );
          return;
        }
        RadarrAPI(
          host: _profile.radarrHost,
          apiKey: _profile.radarrKey,
          headers: Map<String, dynamic>.from(_profile.radarrHeaders),
        )
            .system
            .status()
            .then(
              (_) => showLunaSuccessSnackBar(
                title: 'settings.ConnectedSuccessfully'.tr(),
                message: 'settings.ConnectedSuccessfullyMessage'
                    .tr(args: [ArrPilotModule.RADARR.title]),
              ),
            )
            .catchError(
          (error, trace) {
            ArrPilotLogger().error(
              'Connection Test Failed',
              error,
              trace,
            );
            showLunaErrorSnackBar(
              title: 'settings.ConnectionTestFailed'.tr(),
              error: error,
            );
          },
        );
      },
    );
  }

  Widget _customHeaders() {
    return ArrPilotBlock(
      title: 'settings.CustomHeaders'.tr(),
      body: [TextSpan(text: 'settings.CustomHeadersDescription'.tr())],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_RADARR_CONNECTION_DETAILS_HEADERS.go,
    );
  }
}

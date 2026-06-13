import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/sabnzbd.dart';
import 'package:arrpilot/modules/settings.dart';
import 'package:arrpilot/router/routes/settings.dart';

class ConfigurationSABnzbdConnectionDetailsRoute extends StatefulWidget {
  const ConfigurationSABnzbdConnectionDetailsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationSABnzbdConnectionDetailsRoute> createState() => _State();
}

class _State extends State<ConfigurationSABnzbdConnectionDetailsRoute>
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
    String host = ArrPilotProfile.current.sabnzbdHost;
    return ArrPilotBlock(
      title: 'settings.Host'.tr(),
      body: [TextSpan(text: host.isEmpty ? 'arrpilot.NotSet'.tr() : host)],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values = await SettingsDialogs().editHost(
          context,
          prefill: host,
        );
        if (_values.item1) {
          ArrPilotProfile.current.sabnzbdHost = _values.item2;
          ArrPilotProfile.current.save();
          context.read<SABnzbdState>().reset();
        }
      },
    );
  }

  Widget _apiKey() {
    String apiKey = ArrPilotProfile.current.sabnzbdKey;
    return ArrPilotBlock(
      title: 'settings.ApiKey'.tr(),
      body: [
        TextSpan(
          text: apiKey.isEmpty
              ? 'arrpilot.NotSet'.tr()
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
          ArrPilotProfile.current.sabnzbdKey = _values.item2;
          ArrPilotProfile.current.save();
          context.read<SABnzbdState>().reset();
        }
      },
    );
  }

  Widget _testConnection() {
    return ArrPilotButton.text(
      text: 'settings.TestConnection'.tr(),
      icon: Icons.wifi_tethering_rounded,
      onTap: () async {
        ArrPilotProfile _profile = ArrPilotProfile.current;
        if (_profile.sabnzbdHost.isEmpty) {
          showLunaErrorSnackBar(
            title: 'settings.HostRequired'.tr(),
            message: 'settings.HostRequiredMessage'
                .tr(args: [ArrPilotModule.SABNZBD.title]),
          );
          return;
        }
        if (_profile.sabnzbdKey.isEmpty) {
          showLunaErrorSnackBar(
            title: 'settings.ApiKeyRequired'.tr(),
            message: 'settings.ApiKeyRequiredMessage'
                .tr(args: [ArrPilotModule.SABNZBD.title]),
          );
          return;
        }
        SABnzbdAPI.from(ArrPilotProfile.current)
            .testConnection()
            .then((_) => showLunaSuccessSnackBar(
                  title: 'settings.ConnectedSuccessfully'.tr(),
                  message: 'settings.ConnectedSuccessfullyMessage'
                      .tr(args: [ArrPilotModule.SABNZBD.title]),
                ))
            .catchError((error, trace) {
          ArrPilotLogger().error('Connection Test Failed', error, trace);
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
      onTap: SettingsRoutes.CONFIGURATION_SABNZBD_CONNECTION_DETAILS_HEADERS.go,
    );
  }
}

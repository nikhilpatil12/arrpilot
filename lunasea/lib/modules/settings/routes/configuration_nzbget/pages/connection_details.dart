import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/nzbget.dart';
import 'package:arrpilot/modules/settings.dart';
import 'package:arrpilot/router/routes/settings.dart';

class ConfigurationNZBGetConnectionDetailsRoute extends StatefulWidget {
  const ConfigurationNZBGetConnectionDetailsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationNZBGetConnectionDetailsRoute> createState() => _State();
}

class _State extends State<ConfigurationNZBGetConnectionDetailsRoute>
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
          _username(),
          _password(),
          _customHeaders(),
        ],
      ),
    );
  }

  Widget _host() {
    String host = ArrPilotProfile.current.nzbgetHost;
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
          ArrPilotProfile.current.nzbgetHost = _values.item2;
          ArrPilotProfile.current.save();
          context.read<NZBGetState>().reset();
        }
      },
    );
  }

  Widget _username() {
    String username = ArrPilotProfile.current.nzbgetUser;
    return ArrPilotBlock(
      title: 'settings.Username'.tr(),
      body: [
        TextSpan(text: username.isEmpty ? 'arrpilot.NotSet'.tr() : username),
      ],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values = await ArrPilotDialogs().editText(
          context,
          'settings.Username'.tr(),
          prefill: username,
        );
        if (_values.item1) {
          ArrPilotProfile.current.nzbgetUser = _values.item2;
          ArrPilotProfile.current.save();
          context.read<NZBGetState>().reset();
        }
      },
    );
  }

  Widget _password() {
    String password = ArrPilotProfile.current.nzbgetPass;
    return ArrPilotBlock(
      title: 'settings.Password'.tr(),
      body: [
        TextSpan(
          text: password.isEmpty
              ? 'arrpilot.NotSet'.tr()
              : ArrPilotUI.TEXT_OBFUSCATED_PASSWORD,
        ),
      ],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values = await ArrPilotDialogs().editText(
          context,
          'settings.Password'.tr(),
          prefill: password,
          extraText: [
            ArrPilotDialog.textSpanContent(
              text: '${ArrPilotUI.TEXT_BULLET} ${'settings.PasswordHint1'.tr()}',
            ),
          ],
        );
        if (_values.item1) {
          ArrPilotProfile.current.nzbgetPass = _values.item2;
          ArrPilotProfile.current.save();
          context.read<NZBGetState>().reset();
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
        if (_profile.nzbgetHost.isEmpty) {
          showLunaErrorSnackBar(
            title: 'settings.HostRequired'.tr(),
            message: 'settings.HostRequiredMessage'
                .tr(args: [ArrPilotModule.NZBGET.title]),
          );
          return;
        }
        NZBGetAPI.from(ArrPilotProfile.current)
            .testConnection()
            .then((_) => showLunaSuccessSnackBar(
                  title: 'settings.ConnectedSuccessfully'.tr(),
                  message: 'settings.ConnectedSuccessfullyMessage'
                      .tr(args: [ArrPilotModule.NZBGET.title]),
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
      onTap: SettingsRoutes.CONFIGURATION_NZBGET_CONNECTION_DETAILS_HEADERS.go,
    );
  }
}

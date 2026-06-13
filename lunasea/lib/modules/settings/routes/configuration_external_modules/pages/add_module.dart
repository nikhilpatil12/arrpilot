import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/database/models/external_module.dart';
import 'package:arrpilot/modules/settings.dart';

class ConfigurationExternalModulesAddRoute extends StatefulWidget {
  const ConfigurationExternalModulesAddRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationExternalModulesAddRoute> createState() => _State();
}

class _State extends State<ConfigurationExternalModulesAddRoute>
    with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ArrPilotExternalModule _module = ArrPilotExternalModule();

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _appBar() {
    return ArrPilotAppBar(
      scrollControllers: [scrollController],
      title: 'settings.AddModule'.tr(),
    );
  }

  Widget _bottomNavigationBar() {
    return ArrPilotBottomActionBar(
      actions: [
        ArrPilotButton.text(
          text: 'settings.AddModule'.tr(),
          icon: Icons.add_rounded,
          onTap: () async {
            if (_module.displayName.isEmpty || _module.host.isEmpty) {
              showLunaErrorSnackBar(
                title: 'settings.AddModuleFailed'.tr(),
                message: 'settings.AllFieldsAreRequired'.tr(),
              );
            } else {
              ArrPilotBox.externalModules.create(_module);
              showLunaSuccessSnackBar(
                title: 'settings.AddModuleSuccess'.tr(),
                message: _module.displayName,
              );
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  Widget _body() {
    return ArrPilotListView(
      controller: scrollController,
      children: [
        _displayNameTile(),
        _hostTile(),
      ],
    );
  }

  Widget _displayNameTile() {
    String _displayName = _module.displayName;
    return ArrPilotBlock(
      title: 'settings.DisplayName'.tr(),
      body: [
        TextSpan(
          text: _displayName.isEmpty ? 'lunasea.NotSet'.tr() : _displayName,
        ),
      ],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await ArrPilotDialogs().editText(
          context,
          'settings.DisplayName'.tr(),
          prefill: _displayName,
        );
        if (values.item1) setState(() => _module.displayName = values.item2);
      },
    );
  }

  Widget _hostTile() {
    String _host = _module.host;
    return ArrPilotBlock(
      title: 'settings.Host'.tr(),
      body: [
        TextSpan(text: _host.isEmpty ? 'lunasea.NotSet'.tr() : _host),
      ],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values =
            await SettingsDialogs().editExternalModuleHost(
          context,
          prefill: _host,
        );
        if (values.item1) setState(() => _module.host = values.item2);
      },
    );
  }
}

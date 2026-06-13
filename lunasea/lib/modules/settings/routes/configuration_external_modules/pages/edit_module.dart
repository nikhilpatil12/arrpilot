import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/database/models/external_module.dart';
import 'package:arrpilot/modules/settings.dart';
import 'package:arrpilot/widgets/pages/invalid_route.dart';

class ConfigurationExternalModulesEditRoute extends StatefulWidget {
  final int moduleId;

  const ConfigurationExternalModulesEditRoute({
    Key? key,
    required this.moduleId,
  }) : super(key: key);

  @override
  State<ConfigurationExternalModulesEditRoute> createState() => _State();
}

class _State extends State<ConfigurationExternalModulesEditRoute>
    with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ArrPilotExternalModule? _module;

  @override
  Widget build(BuildContext context) {
    if (widget.moduleId < 0 ||
        !ArrPilotBox.externalModules.contains(widget.moduleId)) {
      return InvalidRoutePage(
        title: 'settings.EditModule'.tr(),
        message: 'settings.ModuleNotFound'.tr(),
      );
    }
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
      title: 'settings.EditModule'.tr(),
    );
  }

  Widget _bottomNavigationBar() {
    return ArrPilotBottomActionBar(
      actions: [
        ArrPilotButton.text(
          text: 'settings.DeleteModule'.tr(),
          icon: Icons.delete_rounded,
          color: ArrPilotColours.red,
          onTap: () async {
            bool result = await SettingsDialogs().deleteExternalModule(context);
            if (result) {
              showLunaSuccessSnackBar(
                  title: 'settings.DeleteModuleSuccess'.tr(),
                  message: _module!.displayName);
              _module!.delete();
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  Widget _body() {
    return ArrPilotBox.externalModules.listenableBuilder(
      selectKeys: [widget.moduleId],
      builder: (context, dynamic _) {
        if (!ArrPilotBox.externalModules.contains(widget.moduleId))
          return Container();
        _module = ArrPilotBox.externalModules.read(widget.moduleId);
        return ArrPilotListView(
          controller: scrollController,
          children: [
            _displayNameTile(),
            _hostTile(),
          ],
        );
      },
    );
  }

  Widget _displayNameTile() {
    String _displayName = _module!.displayName;
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
        if (values.item1) _module!.displayName = values.item2;
        _module!.save();
      },
    );
  }

  Widget _hostTile() {
    String _host = _module!.host;
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
        if (values.item1) _module!.host = values.item2;
        _module!.save();
      },
    );
  }
}

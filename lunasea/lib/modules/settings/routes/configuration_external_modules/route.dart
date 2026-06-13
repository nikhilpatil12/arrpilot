import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/database/models/external_module.dart';
import 'package:arrpilot/router/routes/settings.dart';

class ConfigurationExternalModulesRoute extends StatefulWidget {
  const ConfigurationExternalModulesRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationExternalModulesRoute> createState() => _State();
}

class _State extends State<ConfigurationExternalModulesRoute>
    with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      title: ArrPilotModule.EXTERNAL_MODULES.title,
    );
  }

  Widget _bottomNavigationBar() {
    return ArrPilotBottomActionBar(
      actions: [
        ArrPilotButton.text(
          text: 'settings.AddModule'.tr(),
          icon: Icons.add_rounded,
          onTap: SettingsRoutes.CONFIGURATION_EXTERNAL_MODULES_ADD.go,
        ),
      ],
    );
  }

  Widget _body() {
    return ArrPilotBox.externalModules.listenableBuilder(
      builder: (context, _) => ArrPilotListView(
        controller: scrollController,
        children: [
          ArrPilotModule.EXTERNAL_MODULES.informationBanner(),
          ..._moduleSection(),
        ],
      ),
    );
  }

  List<Widget> _moduleSection() => [
        if (ArrPilotBox.externalModules.isEmpty)
          ArrPilotMessage(text: 'settings.NoExternalModulesFound'.tr()),
        ..._modules,
      ];

  List<Widget> get _modules {
    final modules = ArrPilotBox.externalModules.data.toList();
    modules.sort((a, b) =>
        a.displayName.toLowerCase().compareTo(b.displayName.toLowerCase()));
    List<ArrPilotBlock> list = List.generate(
      modules.length,
      (index) => _moduleTile(modules[index], modules[index].key) as ArrPilotBlock,
    );
    return list;
  }

  Widget _moduleTile(ArrPilotExternalModule module, int index) {
    return ArrPilotBlock(
      title: module.displayName,
      body: [TextSpan(text: module.host)],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () async {
        SettingsRoutes.CONFIGURATION_EXTERNAL_MODULES_EDIT.go(params: {
          'id': index.toString(),
        });
      },
    );
  }
}

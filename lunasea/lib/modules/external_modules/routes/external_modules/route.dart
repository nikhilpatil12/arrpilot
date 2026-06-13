import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/external_modules/routes/external_modules/widgets/module_tile.dart';

class ExternalModulesRoute extends StatefulWidget {
  const ExternalModulesRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ExternalModulesRoute> createState() => _State();
}

class _State extends State<ExternalModulesRoute>
    with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      module: ArrPilotModule.EXTERNAL_MODULES,
      appBar: _appBar(),
      drawer: _drawer(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return ArrPilotAppBar(
      useDrawer: true,
      title: ArrPilotModule.EXTERNAL_MODULES.title,
      scrollControllers: [scrollController],
    );
  }

  Widget _drawer() => ArrPilotDrawer(page: ArrPilotModule.EXTERNAL_MODULES.key);

  Widget _body() {
    if (ArrPilotBox.externalModules.isEmpty) {
      return ArrPilotMessage.moduleNotEnabled(
        context: context,
        module: ArrPilotModule.EXTERNAL_MODULES.title,
      );
    }
    return ArrPilotListView(
      controller: scrollController,
      itemExtent: ArrPilotBlock.calculateItemExtent(1),
      children: _list,
    );
  }

  List<Widget> get _list {
    final list = ArrPilotBox.externalModules.data
        .map((module) => ExternalModulesModuleTile(module: module))
        .toList();
    list.sort((a, b) => a.module!.displayName
        .toLowerCase()
        .compareTo(b.module!.displayName.toLowerCase()));

    return list;
  }
}

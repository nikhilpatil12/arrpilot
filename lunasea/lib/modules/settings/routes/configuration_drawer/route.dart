import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';

class ConfigurationDrawerRoute extends StatefulWidget {
  const ConfigurationDrawerRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationDrawerRoute> createState() => _State();
}

class _State extends State<ConfigurationDrawerRoute>
    with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<ArrPilotModule>? _modules;

  @override
  void initState() {
    super.initState();
    _modules = ArrPilotDrawer.moduleOrderedList();
  }

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
      scrollControllers: [scrollController],
      title: 'settings.Drawer'.tr(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        SizedBox(height: ArrPilotUI.MARGIN_H_DEFAULT_V_HALF.bottom),
        ArrPilotBlock(
          title: 'settings.AutomaticallyManageOrder'.tr(),
          body: [
            TextSpan(text: 'settings.AutomaticallyManageOrderDescription'.tr()),
          ],
          trailing: ArrPilotDatabase.DRAWER_AUTOMATIC_MANAGE.listenableBuilder(
            builder: (context, _) => ArrPilotSwitch(
              value: ArrPilotDatabase.DRAWER_AUTOMATIC_MANAGE.read(),
              onChanged: ArrPilotDatabase.DRAWER_AUTOMATIC_MANAGE.update,
            ),
          ),
        ),
        ArrPilotDivider(),
        Expanded(
          child: ArrPilotReorderableListViewBuilder(
            padding: MediaQuery.of(context).padding.copyWith(top: 0).add(
                EdgeInsets.only(bottom: ArrPilotUI.MARGIN_H_DEFAULT_V_HALF.bottom)),
            controller: scrollController,
            itemCount: _modules!.length,
            itemBuilder: (context, index) => _reorderableModuleTile(index),
            onReorder: (oIndex, nIndex) {
              if (oIndex > _modules!.length) oIndex = _modules!.length;
              if (oIndex < nIndex) nIndex--;
              ArrPilotModule module = _modules![oIndex];
              _modules!.remove(module);
              _modules!.insert(nIndex, module);
              ArrPilotDatabase.DRAWER_MANUAL_ORDER.update(_modules!);
            },
          ),
        ),
      ],
    );
  }

  Widget _reorderableModuleTile(int index) {
    return ArrPilotDatabase.DRAWER_AUTOMATIC_MANAGE.listenableBuilder(
      key: ObjectKey(_modules![index]),
      builder: (context, _) => ArrPilotBlock(
        disabled: ArrPilotDatabase.DRAWER_AUTOMATIC_MANAGE.read(),
        title: _modules![index].title,
        body: [TextSpan(text: _modules![index].description)],
        leading: ArrPilotIconButton(icon: _modules![index].icon),
        trailing: ArrPilotDatabase.DRAWER_AUTOMATIC_MANAGE.read()
            ? null
            : ArrPilotReorderableListViewDragger(index: index),
      ),
    );
  }
}

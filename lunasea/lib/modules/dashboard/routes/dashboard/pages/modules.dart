import 'package:flutter/material.dart';

import 'package:arrpilot/modules.dart';
import 'package:arrpilot/database/models/profile.dart';
import 'package:arrpilot/database/tables/arrpilot.dart';
import 'package:arrpilot/vendor.dart';
import 'package:arrpilot/widgets/ui.dart';
import 'package:arrpilot/api/wake_on_lan/wake_on_lan.dart';
import 'package:arrpilot/modules/dashboard/routes/dashboard/widgets/navigation_bar.dart';

class ModulesPage extends StatefulWidget {
  const ModulesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ModulesPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _list();
  }

  Widget _list() {
    if (!(ArrPilotProfile.current.isAnythingEnabled())) {
      return ArrPilotMessage(
        text: 'lunasea.NoModulesEnabled'.tr(),
        buttonText: 'lunasea.GoToSettings'.tr(),
        onTap: ArrPilotModule.SETTINGS.launch,
      );
    }
    return ArrPilotListView(
      controller: HomeNavigationBar.scrollControllers[0],
      itemExtent: ArrPilotBlock.calculateItemExtent(1),
      children: ArrPilotDatabase.DRAWER_AUTOMATIC_MANAGE.read()
          ? _buildAlphabeticalList()
          : _buildManuallyOrderedList(),
    );
  }

  List<Widget> _buildAlphabeticalList() {
    List<Widget> modules = [];
    int index = 0;
    ArrPilotModule.active
      ..sort((a, b) => a.title.toLowerCase().compareTo(
            b.title.toLowerCase(),
          ))
      ..forEach((module) {
        if (module.isEnabled) {
          if (module == ArrPilotModule.WAKE_ON_LAN) {
            modules.add(_buildWakeOnLAN(context, index));
          } else {
            modules.add(_buildFromLunaModule(module, index));
          }
          index++;
        }
      });
    modules.add(_buildFromLunaModule(ArrPilotModule.SETTINGS, index));
    return modules;
  }

  List<Widget> _buildManuallyOrderedList() {
    List<Widget> modules = [];
    int index = 0;
    ArrPilotDrawer.moduleOrderedList().forEach((module) {
      if (module.isEnabled) {
        if (module == ArrPilotModule.WAKE_ON_LAN) {
          modules.add(_buildWakeOnLAN(context, index));
        } else {
          modules.add(_buildFromLunaModule(module, index));
        }
        index++;
      }
    });
    modules.add(_buildFromLunaModule(ArrPilotModule.SETTINGS, index));
    return modules;
  }

  Widget _buildFromLunaModule(ArrPilotModule module, int listIndex) {
    return ArrPilotBlock(
      title: module.title,
      body: [TextSpan(text: module.description)],
      trailing: ArrPilotIconButton(icon: module.icon, color: module.color),
      onTap: module.launch,
    );
  }

  Widget _buildWakeOnLAN(BuildContext context, int listIndex) {
    return ArrPilotBlock(
      title: ArrPilotModule.WAKE_ON_LAN.title,
      body: [TextSpan(text: ArrPilotModule.WAKE_ON_LAN.description)],
      trailing: ArrPilotIconButton(
        icon: ArrPilotModule.WAKE_ON_LAN.icon,
        color: ArrPilotModule.WAKE_ON_LAN.color,
      ),
      onTap: () async => ArrPilotWakeOnLAN().wake(),
    );
  }
}

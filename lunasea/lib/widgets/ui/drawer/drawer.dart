import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/api/wake_on_lan/wake_on_lan.dart';

class ArrPilotDrawer extends StatelessWidget {
  final String page;

  const ArrPilotDrawer({
    Key? key,
    required this.page,
  }) : super(key: key);

  static List<ArrPilotModule> moduleAlphabeticalList() {
    return ArrPilotModule.active
      ..sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
  }

  static List<ArrPilotModule> moduleOrderedList() {
    try {
      const db = ArrPilotDatabase.DRAWER_MANUAL_ORDER;
      final modules = List.from(db.read());
      final missing = ArrPilotModule.active;

      missing.retainWhere((m) => !modules.contains(m));
      modules.addAll(missing);
      modules.retainWhere((m) => (m as ArrPilotModule).featureFlag);

      return modules.cast<ArrPilotModule>();
    } catch (error, stack) {
      ArrPilotLogger().error('Failed to create ordered module list', error, stack);
      return moduleAlphabeticalList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ArrPilotDatabase.ENABLED_PROFILE.listenableBuilder(
      builder: (context, _) => ArrPilotBox.indexers.listenableBuilder(
        builder: (context, _) => Drawer(
          elevation: ArrPilotUI.ELEVATION,
          backgroundColor: Theme.of(context).primaryColor,
          child: ArrPilotDatabase.DRAWER_AUTOMATIC_MANAGE.listenableBuilder(
            builder: (context, _) => Column(
              children: [
                ArrPilotDrawerHeader(page: page),
                Expanded(
                  child: ArrPilotListView(
                    controller: PrimaryScrollController.of(context),
                    children: _moduleList(
                      context,
                      ArrPilotDatabase.DRAWER_AUTOMATIC_MANAGE.read()
                          ? moduleAlphabeticalList()
                          : moduleOrderedList(),
                    ),
                    physics: const ClampingScrollPhysics(),
                    padding: MediaQuery.of(context).padding.copyWith(top: 0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _sharedHeader(BuildContext context) {
    return [
      _buildEntry(
        context: context,
        module: ArrPilotModule.DASHBOARD,
      ),
    ];
  }

  List<Widget> _moduleList(BuildContext context, List<ArrPilotModule> modules) {
    return <Widget>[
      ..._sharedHeader(context),
      ...modules.map((module) {
        if (module.isEnabled) {
          return _buildEntry(
            context: context,
            module: module,
            onTap: module == ArrPilotModule.WAKE_ON_LAN ? _wakeOnLAN : null,
          );
        }
        return const SizedBox(height: 0.0);
      }),
    ];
  }

  Widget _buildEntry({
    required BuildContext context,
    required ArrPilotModule module,
    void Function()? onTap,
  }) {
    bool currentPage = page == module.key.toLowerCase();
    return SizedBox(
      height: ArrPilotTextInputBar.defaultAppBarHeight,
      child: InkWell(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              child: Icon(
                module.icon,
                color: currentPage ? module.color : ArrPilotColours.white,
              ),
              padding: ArrPilotUI.MARGIN_DEFAULT_HORIZONTAL * 1.5,
            ),
            Text(
              module.title,
              style: TextStyle(
                color: currentPage ? module.color : ArrPilotColours.white,
                fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
              ),
            ),
          ],
        ),
        onTap: onTap ??
            () async {
              Navigator.of(context).pop();
              if (!currentPage) module.launch();
            },
      ),
    );
  }

  Future<void> _wakeOnLAN() async => ArrPilotWakeOnLAN().wake();
}

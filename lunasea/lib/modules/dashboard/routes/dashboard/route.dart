import 'package:flutter/material.dart';

import 'package:arrpilot/modules.dart';
import 'package:arrpilot/database/tables/dashboard.dart';
import 'package:arrpilot/database/tables/lunasea.dart';
import 'package:arrpilot/widgets/ui.dart';
import 'package:arrpilot/modules/dashboard/routes/dashboard/pages/calendar.dart';
import 'package:arrpilot/modules/dashboard/routes/dashboard/pages/modules.dart';
import 'package:arrpilot/modules/dashboard/routes/dashboard/widgets/switch_view_action.dart';
import 'package:arrpilot/modules/dashboard/routes/dashboard/widgets/navigation_bar.dart';

class DashboardRoute extends StatefulWidget {
  const DashboardRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardRoute> createState() => _State();
}

class _State extends State<DashboardRoute> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ArrPilotPageController? _pageController;

  @override
  void initState() {
    super.initState();

    int page = DashboardDatabase.NAVIGATION_INDEX.read();
    _pageController = ArrPilotPageController(initialPage: page);
  }

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      module: ArrPilotModule.DASHBOARD,
      body: _body(),
      appBar: _appBar(),
      drawer: ArrPilotDrawer(page: ArrPilotModule.DASHBOARD.key),
      bottomNavigationBar: HomeNavigationBar(pageController: _pageController),
    );
  }

  PreferredSizeWidget _appBar() {
    return ArrPilotAppBar(
      title: 'ArrPilot',
      useDrawer: true,
      scrollControllers: HomeNavigationBar.scrollControllers,
      pageController: _pageController,
      actions: [SwitchViewAction(pageController: _pageController)],
    );
  }

  Widget _body() {
    return ArrPilotDatabase.ENABLED_PROFILE.listenableBuilder(
      builder: (context, _) => ArrPilotPageView(
        controller: _pageController,
        children: [
          ModulesPage(key: ValueKey(ArrPilotDatabase.ENABLED_PROFILE.read())),
          CalendarPage(key: ValueKey(ArrPilotDatabase.ENABLED_PROFILE.read())),
        ],
      ),
    );
  }
}

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
  LunaPageController? _pageController;

  @override
  void initState() {
    super.initState();

    int page = DashboardDatabase.NAVIGATION_INDEX.read();
    _pageController = LunaPageController(initialPage: page);
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.DASHBOARD,
      body: _body(),
      appBar: _appBar(),
      drawer: LunaDrawer(page: LunaModule.DASHBOARD.key),
      bottomNavigationBar: HomeNavigationBar(pageController: _pageController),
    );
  }

  PreferredSizeWidget _appBar() {
    return LunaAppBar(
      title: 'LunaSea',
      useDrawer: true,
      scrollControllers: HomeNavigationBar.scrollControllers,
      pageController: _pageController,
      actions: [SwitchViewAction(pageController: _pageController)],
    );
  }

  Widget _body() {
    return LunaSeaDatabase.ENABLED_PROFILE.listenableBuilder(
      builder: (context, _) => LunaPageView(
        controller: _pageController,
        children: [
          ModulesPage(key: ValueKey(LunaSeaDatabase.ENABLED_PROFILE.read())),
          CalendarPage(key: ValueKey(LunaSeaDatabase.ENABLED_PROFILE.read())),
        ],
      ),
    );
  }
}

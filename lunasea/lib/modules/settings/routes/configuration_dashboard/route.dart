import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/router/routes/settings.dart';

class ConfigurationDashboardRoute extends StatefulWidget {
  const ConfigurationDashboardRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationDashboardRoute> createState() => _State();
}

class _State extends State<ConfigurationDashboardRoute>
    with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      title: 'Dashboard',
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return ArrPilotListView(
      controller: scrollController,
      children: [
        _calendarSettingsPage(),
        _defaultPagesPage(),
      ],
    );
  }

  Widget _defaultPagesPage() {
    return ArrPilotBlock(
      title: 'settings.DefaultPages'.tr(),
      body: [TextSpan(text: 'settings.DefaultPagesDescription'.tr())],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_DASHBOARD_DEFAULT_PAGES.go,
    );
  }

  Widget _calendarSettingsPage() {
    return ArrPilotBlock(
      title: 'settings.CalendarSettings'.tr(),
      body: [TextSpan(text: 'settings.CalendarSettingsDescription'.tr())],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_DASHBOARD_CALENDAR.go,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/sonarr.dart';

class SonarrRoute extends StatefulWidget {
  const SonarrRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<SonarrRoute> createState() => _State();
}

class _State extends State<SonarrRoute> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ArrPilotPageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = ArrPilotPageController(
      initialPage: SonarrDatabase.NAVIGATION_INDEX.read(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      module: ArrPilotModule.SONARR,
      drawer: _drawer(),
      appBar: _appBar(),
      bottomNavigationBar: _bottomNavigationBar(),
      body: _body(),
    );
  }

  Widget _drawer() {
    return ArrPilotDrawer(page: ArrPilotModule.SONARR.key);
  }

  Widget? _bottomNavigationBar() {
    if (context.read<SonarrState>().enabled) {
      return SonarrNavigationBar(pageController: _pageController);
    }
    return null;
  }

  PreferredSizeWidget _appBar() {
    List<String> profiles = ArrPilotBox.profiles.keys.fold(
      [],
      (value, element) {
        if (ArrPilotBox.profiles.read(element)?.sonarrEnabled ?? false) {
          value.add(element);
        }
        return value;
      },
    );
    List<Widget>? actions;
    if (context.watch<SonarrState>().enabled) {
      actions = [
        const SonarrAppBarAddSeriesAction(),
        const SonarrAppBarGlobalSettingsAction(),
      ];
    }
    return ArrPilotAppBar.dropdown(
      title: ArrPilotModule.SONARR.title,
      useDrawer: true,
      profiles: profiles,
      actions: actions,
      pageController: _pageController,
      scrollControllers: SonarrNavigationBar.scrollControllers,
    );
  }

  Widget _body() {
    return Selector<SonarrState, bool?>(
      selector: (_, state) => state.enabled,
      builder: (context, enabled, _) {
        if (!enabled!) {
          return ArrPilotMessage.moduleNotEnabled(
            context: context,
            module: 'Sonarr',
          );
        }
        return ArrPilotPageView(
          controller: _pageController,
          children: const [
            SonarrCatalogueRoute(),
            SonarrUpcomingRoute(),
            SonarrMissingRoute(),
            SonarrMoreRoute(),
          ],
        );
      },
    );
  }
}

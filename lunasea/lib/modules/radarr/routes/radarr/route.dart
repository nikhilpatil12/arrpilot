import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';

class RadarrRoute extends StatefulWidget {
  const RadarrRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<RadarrRoute> createState() => _State();
}

class _State extends State<RadarrRoute> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ArrPilotPageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = ArrPilotPageController(
      initialPage: RadarrDatabase.NAVIGATION_INDEX.read(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      module: ArrPilotModule.RADARR,
      drawer: _drawer(),
      appBar: _appBar() as PreferredSizeWidget?,
      bottomNavigationBar: _bottomNavigationBar(),
      body: _body(),
    );
  }

  Widget _drawer() {
    return ArrPilotDrawer(page: ArrPilotModule.RADARR.key);
  }

  Widget? _bottomNavigationBar() {
    if (context.read<RadarrState>().enabled) {
      return RadarrNavigationBar(pageController: _pageController);
    }
    return null;
  }

  Widget _appBar() {
    List<String> profiles = ArrPilotBox.profiles.keys.fold(
      [],
      (value, element) {
        if (ArrPilotBox.profiles.read(element)?.radarrEnabled ?? false) {
          value.add(element);
        }
        return value;
      },
    );
    List<Widget>? actions;
    if (context.watch<RadarrState>().enabled) {
      actions = [
        const RadarrAppBarAddMoviesAction(),
        const RadarrAppBarGlobalSettingsAction(),
      ];
    }
    return ArrPilotAppBar.dropdown(
      title: ArrPilotModule.RADARR.title,
      useDrawer: true,
      profiles: profiles,
      actions: actions,
      pageController: _pageController,
      scrollControllers: RadarrNavigationBar.scrollControllers,
    );
  }

  Widget _body() {
    return Selector<RadarrState, bool?>(
      selector: (_, state) => state.enabled,
      builder: (context, enabled, _) {
        if (!enabled!) {
          return ArrPilotMessage.moduleNotEnabled(
            context: context,
            module: 'Radarr',
          );
        }
        return ArrPilotPageView(
          controller: _pageController,
          children: const [
            RadarrCatalogueRoute(),
            RadarrUpcomingRoute(),
            RadarrMissingRoute(),
            RadarrMoreRoute(),
          ],
        );
      },
    );
  }
}

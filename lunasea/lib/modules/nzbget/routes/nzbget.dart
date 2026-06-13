import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/database/tables/nzbget.dart';
import 'package:arrpilot/extensions/string/links.dart';
import 'package:arrpilot/modules/nzbget.dart';
import 'package:arrpilot/router/routes/nzbget.dart';

import 'package:arrpilot/system/filesystem/file.dart';
import 'package:arrpilot/system/filesystem/filesystem.dart';

class NZBGetRoute extends StatefulWidget {
  final bool showDrawer;

  const NZBGetRoute({
    Key? key,
    this.showDrawer = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<NZBGetRoute> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ArrPilotPageController? _pageController;
  String _profileState = ArrPilotProfile.current.toString();
  NZBGetAPI _api = NZBGetAPI.from(ArrPilotProfile.current);

  final List _refreshKeys = [
    GlobalKey<RefreshIndicatorState>(),
    GlobalKey<RefreshIndicatorState>(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController =
        ArrPilotPageController(initialPage: NZBGetDatabase.NAVIGATION_INDEX.read());
  }

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      body: _body(),
      drawer: widget.showDrawer ? _drawer() : null,
      appBar: _appBar() as PreferredSizeWidget?,
      bottomNavigationBar: _bottomNavigationBar(),
      extendBodyBehindAppBar: false,
      extendBody: false,
      onProfileChange: (_) {
        if (_profileState != ArrPilotProfile.current.toString()) _refreshProfile();
      },
    );
  }

  Widget _drawer() => ArrPilotDrawer(page: ArrPilotModule.NZBGET.key);

  Widget? _bottomNavigationBar() {
    if (ArrPilotProfile.current.nzbgetEnabled) {
      return NZBGetNavigationBar(pageController: _pageController);
    }
    return null;
  }

  Widget _appBar() {
    List<String> profiles = ArrPilotBox.profiles.keys.fold([], (value, element) {
      if (ArrPilotBox.profiles.read(element)?.nzbgetEnabled ?? false)
        value.add(element);
      return value;
    });
    List<Widget>? actions;
    if (ArrPilotProfile.current.nzbgetEnabled)
      actions = [
        Selector<NZBGetState, bool>(
          selector: (_, model) => model.error,
          builder: (context, error, widget) =>
              error ? Container() : const NZBGetAppBarStats(),
        ),
        ArrPilotIconButton(
          icon: Icons.more_vert_rounded,
          onPressed: () async => _handlePopup(),
        ),
      ];
    return ArrPilotAppBar.dropdown(
      title: ArrPilotModule.NZBGET.title,
      useDrawer: widget.showDrawer,
      hideLeading: !widget.showDrawer,
      profiles: profiles,
      actions: actions,
      pageController: _pageController,
      scrollControllers: NZBGetNavigationBar.scrollControllers,
    );
  }

  Widget _body() {
    if (!ArrPilotProfile.current.nzbgetEnabled)
      return ArrPilotMessage.moduleNotEnabled(
        context: context,
        module: ArrPilotModule.NZBGET.title,
      );
    return ArrPilotPageView(
      controller: _pageController,
      children: [
        NZBGetQueue(
          refreshIndicatorKey: _refreshKeys[0],
        ),
        NZBGetHistory(
          refreshIndicatorKey: _refreshKeys[1],
        ),
      ],
    );
  }

  Future<void> _handlePopup() async {
    List<dynamic> values = await NZBGetDialogs.globalSettings(context);
    if (values[0])
      switch (values[1]) {
        case 'web_gui':
          ArrPilotProfile profile = ArrPilotProfile.current;
          await profile.nzbgetHost.openLink();
          break;
        case 'add_nzb':
          _addNZB();
          break;
        case 'sort':
          _sort();
          break;
        case 'server_details':
          _serverDetails();
          break;
        default:
          ArrPilotLogger().warning('Unknown Case: ${values[1]}');
      }
  }

  Future<void> _addNZB() async {
    List values = await NZBGetDialogs.addNZB(context);
    if (values[0])
      switch (values[1]) {
        case 'link':
          _addByURL();
          break;
        case 'file':
          _addByFile();
          break;
        default:
          ArrPilotLogger().warning('Unknown Case: ${values[1]}');
      }
  }

  Future<void> _addByURL() async {
    List values = await NZBGetDialogs.addNZBUrl(context);
    if (values[0])
      await _api
          .uploadURL(values[1])
          .then((_) => showLunaSuccessSnackBar(
              title: 'Uploaded NZB (URL)', message: values[1]))
          .catchError((error) => showLunaErrorSnackBar(
              title: 'Failed to Upload NZB', error: error));
  }

  Future<void> _addByFile() async {
    try {
      ArrPilotFile? _file = await ArrPilotFileSystem().read(context, [
        'nzb',
      ]);
      if (_file != null) {
        if (_file.data.isNotEmpty) {
          await _api.uploadFile(_file.data, _file.name).then((value) {
            _refreshKeys[0]?.currentState?.show();
            showLunaSuccessSnackBar(
              title: 'Uploaded NZB (File)',
              message: _file.name,
            );
          });
        } else {
          showLunaErrorSnackBar(
            title: 'Failed to Upload NZB',
            message: 'Please select a valid file',
          );
        }
      }
    } catch (error, stack) {
      ArrPilotLogger().error('Failed to add NZB by file', error, stack);
      showLunaErrorSnackBar(
        title: 'Failed to Upload NZB',
        error: error,
      );
    }
  }

  Future<void> _sort() async {
    List values = await NZBGetDialogs.sortQueue(context);
    if (values[0])
      await _api.sortQueue(values[1]).then((_) {
        _refreshKeys[0]?.currentState?.show();
        showLunaSuccessSnackBar(
            title: 'Sorted Queue', message: (values[1] as NZBGetSort?).name);
      }).catchError((error) {
        showLunaErrorSnackBar(title: 'Failed to Sort Queue', error: error);
      });
  }

  Future<void> _serverDetails() async => NZBGetRoutes.STATISTICS.go();

  void _refreshProfile() {
    _api = NZBGetAPI.from(ArrPilotProfile.current);
    _profileState = ArrPilotProfile.current.toString();
    _refreshAllPages();
  }

  void _refreshAllPages() {
    for (var key in _refreshKeys) key?.currentState?.show();
  }
}

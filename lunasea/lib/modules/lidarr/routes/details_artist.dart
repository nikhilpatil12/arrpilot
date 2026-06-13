import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/lidarr.dart';
import 'package:arrpilot/modules/lidarr/sheets/links.dart';
import 'package:arrpilot/router/router.dart';

class ArtistDetailsRoute extends StatefulWidget {
  final LidarrCatalogueData? data;
  final int? artistId;

  const ArtistDetailsRoute({
    required this.data,
    required this.artistId,
    Key? key,
  }) : super(key: key);

  @override
  State<ArtistDetailsRoute> createState() => _State();
}

class _State extends State<ArtistDetailsRoute> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _pageController = ArrPilotPageController(initialPage: 1);

  LidarrCatalogueData? data;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    data = widget.data;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _fetch();
    });
  }

  Future<void> _fetch() async {
    if (mounted) setState(() => _error = false);
    final api = LidarrAPI.from(ArrPilotProfile.current);
    await api.getArtist(widget.artistId).then((newData) {
      if (mounted) {
        setState(() {
          data = newData;
          _error = false;
        });
      }
    }).catchError((error) {
      if (mounted) {
        setState(() {
          _error = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return ArrPilotScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: ArrPilotAppBar(title: 'Artist Details'),
        body: ArrPilotMessage.error(onTap: _fetch),
      );
    }

    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar,
      bottomNavigationBar: data != null ? _bottomNavigationBar : null,
      body: data != null ? _body : const ArrPilotLoader(),
    );
  }

  PreferredSizeWidget get _appBar {
    List<Widget>? _actions;

    if (data != null) {
      _actions = [
        ArrPilotIconButton(
          icon: ArrPilotIcons.LINK,
          onPressed: () async {
            LinksSheet(artist: data!).show();
          },
        ),
        LidarrDetailsEditButton(data: data),
        LidarrDetailsSettingsButton(
          data: data,
          remove: _removeCallback,
        ),
      ];
    }

    return ArrPilotAppBar(
      title: 'Artist Details',
      pageController: _pageController,
      scrollControllers: LidarrArtistNavigationBar.scrollControllers,
      actions: _actions,
    );
  }

  Widget get _bottomNavigationBar =>
      LidarrArtistNavigationBar(pageController: _pageController);

  List<Widget> get _tabs => [
        LidarrDetailsOverview(data: data!),
        LidarrDetailsAlbumList(artistID: data!.artistID),
      ];

  Widget get _body => ArrPilotPageView(
        controller: _pageController,
        children: _tabs,
      );

  Future<void> _removeCallback(bool withData) async {
    showLunaSuccessSnackBar(
      title: 'Artist Removed',
      message: data!.title,
    );
    ArrPilotRouter.router.pop();
  }
}

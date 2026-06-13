import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/tautulli.dart';
import 'package:arrpilot/router/routes/tautulli.dart';

class TautulliMoreRoute extends StatefulWidget {
  const TautulliMoreRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<TautulliMoreRoute> createState() => _State();
}

class _State extends State<TautulliMoreRoute>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      module: ArrPilotModule.TAUTULLI,
      body: _body,
    );
  }

  Widget get _body {
    return ArrPilotListView(
      controller: TautulliNavigationBar.scrollControllers[3],
      children: [
        ArrPilotBlock(
          title: 'Check for Updates',
          body: const [TextSpan(text: 'Tautulli & Plex Updates')],
          trailing: ArrPilotIconButton(
            icon: Icons.system_update_rounded,
            color: ArrPilotColours().byListIndex(0),
          ),
          onTap: TautulliRoutes.CHECK_FOR_UPDATES.go,
        ),
        ArrPilotBlock(
          title: 'Graphs',
          body: const [TextSpan(text: 'Play Count & Duration Graphs')],
          trailing: ArrPilotIconButton(
            icon: Icons.insert_chart_rounded,
            color: ArrPilotColours().byListIndex(1),
          ),
          onTap: TautulliRoutes.GRAPHS.go,
        ),
        ArrPilotBlock(
          title: 'Libraries',
          body: const [TextSpan(text: 'Plex Library Information')],
          trailing: ArrPilotIconButton(
            icon: Icons.video_library_rounded,
            color: ArrPilotColours().byListIndex(2),
          ),
          onTap: TautulliRoutes.LIBRARIES.go,
        ),
        ArrPilotBlock(
          title: 'Logs',
          body: const [TextSpan(text: 'Tautulli & Plex Logs')],
          trailing: ArrPilotIconButton(
            icon: Icons.developer_mode_rounded,
            color: ArrPilotColours().byListIndex(3),
          ),
          onTap: TautulliRoutes.LOGS.go,
        ),
        ArrPilotBlock(
          title: 'Recently Added',
          body: const [TextSpan(text: 'Recently Added Content to Plex')],
          trailing: ArrPilotIconButton(
            icon: Icons.recent_actors_rounded,
            color: ArrPilotColours().byListIndex(4),
          ),
          onTap: TautulliRoutes.RECENTLY_ADDED.go,
        ),
        ArrPilotBlock(
          title: 'Search',
          body: const [TextSpan(text: 'Search Your Libraries')],
          trailing: ArrPilotIconButton(
            icon: Icons.search_rounded,
            color: ArrPilotColours().byListIndex(5),
          ),
          onTap: TautulliRoutes.SEARCH.go,
        ),
        ArrPilotBlock(
          title: 'Statistics',
          body: const [TextSpan(text: 'User & Library Statistics')],
          trailing: ArrPilotIconButton(
            icon: Icons.format_list_numbered_rounded,
            color: ArrPilotColours().byListIndex(6),
          ),
          onTap: TautulliRoutes.STATISTICS.go,
        ),
        ArrPilotBlock(
          title: 'Synced Items',
          body: const [TextSpan(text: 'Synced Content on Devices')],
          trailing: ArrPilotIconButton(
            icon: Icons.sync_rounded,
            color: ArrPilotColours().byListIndex(7),
          ),
          onTap: TautulliRoutes.SYNCED_ITEMS.go,
        ),
      ],
    );
  }
}

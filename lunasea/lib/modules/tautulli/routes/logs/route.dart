import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/router/routes/tautulli.dart';

class LogsRoute extends StatefulWidget {
  const LogsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LogsRoute> with ArrPilotScrollControllerMixin {
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
      title: 'Logs',
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return ArrPilotListView(
      controller: scrollController,
      children: [
        ArrPilotBlock(
          title: 'Logins',
          body: const [TextSpan(text: 'Tautulli Login Logs')],
          trailing: ArrPilotIconButton(
            icon: Icons.vpn_key_rounded,
            color: ArrPilotColours().byListIndex(0),
          ),
          onTap: TautulliRoutes.LOGS_LOGINS.go,
        ),
        ArrPilotBlock(
          title: 'Newsletters',
          body: const [TextSpan(text: 'Tautulli Newsletter Logs')],
          trailing: ArrPilotIconButton(
            icon: Icons.email_rounded,
            color: ArrPilotColours().byListIndex(1),
          ),
          onTap: TautulliRoutes.LOGS_NEWSLETTERS.go,
        ),
        ArrPilotBlock(
          title: 'Notifications',
          body: const [TextSpan(text: 'Tautulli Notification Logs')],
          trailing: ArrPilotIconButton(
            icon: Icons.notifications_rounded,
            color: ArrPilotColours().byListIndex(2),
          ),
          onTap: TautulliRoutes.LOGS_NOTIFICATIONS.go,
        ),
        ArrPilotBlock(
          title: 'Plex Media Scanner',
          body: const [TextSpan(text: 'Plex Media Scanner Logs')],
          trailing: ArrPilotIconButton(
            icon: Icons.scanner_rounded,
            color: ArrPilotColours().byListIndex(3),
          ),
          onTap: TautulliRoutes.LOGS_PLEX_MEDIA_SCANNER.go,
        ),
        ArrPilotBlock(
          title: 'Plex Media Server',
          body: const [TextSpan(text: 'Plex Media Server Logs')],
          trailing: ArrPilotIconButton(
            icon: ArrPilotIcons.PLEX,
            iconSize: ArrPilotUI.ICON_SIZE - 2.0,
            color: ArrPilotColours().byListIndex(4),
          ),
          onTap: TautulliRoutes.LOGS_PLEX_MEDIA_SERVER.go,
        ),
        ArrPilotBlock(
          title: 'Tautulli',
          body: const [TextSpan(text: 'Tautulli Logs')],
          trailing: ArrPilotIconButton(
            icon: ArrPilotIcons.TAUTULLI,
            color: ArrPilotColours().byListIndex(5),
          ),
          onTap: TautulliRoutes.LOGS_TAUTULLI.go,
        ),
      ],
    );
  }
}

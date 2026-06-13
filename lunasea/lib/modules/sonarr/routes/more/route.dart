import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/sonarr.dart';
import 'package:arrpilot/router/routes/sonarr.dart';

class SonarrMoreRoute extends StatefulWidget {
  const SonarrMoreRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<SonarrMoreRoute> createState() => _State();
}

class _State extends State<SonarrMoreRoute> with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      module: ArrPilotModule.SONARR,
      body: _body(),
    );
  }

  // ignore: unused_element
  Future<void> _showComingSoonMessage() async {
    showLunaInfoSnackBar(
      title: 'arrpilot.ComingSoon'.tr(),
      message: 'This feature is still being developed!',
    );
  }

  Widget _body() {
    return ArrPilotListView(
      controller: SonarrNavigationBar.scrollControllers[3],
      children: [
        ArrPilotBlock(
          title: 'sonarr.History'.tr(),
          body: [TextSpan(text: 'sonarr.HistoryDescription'.tr())],
          trailing: ArrPilotIconButton(
            icon: Icons.history_rounded,
            color: ArrPilotColours().byListIndex(0),
          ),
          onTap: SonarrRoutes.HISTORY.go,
        ),
        // ArrPilotBlock(
        //   title: 'sonarr.ManualImport'.tr(),
        //   body: [TextSpan(text: 'sonarr.ManualImportDescription'.tr())],
        //   trailing: ArrPilotIconButton(
        //     icon: Icons.download_done_rounded,
        //     color: ArrPilotColours().byListIndex(1),
        //   ),
        //   onTap: () async => _showComingSoonMessage(),
        // ),
        ArrPilotBlock(
          title: 'sonarr.Queue'.tr(),
          body: [TextSpan(text: 'sonarr.QueueDescription'.tr())],
          trailing: ArrPilotIconButton(
            icon: Icons.queue_play_next_rounded,
            color: ArrPilotColours().byListIndex(1),
          ),
          onTap: SonarrRoutes.QUEUE.go,
        ),
        // ArrPilotBlock(
        //   title: 'sonarr.SystemStatus'.tr(),
        //   body: [TextSpan(text: 'sonarr.SystemStatusDescription'.tr())],
        //   trailing: ArrPilotIconButton(
        //     icon: Icons.computer_rounded,
        //     color: ArrPilotColours().byListIndex(3),
        //   ),
        //   onTap: () async => _showComingSoonMessage(),
        // ),
        ArrPilotBlock(
          title: 'sonarr.Tags'.tr(),
          body: [TextSpan(text: 'sonarr.TagsDescription'.tr())],
          trailing: ArrPilotIconButton(
            icon: Icons.style_rounded,
            color: ArrPilotColours().byListIndex(2),
          ),
          onTap: SonarrRoutes.TAGS.go,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';
import 'package:arrpilot/router/routes/radarr.dart';

class RadarrMoreRoute extends StatefulWidget {
  const RadarrMoreRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<RadarrMoreRoute> createState() => _State();
}

class _State extends State<RadarrMoreRoute> with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      body: _body(),
    );
  }

  Widget _body() {
    return ArrPilotListView(
      controller: RadarrNavigationBar.scrollControllers[3],
      itemExtent: ArrPilotBlock.calculateItemExtent(1),
      children: [
        ArrPilotBlock(
          title: 'radarr.History'.tr(),
          body: [TextSpan(text: 'radarr.HistoryDescription'.tr())],
          trailing: ArrPilotIconButton(
            icon: Icons.history_rounded,
            color: ArrPilotColours().byListIndex(0),
          ),
          onTap: RadarrRoutes.HISTORY.go,
        ),
        ArrPilotBlock(
          title: 'radarr.ManualImport'.tr(),
          body: [TextSpan(text: 'radarr.ManualImportDescription'.tr())],
          trailing: ArrPilotIconButton(
            icon: Icons.download_done_rounded,
            color: ArrPilotColours().byListIndex(1),
          ),
          onTap: RadarrRoutes.MANUAL_IMPORT.go,
        ),
        ArrPilotBlock(
          title: 'radarr.Queue'.tr(),
          body: [TextSpan(text: 'radarr.QueueDescription'.tr())],
          trailing: ArrPilotIconButton(
            icon: Icons.queue_play_next_rounded,
            color: ArrPilotColours().byListIndex(2),
          ),
          onTap: RadarrRoutes.QUEUE.go,
        ),
        ArrPilotBlock(
          title: 'radarr.SystemStatus'.tr(),
          body: [TextSpan(text: 'radarr.SystemStatusDescription'.tr())],
          trailing: ArrPilotIconButton(
            icon: Icons.computer_rounded,
            color: ArrPilotColours().byListIndex(3),
          ),
          onTap: RadarrRoutes.SYSTEM_STATUS.go,
        ),
        ArrPilotBlock(
          title: 'radarr.Tags'.tr(),
          body: [TextSpan(text: 'radarr.TagsDescription'.tr())],
          trailing: ArrPilotIconButton(
            icon: Icons.style_rounded,
            color: ArrPilotColours().byListIndex(4),
          ),
          onTap: RadarrRoutes.TAGS.go,
        ),
      ],
    );
  }
}

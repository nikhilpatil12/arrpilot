import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/database/models/log.dart';
import 'package:arrpilot/modules/settings/routes/system_logs/widgets/log_tile.dart';
import 'package:arrpilot/types/log_type.dart';

class SystemLogsDetailsRoute extends StatefulWidget {
  final ArrPilotLogType? type;

  const SystemLogsDetailsRoute({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  State<SystemLogsDetailsRoute> createState() => _State();
}

class _State extends State<SystemLogsDetailsRoute>
    with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return ArrPilotAppBar(
      title: 'settings.Logs'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return ArrPilotBox.logs.listenableBuilder(builder: (context, _) {
      List<ArrPilotLog> logs = filter();
      if (logs.isEmpty) {
        return ArrPilotMessage.goBack(
          context: context,
          text: 'settings.NoLogsFound'.tr(),
        );
      }
      return ArrPilotListViewBuilder(
        controller: scrollController,
        itemCount: logs.length,
        itemBuilder: (context, index) => SettingsSystemLogTile(
          log: logs[index],
        ),
      );
    });
  }

  List<ArrPilotLog> filter() {
    List<ArrPilotLog> logs;
    const box = ArrPilotBox.logs;

    switch (widget.type) {
      case ArrPilotLogType.WARNING:
        logs =
            box.data.where((log) => log.type == ArrPilotLogType.WARNING).toList();
        break;
      case ArrPilotLogType.ERROR:
        logs = box.data.where((log) => log.type == ArrPilotLogType.ERROR).toList();
        break;
      case ArrPilotLogType.CRITICAL:
        logs =
            box.data.where((log) => log.type == ArrPilotLogType.CRITICAL).toList();
        break;
      case ArrPilotLogType.DEBUG:
        logs = box.data.where((log) => log.type == ArrPilotLogType.DEBUG).toList();
        break;
      default:
        logs = box.data.where((log) => log.type.enabled).toList();
        break;
    }
    logs.sort((a, b) => (b.timestamp).compareTo(a.timestamp));
    return logs;
  }
}

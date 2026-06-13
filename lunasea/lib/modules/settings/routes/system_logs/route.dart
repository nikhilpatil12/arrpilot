import 'package:flutter/material.dart';

import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/settings.dart';
import 'package:arrpilot/router/routes/settings.dart';
import 'package:arrpilot/system/filesystem/filesystem.dart';
import 'package:arrpilot/types/log_type.dart';

class SystemLogsRoute extends StatefulWidget {
  const SystemLogsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<SystemLogsRoute> createState() => _State();
}

class _State extends State<SystemLogsRoute> with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: _bottomActionBar(),
    );
  }

  PreferredSizeWidget _appBar() {
    return ArrPilotAppBar(
      title: 'settings.Logs'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _bottomActionBar() {
    return ArrPilotBottomActionBar(
      actions: [
        _exportLogs(),
        _clearLogs(),
      ],
    );
  }

  Widget _body() {
    return ArrPilotListView(
      controller: scrollController,
      children: [
        ArrPilotBlock(
          title: 'settings.AllLogs'.tr(),
          body: [TextSpan(text: 'settings.AllLogsDescription'.tr())],
          trailing: const ArrPilotIconButton(icon: Icons.developer_mode_rounded),
          onTap: () async => _viewLogs(null),
        ),
        ...List.generate(
          ArrPilotLogType.values.length,
          (index) {
            if (ArrPilotLogType.values[index].enabled)
              return ArrPilotBlock(
                title: ArrPilotLogType.values[index].title,
                body: [TextSpan(text: ArrPilotLogType.values[index].description)],
                trailing: ArrPilotIconButton(icon: ArrPilotLogType.values[index].icon),
                onTap: () async => _viewLogs(ArrPilotLogType.values[index]),
              );
            return Container(height: 0.0);
          },
        ),
      ],
    );
  }

  Future<void> _viewLogs(ArrPilotLogType? type) async {
    SettingsRoutes.SYSTEM_LOGS_DETAILS.go(params: {
      'type': type?.key ?? 'all',
    });
  }

  Widget _clearLogs() {
    return ArrPilotButton.text(
      text: 'settings.Clear'.tr(),
      icon: ArrPilotIcons.DELETE,
      color: ArrPilotColours.red,
      onTap: () async {
        bool result = await SettingsDialogs().clearLogs(context);
        if (result) {
          ArrPilotLogger().clear();
          showLunaSuccessSnackBar(
            title: 'settings.LogsCleared'.tr(),
            message: 'settings.LogsClearedDescription'.tr(),
          );
        }
      },
    );
  }

  Widget _exportLogs() {
    return Builder(
      builder: (context) => ArrPilotButton.text(
        text: 'settings.Export'.tr(),
        icon: ArrPilotIcons.DOWNLOAD,
        onTap: () async {
          String data = await ArrPilotLogger().export();
          bool result = await ArrPilotFileSystem()
              .save(context, 'logs.json', utf8.encode(data));
          if (result)
            showLunaSuccessSnackBar(
                title: 'settings.ExportedLogs'.tr(),
                message: 'settings.ExportedLogsMessage'.tr());
        },
      ),
    );
  }
}

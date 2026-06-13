import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/tautulli.dart';

class LogsNotificationsRoute extends StatefulWidget {
  const LogsNotificationsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LogsNotificationsRoute>
    with ArrPilotScrollControllerMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TautulliLogsNotificationsState(context),
      builder: (context, _) => ArrPilotScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar() as PreferredSizeWidget?,
        body: _body(context),
      ),
    );
  }

  Widget _appBar() {
    return ArrPilotAppBar(
      title: 'Notification Logs',
      scrollControllers: [scrollController],
    );
  }

  Widget _body(BuildContext context) {
    return ArrPilotRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: () async =>
          context.read<TautulliLogsNotificationsState>().fetchLogs(context),
      child: FutureBuilder(
        future: context
            .select((TautulliLogsNotificationsState state) => state.logs),
        builder: (context, AsyncSnapshot<TautulliNotificationLogs> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting)
              ArrPilotLogger().error(
                'Unable to fetch Tautulli notification logs',
                snapshot.error,
                snapshot.stackTrace,
              );
            return ArrPilotMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.hasData) return _logs(snapshot.data);
          return const ArrPilotLoader();
        },
      ),
    );
  }

  Widget _logs(TautulliNotificationLogs? logs) {
    if ((logs?.logs?.length ?? 0) == 0)
      return ArrPilotMessage(
        text: 'No Logs Found',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState?.show,
      );
    return ArrPilotListViewBuilder(
      controller: scrollController,
      itemCount: logs!.logs!.length,
      itemBuilder: (context, index) =>
          TautulliLogsNotificationLogTile(notification: logs.logs![index]),
    );
  }
}

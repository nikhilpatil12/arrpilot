import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';

class RadarrSystemStatusAboutPage extends StatefulWidget {
  final ScrollController scrollController;

  const RadarrSystemStatusAboutPage({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrSystemStatusAboutPage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

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
    return ArrPilotRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: () async =>
          context.read<RadarrSystemStatusState>().fetchStatus(context),
      child: FutureBuilder(
        future: context.watch<RadarrSystemStatusState>().status,
        builder: (context, AsyncSnapshot<RadarrSystemStatus> snapshot) {
          if (snapshot.hasError) {
            ArrPilotLogger().error('Unable to fetch Radarr system status',
                snapshot.error, snapshot.stackTrace);
            return ArrPilotMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.hasData) return _list(snapshot.data!);
          return const ArrPilotLoader();
        },
      ),
    );
  }

  Widget _list(RadarrSystemStatus status) {
    return ArrPilotListView(
      controller: RadarrSystemStatusNavigationBar.scrollControllers[0],
      children: [
        ArrPilotTableCard(
          content: [
            ArrPilotTableContent(title: 'Version', body: status.lunaVersion),
            if (status.lunaIsDocker)
              ArrPilotTableContent(
                title: 'Package',
                body: status.lunaPackageVersion,
              ),
            ArrPilotTableContent(title: '.NET Core', body: status.lunaNetCore),
            ArrPilotTableContent(title: 'Migration', body: status.lunaDBMigration),
            ArrPilotTableContent(
                title: 'AppData', body: status.lunaAppDataDirectory),
            ArrPilotTableContent(
                title: 'Startup', body: status.lunaStartupDirectory),
            ArrPilotTableContent(title: 'mode', body: status.lunaMode),
            ArrPilotTableContent(title: 'uptime', body: status.lunaUptime),
          ],
        ),
      ],
    );
  }
}

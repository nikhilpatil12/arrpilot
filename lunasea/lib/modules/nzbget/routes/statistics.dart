import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/nzbget.dart';

class StatisticsRoute extends StatefulWidget {
  const StatisticsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<StatisticsRoute> createState() => _State();
}

class _State extends State<StatisticsRoute> with ArrPilotScrollControllerMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<bool>? _future;
  late NZBGetStatisticsData _statistics;
  List<NZBGetLogData> _logs = [];

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    if (mounted)
      setState(() {
        _future = _fetch();
      });
  }

  Future<bool> _fetch() async {
    final _api = NZBGetAPI.from(ArrPilotProfile.current);
    return _fetchStatistics(_api)
        .then((_) => _fetchLogs(_api))
        .then((_) => true);
  }

  Future<void> _fetchStatistics(NZBGetAPI api) async {
    return await api.getStatistics().then((stats) {
      _statistics = stats;
    });
  }

  Future<void> _fetchLogs(NZBGetAPI api) async {
    return await api.getLogs().then((logs) {
      _logs = logs;
    });
  }

  @override
  Widget build(BuildContext context) => ArrPilotScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar as PreferredSizeWidget?,
        body: _body,
      );

  Widget get _appBar => ArrPilotAppBar(
        title: 'Server Statistics',
        scrollControllers: [scrollController],
      );

  Widget get _body => ArrPilotRefreshIndicator(
        context: context,
        key: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                {
                  if (snapshot.hasError || snapshot.data == null)
                    return ArrPilotMessage.error(onTap: _refresh);
                  return _list;
                }
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
              default:
                return const ArrPilotLoader();
            }
          },
        ),
      );

  Widget get _list => ArrPilotListView(
        controller: scrollController,
        children: <Widget>[
          const ArrPilotHeader(text: 'Status'),
          _statusBlock(),
          const ArrPilotHeader(text: 'Logs'),
          for (var entry in _logs)
            NZBGetLogTile(
              data: entry,
            ),
        ],
      );

  Widget _statusBlock() {
    return ArrPilotTableCard(
      content: [
        ArrPilotTableContent(
            title: 'Server',
            body: _statistics.serverPaused ? 'Paused' : 'Active'),
        ArrPilotTableContent(
            title: 'Post', body: _statistics.postPaused ? 'Paused' : 'Active'),
        ArrPilotTableContent(
            title: 'Scan', body: _statistics.scanPaused ? 'Paused' : 'Active'),
        ArrPilotTableContent(title: '', body: ''),
        ArrPilotTableContent(title: 'Uptime', body: _statistics.uptimeString),
        ArrPilotTableContent(
            title: 'Speed Limit', body: _statistics.speedLimitString),
        ArrPilotTableContent(
            title: 'Free Space', body: _statistics.freeSpaceString),
        ArrPilotTableContent(title: 'Download', body: _statistics.downloadedString),
      ],
    );
  }
}

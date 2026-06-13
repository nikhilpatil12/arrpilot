import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/int/bytes.dart';
import 'package:arrpilot/modules/sabnzbd.dart';

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
  Future<SABnzbdStatisticsData>? _future;
  SABnzbdStatisticsData? _data;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) => ArrPilotScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar as PreferredSizeWidget?,
        body: _body,
      );

  Future<SABnzbdStatisticsData> _fetch() async =>
      SABnzbdAPI.from(ArrPilotProfile.current).getStatistics();

  Future<void> _refresh() async {
    if (mounted)
      setState(() {
        _future = _fetch();
      });
  }

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
          builder: (context, AsyncSnapshot<SABnzbdStatisticsData> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                {
                  if (snapshot.hasError || snapshot.data == null)
                    return ArrPilotMessage.error(onTap: _refresh);
                  _data = snapshot.data;
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
          _status(),
          const ArrPilotHeader(text: 'Statistics'),
          _statistics(),
          ..._serverStatistics(),
        ],
      );

  Widget _status() {
    return ArrPilotTableCard(
      content: [
        ArrPilotTableContent(title: 'Uptime', body: _data!.uptime),
        ArrPilotTableContent(title: 'Version', body: _data!.version),
        ArrPilotTableContent(
            title: 'Temp. Space',
            body: '${_data!.tempFreespace.toString()} GB'),
        ArrPilotTableContent(
            title: 'Final Space',
            body: '${_data!.finalFreespace.toString()} GB'),
      ],
    );
  }

  Widget _statistics() {
    return ArrPilotTableCard(
      content: [
        ArrPilotTableContent(title: 'Daily', body: _data!.dailyUsage.asBytes()),
        ArrPilotTableContent(title: 'Weekly', body: _data!.weeklyUsage.asBytes()),
        ArrPilotTableContent(title: 'Monthly', body: _data!.monthlyUsage.asBytes()),
        ArrPilotTableContent(title: 'Total', body: _data!.totalUsage.asBytes()),
      ],
    );
  }

  List<Widget> _serverStatistics() {
    return _data!.servers
        .map((server) => [
              ArrPilotHeader(text: server.name),
              ArrPilotTableCard(
                content: [
                  ArrPilotTableContent(
                      title: 'Daily', body: server.dailyUsage.asBytes()),
                  ArrPilotTableContent(
                      title: 'Weekly', body: server.weeklyUsage.asBytes()),
                  ArrPilotTableContent(
                      title: 'Monthly', body: server.monthlyUsage.asBytes()),
                  ArrPilotTableContent(
                      title: 'Total', body: server.totalUsage.asBytes()),
                ],
              ),
            ])
        .expand((element) => element)
        .toList();
  }
}

import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/sonarr.dart';

class SonarrSeriesDetailsHistoryPage extends StatefulWidget {
  const SonarrSeriesDetailsHistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrSeriesDetailsHistoryPage>
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
      module: ArrPilotModule.SONARR,
      body: _body(),
    );
  }

  Widget _body() {
    return ArrPilotRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: () async =>
          context.read<SonarrSeriesDetailsState>().fetchHistory(context),
      child: FutureBuilder(
        future: context.select<SonarrSeriesDetailsState,
            Future<List<SonarrHistoryRecord>>?>((s) => s.history),
        builder: (context, AsyncSnapshot<List<SonarrHistoryRecord>> snapshot) {
          if (snapshot.hasError) {
            ArrPilotLogger().error(
              'Unable to fetch Sonarr series history: ${context.read<SonarrSeriesDetailsState>().series.id}',
              snapshot.error,
              snapshot.stackTrace,
            );
            return ArrPilotMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.hasData) return _list(snapshot.data);
          return const ArrPilotLoader();
        },
      ),
    );
  }

  Widget _list(List<SonarrHistoryRecord>? history) {
    if ((history?.length ?? 0) == 0)
      return ArrPilotMessage(
        text: 'sonarr.NoHistoryFound'.tr(),
        buttonText: 'arrpilot.Refresh'.tr(),
        onTap: _refreshKey.currentState!.show,
      );
    return ArrPilotListViewBuilder(
      controller: SonarrSeriesDetailsNavigationBar.scrollControllers[2],
      itemCount: history!.length,
      itemBuilder: (context, index) => SonarrHistoryTile(
        history: history[index],
        type: SonarrHistoryTileType.SERIES,
      ),
    );
  }
}

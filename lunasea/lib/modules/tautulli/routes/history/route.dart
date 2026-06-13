import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/tautulli.dart';

class TautulliHistoryRoute extends StatefulWidget {
  const TautulliHistoryRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<TautulliHistoryRoute> createState() => _State();
}

class _State extends State<TautulliHistoryRoute>
    with AutomaticKeepAliveClientMixin, ArrPilotLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> loadCallback() async {
    context.read<TautulliState>().resetHistory();
    await context.read<TautulliState>().history;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      module: ArrPilotModule.TAUTULLI,
      body: _body(),
    );
  }

  Widget _body() {
    return ArrPilotRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: Selector<TautulliState, Future<TautulliHistory>>(
        selector: (_, state) => state.history!,
        builder: (context, history, _) => FutureBuilder(
          future: history,
          builder: (context, AsyncSnapshot<TautulliHistory> snapshot) {
            if (snapshot.hasError) {
              if (snapshot.connectionState != ConnectionState.waiting)
                ArrPilotLogger().error(
                  'Unable to fetch Tautulli history',
                  snapshot.error,
                  snapshot.stackTrace,
                );
              return ArrPilotMessage.error(onTap: _refreshKey.currentState!.show);
            }
            if (snapshot.hasData) return _history(snapshot.data);
            return const ArrPilotLoader();
          },
        ),
      ),
    );
  }

  Widget _history(TautulliHistory? history) {
    if ((history?.records?.length ?? 0) == 0)
      return ArrPilotMessage(
        text: 'No History Found',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState!.show,
      );
    return ArrPilotListViewBuilder(
      controller: TautulliNavigationBar.scrollControllers[2],
      itemCount: history!.records!.length,
      itemExtent: ArrPilotBlock.calculateItemExtent(3),
      itemBuilder: (context, index) =>
          TautulliHistoryTile(history: history.records![index]),
    );
  }
}

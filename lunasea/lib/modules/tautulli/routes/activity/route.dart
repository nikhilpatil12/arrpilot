import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/tautulli.dart';

class TautulliActivityRoute extends StatefulWidget {
  const TautulliActivityRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<TautulliActivityRoute> createState() => _State();
}

class _State extends State<TautulliActivityRoute>
    with AutomaticKeepAliveClientMixin, ArrPilotLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> loadCallback() async {
    context.read<TautulliState>().resetActivity();
    await context.read<TautulliState>().activity;
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
      child: FutureBuilder(
        future: context.select<TautulliState, Future<TautulliActivity?>>(
            (state) => state.activity!),
        builder: (context, AsyncSnapshot<TautulliActivity?> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting)
              ArrPilotLogger().error(
                'Unable to fetch Tautulli activity',
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

  Widget _list(TautulliActivity? activity) {
    if ((activity?.sessions?.length ?? 0) == 0)
      return ArrPilotMessage(
        text: 'tautulli.NoActiveStreams'.tr(),
        buttonText: 'arrpilot.Refresh'.tr(),
        onTap: _refreshKey.currentState!.show,
      );
    return ArrPilotListView(
      controller: TautulliNavigationBar.scrollControllers[0],
      children: [
        TautulliActivityStatus(activity: activity),
        ...List.generate(
          activity!.sessions!.length,
          (index) => TautulliActivityTile(session: activity.sessions![index]),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/tautulli.dart';

class SyncedItemsRoute extends StatefulWidget {
  const SyncedItemsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<SyncedItemsRoute> createState() => _State();
}

class _State extends State<SyncedItemsRoute>
    with ArrPilotScrollControllerMixin, ArrPilotLoadCallbackMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Future<void> loadCallback() async {
    context.read<TautulliState>().resetSyncedItems();
    await context.read<TautulliState>().syncedItems;
  }

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      module: ArrPilotModule.TAUTULLI,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return ArrPilotAppBar(
      title: 'Synced Items',
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return ArrPilotRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: Selector<TautulliState, Future<List<TautulliSyncedItem>>?>(
        selector: (_, state) => state.syncedItems,
        builder: (context, synced, _) => FutureBuilder(
          future: synced,
          builder: (context, AsyncSnapshot<List<TautulliSyncedItem>> snapshot) {
            if (snapshot.hasError) {
              if (snapshot.connectionState != ConnectionState.waiting)
                ArrPilotLogger().error(
                  'Unable to fetch Tautulli synced items',
                  snapshot.error,
                  snapshot.stackTrace,
                );
              return ArrPilotMessage.error(onTap: _refreshKey.currentState!.show);
            }
            if (snapshot.hasData) return _list(snapshot.data);
            return const ArrPilotLoader();
          },
        ),
      ),
    );
  }

  Widget _list(List<TautulliSyncedItem>? syncedItems) {
    if ((syncedItems?.length ?? 0) == 0)
      return ArrPilotMessage(
        text: 'No Synced Items Found',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState!.show,
      );
    return ArrPilotListViewBuilder(
      controller: scrollController,
      itemCount: syncedItems!.length,
      itemBuilder: (context, index) =>
          TautulliSyncedItemTile(syncedItem: syncedItems[index]),
    );
  }
}

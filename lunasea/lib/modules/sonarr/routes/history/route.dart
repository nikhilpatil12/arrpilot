import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/sonarr.dart';

class HistoryRoute extends StatefulWidget {
  const HistoryRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryRoute> createState() => _State();
}

class _State extends State<HistoryRoute>
    with ArrPilotScrollControllerMixin, ArrPilotLoadCallbackMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  final _pagingController =
      PagingController<int, SonarrHistoryRecord>(firstPageKey: 1);

  @override
  Future<void> loadCallback() async {
    context.read<SonarrState>().fetchAllSeries();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    await context
        .read<SonarrState>()
        .api!
        .history
        .get(
          page: pageKey,
          pageSize: SonarrDatabase.CONTENT_PAGE_SIZE.read(),
          sortKey: SonarrHistorySortKey.DATE,
          sortDirection: SonarrSortDirection.DESCENDING,
          includeEpisode: true,
        )
        .then((data) {
      if (data.totalRecords! > (data.page! * data.pageSize!)) {
        return _pagingController.appendPage(data.records!, pageKey + 1);
      }
      return _pagingController.appendLastPage(data.records!);
    }).catchError((error, stack) {
      ArrPilotLogger().error(
        'Unable to fetch Sonarr history page: $pageKey',
        error,
        stack,
      );
      _pagingController.error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return ArrPilotAppBar(
      title: 'sonarr.History'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return FutureBuilder(
      future: context.read<SonarrState>().series,
      builder: (context, AsyncSnapshot<Map<int, SonarrSeries>> snapshot) {
        if (snapshot.hasError) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            ArrPilotLogger().error(
              'Unable to fetch Sonarr series',
              snapshot.error,
              snapshot.stackTrace,
            );
          }
          return ArrPilotMessage.error(onTap: _refreshKey.currentState!.show);
        }
        if (snapshot.hasData) return _list(snapshot.data);
        return const ArrPilotLoader();
      },
    );
  }

  Widget _list(Map<int, SonarrSeries>? series) {
    return ArrPilotPagedListView<SonarrHistoryRecord>(
      refreshKey: _refreshKey,
      pagingController: _pagingController,
      scrollController: scrollController,
      listener: _fetchPage,
      noItemsFoundMessage: 'sonarr.NoHistoryFound'.tr(),
      itemBuilder: (context, history, _) => SonarrHistoryTile(
        history: history,
        series: series![history.seriesId!],
        type: SonarrHistoryTileType.ALL,
      ),
    );
  }
}

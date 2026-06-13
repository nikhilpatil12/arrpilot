import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/settings.dart';
import 'package:arrpilot/modules/sonarr.dart';
import 'package:arrpilot/types/list_view_option.dart';

class ConfigurationSonarrDefaultOptionsRoute extends StatefulWidget {
  const ConfigurationSonarrDefaultOptionsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationSonarrDefaultOptionsRoute> createState() => _State();
}

class _State extends State<ConfigurationSonarrDefaultOptionsRoute>
    with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return ArrPilotAppBar(
      title: 'settings.DefaultOptions'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return ArrPilotListView(
      controller: scrollController,
      children: [
        ArrPilotHeader(text: 'sonarr.Series'.tr()),
        _filteringSeries(),
        _sortingSeries(),
        _sortingSeriesDirection(),
        _viewSeries(),
        ArrPilotHeader(text: 'sonarr.Releases'.tr()),
        _filteringReleases(),
        _sortingReleases(),
        _sortingReleasesDirection(),
      ],
    );
  }

  Widget _viewSeries() {
    const _db = SonarrDatabase.DEFAULT_VIEW_SERIES;
    return _db.listenableBuilder(
      builder: (context, _) {
        ArrPilotListViewOption _view = _db.read();
        return ArrPilotBlock(
          title: 'arrpilot.View'.tr(),
          body: [TextSpan(text: _view.readable)],
          trailing: const ArrPilotIconButton.arrow(),
          onTap: () async {
            List<String> titles = ArrPilotListViewOption.values
                .map<String>((view) => view.readable)
                .toList();
            List<IconData> icons = ArrPilotListViewOption.values
                .map<IconData>((view) => view.icon)
                .toList();

            Tuple2<bool, int> values = await SettingsDialogs().setDefaultOption(
              context,
              title: 'arrpilot.View'.tr(),
              values: titles,
              icons: icons,
            );

            if (values.item1) {
              ArrPilotListViewOption _opt = ArrPilotListViewOption.values[values.item2];
              context.read<SonarrState>().seriesViewType = _opt;
              _db.update(_opt);
            }
          },
        );
      },
    );
  }

  Widget _sortingSeries() {
    const _db = SonarrDatabase.DEFAULT_SORTING_SERIES;
    return _db.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'settings.SortCategory'.tr(),
        body: [TextSpan(text: _db.read().readable)],
        trailing: const ArrPilotIconButton.arrow(),
        onTap: () async {
          List<String?> titles = SonarrSeriesSorting.values
              .map<String?>((sorting) => sorting.readable)
              .toList();
          List<IconData> icons = List.filled(titles.length, ArrPilotIcons.SORT);

          Tuple2<bool, int> values = await SettingsDialogs().setDefaultOption(
            context,
            title: 'settings.SortCategory'.tr(),
            values: titles,
            icons: icons,
          );

          if (values.item1) {
            _db.update(SonarrSeriesSorting.values[values.item2]);
            context.read<SonarrState>().seriesSortType = _db.read();
            context.read<SonarrState>().seriesSortAscending =
                SonarrDatabase.DEFAULT_SORTING_SERIES_ASCENDING.read();
          }
        },
      ),
    );
  }

  Widget _sortingSeriesDirection() {
    const _db = SonarrDatabase.DEFAULT_SORTING_SERIES_ASCENDING;
    return _db.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'settings.SortDirection'.tr(),
        body: [
          TextSpan(
            text: _db.read()
                ? 'arrpilot.Ascending'.tr()
                : 'arrpilot.Descending'.tr(),
          ),
        ],
        trailing: ArrPilotSwitch(
          value: _db.read(),
          onChanged: _db.update,
        ),
      ),
    );
  }

  Widget _filteringSeries() {
    const _db = SonarrDatabase.DEFAULT_FILTERING_SERIES;
    return _db.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'settings.FilterCategory'.tr(),
        body: [TextSpan(text: _db.read().readable)],
        trailing: const ArrPilotIconButton.arrow(),
        onTap: () async {
          List<String> titles = SonarrSeriesFilter.values
              .map<String>((sorting) => sorting.readable)
              .toList();
          List<IconData> icons = List.filled(titles.length, ArrPilotIcons.FILTER);

          Tuple2<bool, int> values = await SettingsDialogs().setDefaultOption(
            context,
            title: 'settings.FilterCategory'.tr(),
            values: titles,
            icons: icons,
          );

          if (values.item1) {
            _db.update(SonarrSeriesFilter.values[values.item2]);
          }
        },
      ),
    );
  }

  Widget _sortingReleases() {
    const _db = SonarrDatabase.DEFAULT_SORTING_RELEASES;
    return _db.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'settings.SortCategory'.tr(),
        body: [TextSpan(text: _db.read().readable)],
        trailing: const ArrPilotIconButton.arrow(),
        onTap: () async {
          List<String?> titles = SonarrReleasesSorting.values
              .map<String?>((sorting) => sorting.readable)
              .toList();
          List<IconData> icons = List.filled(titles.length, ArrPilotIcons.SORT);

          Tuple2<bool, int> values = await SettingsDialogs().setDefaultOption(
            context,
            title: 'settings.SortCategory'.tr(),
            values: titles,
            icons: icons,
          );

          if (values.item1) {
            _db.update(SonarrReleasesSorting.values[values.item2]);
          }
        },
      ),
    );
  }

  Widget _sortingReleasesDirection() {
    const _db = SonarrDatabase.DEFAULT_SORTING_RELEASES_ASCENDING;
    return _db.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'settings.SortDirection'.tr(),
        body: [
          TextSpan(
            text: _db.read()
                ? 'arrpilot.Ascending'.tr()
                : 'arrpilot.Descending'.tr(),
          ),
        ],
        trailing: ArrPilotSwitch(
          value: _db.read(),
          onChanged: _db.update,
        ),
      ),
    );
  }

  Widget _filteringReleases() {
    const _db = SonarrDatabase.DEFAULT_FILTERING_RELEASES;
    return _db.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'settings.FilterCategory'.tr(),
        body: [TextSpan(text: _db.read().readable)],
        trailing: const ArrPilotIconButton.arrow(),
        onTap: () async {
          List<String> titles = SonarrReleasesFilter.values
              .map<String>((sorting) => sorting.readable)
              .toList();
          List<IconData> icons = List.filled(titles.length, ArrPilotIcons.FILTER);

          Tuple2<bool, int> values = await SettingsDialogs().setDefaultOption(
            context,
            title: 'settings.FilterCategory'.tr(),
            values: titles,
            icons: icons,
          );

          if (values.item1) {
            _db.update(SonarrReleasesFilter.values[values.item2]);
          }
        },
      ),
    );
  }
}

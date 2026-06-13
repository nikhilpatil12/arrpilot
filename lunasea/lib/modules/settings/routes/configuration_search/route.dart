import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/database/models/indexer.dart';
import 'package:arrpilot/modules/search/core.dart';
import 'package:arrpilot/router/routes/settings.dart';

class ConfigurationSearchRoute extends StatefulWidget {
  const ConfigurationSearchRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationSearchRoute> createState() => _State();
}

class _State extends State<ConfigurationSearchRoute>
    with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  PreferredSizeWidget _appBar() {
    return ArrPilotAppBar(
      title: 'search.Search'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _bottomNavigationBar() {
    return ArrPilotBottomActionBar(
      actions: [
        ArrPilotButton.text(
          text: 'search.AddIndexer'.tr(),
          icon: Icons.add_rounded,
          onTap: SettingsRoutes.CONFIGURATION_SEARCH_ADD_INDEXER.go,
        ),
      ],
    );
  }

  Widget _body() {
    return ArrPilotBox.indexers.listenableBuilder(
      builder: (context, _) => ArrPilotListView(
        controller: scrollController,
        children: [
          ArrPilotModule.SEARCH.informationBanner(),
          ..._indexerSection(),
          ..._customization(),
        ],
      ),
    );
  }

  List<Widget> _indexerSection() {
    if (ArrPilotBox.indexers.isEmpty) {
      return [ArrPilotMessage(text: 'search.NoIndexersFound'.tr())];
    }
    return _indexers;
  }

  List<Widget> get _indexers {
    List<ArrPilotIndexer> indexers = ArrPilotBox.indexers.data.toList();
    indexers.sort((a, b) =>
        a.displayName.toLowerCase().compareTo(b.displayName.toLowerCase()));
    List<ArrPilotBlock> list = List.generate(
      indexers.length,
      (index) =>
          _indexerTile(indexers[index], indexers[index].key) as ArrPilotBlock,
    );
    return list;
  }

  Widget _indexerTile(ArrPilotIndexer indexer, int index) {
    return ArrPilotBlock(
      title: indexer.displayName,
      body: [TextSpan(text: indexer.host)],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () => SettingsRoutes.CONFIGURATION_SEARCH_EDIT_INDEXER.go(
        params: {
          'id': index.toString(),
        },
      ),
    );
  }

  List<Widget> _customization() {
    return [
      ArrPilotDivider(),
      _hideAdultCategories(),
      _showLinks(),
    ];
  }

  Widget _hideAdultCategories() {
    const _db = SearchDatabase.HIDE_XXX;
    return _db.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'search.HideAdultCategories'.tr(),
        body: [TextSpan(text: 'search.HideAdultCategoriesDescription'.tr())],
        trailing: ArrPilotSwitch(
          value: _db.read(),
          onChanged: _db.update,
        ),
      ),
    );
  }

  Widget _showLinks() {
    const _db = SearchDatabase.SHOW_LINKS;
    return _db.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'search.ShowLinks'.tr(),
        body: [TextSpan(text: 'search.ShowLinksDescription'.tr())],
        trailing: ArrPilotSwitch(
          value: _db.read(),
          onChanged: _db.update,
        ),
      ),
    );
  }
}

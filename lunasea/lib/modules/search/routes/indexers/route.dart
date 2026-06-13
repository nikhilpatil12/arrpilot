import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/search.dart';

class SearchRoute extends StatefulWidget {
  const SearchRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchRoute> createState() => _State();
}

class _State extends State<SearchRoute> with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      drawer: _drawer(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return ArrPilotAppBar(
      useDrawer: true,
      title: ArrPilotModule.SEARCH.title,
      scrollControllers: [scrollController],
    );
  }

  Widget _drawer() => ArrPilotDrawer(page: ArrPilotModule.SEARCH.key);

  Widget _body() {
    if (ArrPilotBox.indexers.isEmpty) {
      return ArrPilotMessage.moduleNotEnabled(
        context: context,
        module: ArrPilotModule.SEARCH.title,
      );
    }
    return ArrPilotListView(
      controller: scrollController,
      children: _list,
    );
  }

  List<Widget> get _list {
    final list = ArrPilotBox.indexers.data
        .map((indexer) => SearchIndexerTile(indexer: indexer))
        .toList();
    list.sort((a, b) => a.indexer!.displayName
        .toLowerCase()
        .compareTo(b.indexer!.displayName.toLowerCase()));

    return list;
  }
}

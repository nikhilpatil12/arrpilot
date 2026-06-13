import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/database/models/indexer.dart';
import 'package:arrpilot/modules/settings.dart';
import 'package:arrpilot/widgets/pages/invalid_route.dart';

class ConfigurationSearchEditIndexerHeadersRoute extends StatefulWidget {
  final int id;

  const ConfigurationSearchEditIndexerHeadersRoute({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ConfigurationSearchEditIndexerHeadersRoute> createState() => _State();
}

class _State extends State<ConfigurationSearchEditIndexerHeadersRoute>
    with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ArrPilotIndexer? _indexer;

  @override
  Widget build(BuildContext context) {
    if (widget.id < 0 || !ArrPilotBox.indexers.contains(widget.id)) {
      return InvalidRoutePage(
        title: 'settings.CustomHeaders'.tr(),
        message: 'search.IndexerNotFound'.tr(),
      );
    }

    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
      bottomNavigationBar: _bottomActionBar(),
    );
  }

  Widget _appBar() {
    return ArrPilotAppBar(
      title: 'settings.CustomHeaders'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _bottomActionBar() {
    return ArrPilotBottomActionBar(
      actions: [
        ArrPilotButton.text(
          text: 'settings.AddHeader'.tr(),
          icon: Icons.add_rounded,
          onTap: () async => HeaderUtility().addHeader(context,
              headers: _indexer!.headers, indexer: _indexer),
        ),
      ],
    );
  }

  Widget _body() {
    return ArrPilotBox.indexers.listenableBuilder(
      selectKeys: [widget.id],
      builder: (context, _) {
        if (!ArrPilotBox.indexers.contains(widget.id)) return Container();
        _indexer = ArrPilotBox.indexers.read(widget.id);
        return ArrPilotListView(
          controller: scrollController,
          children: [
            if (_indexer!.headers.isEmpty)
              ArrPilotMessage.inList(text: 'settings.NoHeadersAdded'.tr()),
            ..._list(),
          ],
        );
      },
    );
  }

  List<Widget> _list() {
    final headers = _indexer!.headers.cast<String, dynamic>();
    List<String> _sortedKeys = headers.keys.toList()..sort();
    return _sortedKeys
        .map<ArrPilotBlock>((key) => _headerBlock(key, headers[key]))
        .toList();
  }

  ArrPilotBlock _headerBlock(String key, String? value) {
    return ArrPilotBlock(
      title: key.toString(),
      body: [TextSpan(text: value.toString())],
      trailing: ArrPilotIconButton(
        icon: ArrPilotIcons.DELETE,
        color: ArrPilotColours.red,
        onPressed: () async => HeaderUtility().deleteHeader(
          context,
          headers: _indexer!.headers,
          key: key,
          indexer: _indexer,
        ),
      ),
    );
  }
}

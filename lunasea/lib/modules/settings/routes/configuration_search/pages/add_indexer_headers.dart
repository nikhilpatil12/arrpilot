import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/database/models/indexer.dart';
import 'package:arrpilot/modules/settings.dart';
import 'package:arrpilot/widgets/pages/invalid_route.dart';

class ConfigurationSearchAddIndexerHeadersRoute extends StatefulWidget {
  final ArrPilotIndexer? indexer;

  const ConfigurationSearchAddIndexerHeadersRoute({
    Key? key,
    required this.indexer,
  }) : super(key: key);

  @override
  State<ConfigurationSearchAddIndexerHeadersRoute> createState() => _State();
}

class _State extends State<ConfigurationSearchAddIndexerHeadersRoute>
    with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (widget.indexer == null) {
      return InvalidRoutePage(
        title: 'settings.CustomHeaders'.tr(),
        message: 'search.IndexerNotFound'.tr(),
      );
    }

    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: _bottomActionBar(),
    );
  }

  PreferredSizeWidget _appBar() {
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
          onTap: () async {
            await HeaderUtility()
                .addHeader(context, headers: widget.indexer!.headers);
            if (mounted) setState(() {});
          },
        ),
      ],
    );
  }

  Widget _body() {
    return ArrPilotListView(
      controller: scrollController,
      children: [
        if (widget.indexer!.headers.isEmpty)
          ArrPilotMessage.inList(text: 'settings.NoHeadersAdded'.tr()),
        ..._list(),
      ],
    );
  }

  List<Widget> _list() {
    final headers = widget.indexer!.headers.cast<String, dynamic>();
    List<String> _sortedKeys = headers.keys.toList()..sort();
    return _sortedKeys
        .map<ArrPilotBlock>((key) => _headerTile(key, headers[key]))
        .toList();
  }

  ArrPilotBlock _headerTile(String key, String? value) {
    return ArrPilotBlock(
      title: key.toString(),
      body: [TextSpan(text: value.toString())],
      trailing: ArrPilotIconButton(
        icon: ArrPilotIcons.DELETE,
        color: ArrPilotColours.red,
        onPressed: () async {
          await HeaderUtility().deleteHeader(
            context,
            headers: widget.indexer!.headers,
            key: key,
          );
          if (mounted) setState(() {});
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/database/models/indexer.dart';
import 'package:arrpilot/modules/settings.dart';
import 'package:arrpilot/widgets/pages/invalid_route.dart';
import 'package:arrpilot/router/routes/settings.dart';

class ConfigurationSearchEditIndexerRoute extends StatefulWidget {
  final int id;

  const ConfigurationSearchEditIndexerRoute({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ConfigurationSearchEditIndexerRoute> createState() => _State();
}

class _State extends State<ConfigurationSearchEditIndexerRoute>
    with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ArrPilotIndexer? _indexer;

  @override
  Widget build(BuildContext context) {
    if (widget.id < 0 || !ArrPilotBox.indexers.contains(widget.id)) {
      return InvalidRoutePage(
        title: 'search.EditIndexer'.tr(),
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
      title: 'search.EditIndexer'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _bottomActionBar() {
    return ArrPilotBottomActionBar(
      actions: [
        ArrPilotButton.text(
          text: 'search.DeleteIndexer'.tr(),
          icon: Icons.delete_rounded,
          color: ArrPilotColours.red,
          onTap: () async {
            bool result = await SettingsDialogs().deleteIndexer(context);
            if (result) {
              showLunaSuccessSnackBar(
                title: 'search.IndexerDeleted'.tr(),
                message: _indexer!.displayName,
              );
              _indexer!.delete();
              Navigator.of(context).pop();
            }
          },
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
            _displayName(),
            _apiURL(),
            _apiKey(),
            _headers(),
          ],
        );
      },
    );
  }

  Widget _displayName() {
    String _name = _indexer!.displayName;
    return ArrPilotBlock(
      title: 'settings.DisplayName'.tr(),
      body: [TextSpan(text: _name.isEmpty ? 'arrpilot.NotSet'.tr() : _name)],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await ArrPilotDialogs().editText(
          context,
          'settings.DisplayName'.tr(),
          prefill: _indexer!.displayName,
        );
        if (values.item1) {
          _indexer!.displayName = values.item2;
        }
        _indexer!.save();
      },
    );
  }

  Widget _apiURL() {
    String _host = _indexer!.host;
    return ArrPilotBlock(
      title: 'search.IndexerAPIHost'.tr(),
      body: [TextSpan(text: _host.isEmpty ? 'arrpilot.NotSet'.tr() : _host)],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await ArrPilotDialogs().editText(
          context,
          'search.IndexerAPIHost'.tr(),
          prefill: _host,
        );
        if (values.item1 && mounted) {
          _indexer!.host = values.item2;
        }
        _indexer!.save();
      },
    );
  }

  Widget _apiKey() {
    String _key = _indexer!.apiKey;
    return ArrPilotBlock(
      title: 'search.IndexerAPIKey'.tr(),
      body: [TextSpan(text: _key.isEmpty ? 'arrpilot.NotSet'.tr() : _key)],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await ArrPilotDialogs().editText(
          context,
          'search.IndexerAPIKey'.tr(),
          prefill: _key,
        );
        if (values.item1) {
          _indexer!.apiKey = values.item2;
        }
        _indexer!.save();
      },
    );
  }

  Widget _headers() {
    return ArrPilotBlock(
      title: 'settings.CustomHeaders'.tr(),
      body: [TextSpan(text: 'settings.CustomHeadersDescription'.tr())],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () => SettingsRoutes.CONFIGURATION_SEARCH_EDIT_INDEXER_HEADERS.go(
        params: {
          'id': widget.id.toString(),
        },
      ),
    );
  }
}

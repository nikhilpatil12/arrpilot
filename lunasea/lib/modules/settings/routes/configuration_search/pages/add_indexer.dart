import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/database/models/indexer.dart';
import 'package:arrpilot/router/routes/settings.dart';

class ConfigurationSearchAddIndexerRoute extends StatefulWidget {
  const ConfigurationSearchAddIndexerRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationSearchAddIndexerRoute> createState() => _State();
}

class _State extends State<ConfigurationSearchAddIndexerRoute>
    with ArrPilotScrollControllerMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _indexer = ArrPilotIndexer();

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: _bottomActionBar(),
    );
  }

  PreferredSizeWidget _appBar() {
    return ArrPilotAppBar(
      title: 'search.AddIndexer'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _bottomActionBar() {
    return ArrPilotBottomActionBar(
      actions: [
        ArrPilotButton.text(
          text: 'search.AddIndexer'.tr(),
          icon: Icons.add_rounded,
          onTap: () async {
            if (_indexer.displayName.isEmpty ||
                _indexer.host.isEmpty ||
                _indexer.apiKey.isEmpty) {
              showLunaErrorSnackBar(
                title: 'search.FailedToAddIndexer'.tr(),
                message: 'settings.AllFieldsAreRequired'.tr(),
              );
            } else {
              ArrPilotBox.indexers.create(_indexer);
              showLunaSuccessSnackBar(
                title: 'search.IndexerAdded'.tr(),
                message: _indexer.displayName,
              );
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  Widget _body() {
    return ArrPilotListView(
      controller: scrollController,
      children: [
        _displayName(),
        _apiURL(),
        _apiKey(),
        _headers(),
      ],
    );
  }

  Widget _displayName() {
    String _name = _indexer.displayName;
    return ArrPilotBlock(
      title: 'settings.DisplayName'.tr(),
      body: [TextSpan(text: _name.isEmpty ? 'arrpilot.NotSet'.tr() : _name)],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> values = await ArrPilotDialogs().editText(
          context,
          'settings.DisplayName'.tr(),
          prefill: _name,
        );
        if (values.item1 && mounted) {
          setState(() => _indexer.displayName = values.item2);
        }
      },
    );
  }

  Widget _apiURL() {
    String _host = _indexer.host;
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
          setState(() => _indexer.host = values.item2);
        }
      },
    );
  }

  Widget _apiKey() {
    String _key = _indexer.apiKey;
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
        if (values.item1 && mounted) {
          setState(() => _indexer.apiKey = values.item2);
        }
      },
    );
  }

  Widget _headers() {
    return ArrPilotBlock(
      title: 'settings.CustomHeaders'.tr(),
      body: [TextSpan(text: 'settings.CustomHeadersDescription'.tr())],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () => SettingsRoutes.CONFIGURATION_SEARCH_ADD_INDEXER_HEADERS.go(
        extra: _indexer,
      ),
    );
  }
}

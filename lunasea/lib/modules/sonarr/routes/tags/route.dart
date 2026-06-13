import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/sonarr.dart';

class TagsRoute extends StatefulWidget {
  const TagsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TagsRoute>
    with ArrPilotScrollControllerMixin, ArrPilotLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Future<void> loadCallback() async {
    context.read<SonarrState>().fetchTags();
    await context.read<SonarrState>().tags;
  }

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
      title: 'Tags',
      scrollControllers: [scrollController],
      actions: const [
        SonarrTagsAppBarActionAddTag(),
      ],
    );
  }

  Widget _body() {
    return ArrPilotRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: FutureBuilder(
        future: context.watch<SonarrState>().tags,
        builder: (context, AsyncSnapshot<List<SonarrTag>> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              ArrPilotLogger().error(
                'Unable to fetch Sonarr tags',
                snapshot.error,
                snapshot.stackTrace,
              );
            }
            return ArrPilotMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.hasData) return _list(snapshot.data);
          return const ArrPilotLoader();
        },
      ),
    );
  }

  Widget _list(List<SonarrTag>? tags) {
    if ((tags?.length ?? 0) == 0)
      return ArrPilotMessage(
        text: 'sonarr.NoTagsFound'.tr(),
        buttonText: 'arrpilot.Refresh'.tr(),
        onTap: _refreshKey.currentState?.show,
      );
    return ArrPilotListViewBuilder(
      controller: scrollController,
      itemCount: tags!.length,
      itemBuilder: (context, index) => SonarrTagsTagTile(
        key: ObjectKey(tags[index].id),
        tag: tags[index],
      ),
    );
  }
}

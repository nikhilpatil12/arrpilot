import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/search.dart';
import 'package:arrpilot/router/routes/search.dart';

class CategoriesRoute extends StatefulWidget {
  const CategoriesRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoriesRoute> createState() => _State();
}

class _State extends State<CategoriesRoute>
    with ArrPilotLoadCallbackMixin, ArrPilotScrollControllerMixin {
  static const ADULT_CATEGORIES = ['xxx', 'adult', 'porn'];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Future<void> loadCallback() async {
    context.read<SearchState>().fetchCategories();
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
      title: context.read<SearchState>().indexer.displayName,
      scrollControllers: [scrollController],
      actions: <Widget>[
        ArrPilotIconButton(
          icon: Icons.search_rounded,
          onPressed: _enterSearch,
        ),
      ],
    );
  }

  Widget _body() {
    return ArrPilotRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: FutureBuilder(
        future: context.watch<SearchState>().categories,
        builder: (context, AsyncSnapshot<List<NewznabCategoryData>> snapshot) {
          if (snapshot.hasError) {
            ArrPilotLogger().error(
              'Unable to fetch categories',
              snapshot.error,
              snapshot.stackTrace,
            );
            return ArrPilotMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) return _list(snapshot.data!);
          return const ArrPilotLoader();
        },
      ),
    );
  }

  Widget _list(List<NewznabCategoryData> categories) {
    if (categories.isEmpty) {
      return ArrPilotMessage.goBack(
        context: context,
        text: 'search.NoCategoriesFound'.tr(),
      );
    }
    List<NewznabCategoryData> filtered = _filter(categories);
    return ArrPilotListViewBuilder(
      controller: scrollController,
      itemCount: filtered.length,
      itemBuilder: (context, index) => SearchCategoryTile(
        category: filtered[index],
        index: index,
      ),
    );
  }

  List<NewznabCategoryData> _filter(List<NewznabCategoryData> categories) {
    return categories.where((category) {
      if (!SearchDatabase.HIDE_XXX.read()) return true;
      if (category.id >= 6000 && category.id <= 6999) return false;
      if (ADULT_CATEGORIES.contains(category.name!.toLowerCase().trim())) {
        return false;
      }
      return true;
    }).toList();
  }

  Future<void> _enterSearch() async {
    context.read<SearchState>().activeCategory = null;
    context.read<SearchState>().activeSubcategory = null;
    SearchRoutes.SEARCH.go();
  }
}

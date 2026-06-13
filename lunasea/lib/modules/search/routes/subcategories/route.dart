import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/search.dart';
import 'package:arrpilot/router/routes/search.dart';

class SubcategoriesRoute extends StatefulWidget {
  const SubcategoriesRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<SubcategoriesRoute> createState() => _State();
}

class _State extends State<SubcategoriesRoute> with ArrPilotScrollControllerMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
      title: context.read<SearchState>().activeCategory?.name ??
          'search.Subcategories'.tr(),
      scrollControllers: [scrollController],
      actions: [
        ArrPilotIconButton(
          icon: Icons.search_rounded,
          onPressed: () async {
            context.read<SearchState>().activeSubcategory = null;
            SearchRoutes.SEARCH.go();
          },
        ),
      ],
    );
  }

  Widget _body() {
    return Selector<SearchState, NewznabCategoryData?>(
      selector: (_, state) => state.activeCategory,
      builder: (context, category, child) {
        List<NewznabSubcategoryData> subcategories =
            category?.subcategories ?? [];
        return ArrPilotListView(
          controller: scrollController,
          children: [
            const SearchSubcategoryAllTile(),
            ...List.generate(
              subcategories.length,
              (index) => SearchSubcategoryTile(index: index),
            ),
          ],
        );
      },
    );
  }
}

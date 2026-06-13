import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/search.dart';
import 'package:arrpilot/router/routes/search.dart';

class SearchSubcategoryAllTile extends StatelessWidget {
  const SearchSubcategoryAllTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<SearchState, NewznabCategoryData?>(
      selector: (_, state) => state.activeCategory,
      builder: (context, category, _) => ArrPilotBlock(
        title: 'search.AllSubcategories'.tr(),
        body: [TextSpan(text: category?.name ?? 'arrpilot.Unknown'.tr())],
        trailing: ArrPilotIconButton(
            icon: context.read<SearchState>().activeCategory?.icon,
            color: ArrPilotColours().byListIndex(0)),
        onTap: () async {
          context.read<SearchState>().activeSubcategory = null;
          SearchRoutes.RESULTS.go();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/search.dart';
import 'package:arrpilot/router/routes/search.dart';

class SearchSubcategoryTile extends StatelessWidget {
  final int index;

  const SearchSubcategoryTile({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<SearchState, NewznabCategoryData?>(
      selector: (_, state) => state.activeCategory,
      builder: (context, category, _) {
        NewznabSubcategoryData subcategory = category!.subcategories[index];
        return ArrPilotBlock(
          title: subcategory.name ?? 'arrpilot.Unknown'.tr(),
          body: [
            TextSpan(
              text: [
                category.name ?? 'arrpilot.Unknown'.tr(),
                subcategory.name ?? 'arrpilot.Unknown'.tr(),
              ].join(' > '),
            )
          ],
          trailing: ArrPilotIconButton(
            icon: category.icon,
            color: ArrPilotColours().byListIndex(index + 1),
          ),
          onTap: () async {
            context.read<SearchState>().activeSubcategory = subcategory;
            SearchRoutes.RESULTS.go();
          },
        );
      },
    );
  }
}

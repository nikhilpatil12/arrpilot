import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/search.dart';
import 'package:arrpilot/router/routes/search.dart';

class SearchCategoryTile extends StatelessWidget {
  final NewznabCategoryData category;
  final int index;

  const SearchCategoryTile({
    Key? key,
    required this.category,
    this.index = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      title: category.name ?? 'arrpilot.Unknown'.tr(),
      body: [TextSpan(text: category.subcategoriesTitleList)],
      trailing: ArrPilotIconButton(
        icon: category.icon,
        color: ArrPilotColours().byListIndex(index),
      ),
      onTap: () async {
        context.read<SearchState>().activeCategory = category;
        SearchRoutes.SUBCATEGORIES.go();
      },
    );
  }
}

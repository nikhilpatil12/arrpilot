import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/scroll_controller.dart';
import 'package:arrpilot/modules/radarr.dart';

class RadarrCatalogueSearchBarSortButton extends StatefulWidget {
  final ScrollController controller;

  const RadarrCatalogueSearchBarSortButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<RadarrCatalogueSearchBarSortButton> createState() => _State();
}

class _State extends State<RadarrCatalogueSearchBarSortButton> {
  @override
  Widget build(BuildContext context) {
    return ArrPilotCard(
      context: context,
      child: Consumer<RadarrState>(
        builder: (context, state, _) =>
            ArrPilotPopupMenuButton<RadarrMoviesSorting>(
          tooltip: 'radarr.SortCatalogue'.tr(),
          icon: ArrPilotIcons.SORT,
          onSelected: (result) {
            if (state.moviesSortType == result) {
              state.moviesSortAscending = !state.moviesSortAscending;
            } else {
              state.moviesSortAscending = true;
              state.moviesSortType = result;
            }
            widget.controller.animateToStart();
          },
          itemBuilder: (context) =>
              List<PopupMenuEntry<RadarrMoviesSorting>>.generate(
            RadarrMoviesSorting.values.length,
            (index) => PopupMenuItem<RadarrMoviesSorting>(
              value: RadarrMoviesSorting.values[index],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    RadarrMoviesSorting.values[index].readable,
                    style: TextStyle(
                      fontSize: ArrPilotUI.FONT_SIZE_H3,
                      color: state.moviesSortType ==
                              RadarrMoviesSorting.values[index]
                          ? ArrPilotColours.accent
                          : Colors.white,
                    ),
                  ),
                  if (state.moviesSortType == RadarrMoviesSorting.values[index])
                    Icon(
                      state.moviesSortAscending
                          ? Icons.arrow_upward_rounded
                          : Icons.arrow_downward_rounded,
                      size: ArrPilotUI.FONT_SIZE_H2,
                      color: ArrPilotColours.accent,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      margin: const EdgeInsets.only(left: ArrPilotUI.DEFAULT_MARGIN_SIZE),
      color: Theme.of(context).canvasColor,
      height: ArrPilotTextInputBar.defaultHeight,
      width: ArrPilotTextInputBar.defaultHeight,
    );
  }
}

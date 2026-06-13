import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/scroll_controller.dart';
import 'package:arrpilot/modules/radarr.dart';

class RadarrCatalogueSearchBarFilterButton extends StatefulWidget {
  final ScrollController controller;

  const RadarrCatalogueSearchBarFilterButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<RadarrCatalogueSearchBarFilterButton> createState() => _State();
}

class _State extends State<RadarrCatalogueSearchBarFilterButton> {
  @override
  Widget build(BuildContext context) {
    return ArrPilotCard(
      context: context,
      child: Consumer<RadarrState>(
        builder: (context, state, _) => ArrPilotPopupMenuButton<RadarrMoviesFilter>(
          tooltip: 'radarr.FilterCatalogue'.tr(),
          icon: ArrPilotIcons.FILTER,
          onSelected: (result) {
            state.moviesFilterType = result;
            widget.controller.animateToStart();
          },
          itemBuilder: (context) =>
              List<PopupMenuEntry<RadarrMoviesFilter>>.generate(
            RadarrMoviesFilter.values.length,
            (index) => PopupMenuItem<RadarrMoviesFilter>(
              value: RadarrMoviesFilter.values[index],
              child: Text(
                RadarrMoviesFilter.values[index].readable,
                style: TextStyle(
                  fontSize: ArrPilotUI.FONT_SIZE_H3,
                  color:
                      state.moviesFilterType == RadarrMoviesFilter.values[index]
                          ? ArrPilotColours.accent
                          : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      height: ArrPilotTextInputBar.defaultHeight,
      width: ArrPilotTextInputBar.defaultHeight,
      margin: const EdgeInsets.only(left: ArrPilotUI.DEFAULT_MARGIN_SIZE),
      color: Theme.of(context).canvasColor,
    );
  }
}

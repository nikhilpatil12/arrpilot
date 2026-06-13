import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/scroll_controller.dart';
import 'package:arrpilot/modules/sonarr.dart';

class SonarrSeriesSearchBarSortButton extends StatefulWidget {
  final ScrollController controller;

  const SonarrSeriesSearchBarSortButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<SonarrSeriesSearchBarSortButton> createState() => _State();
}

class _State extends State<SonarrSeriesSearchBarSortButton> {
  @override
  Widget build(BuildContext context) => ArrPilotCard(
        context: context,
        child: Consumer<SonarrState>(
          builder: (context, state, _) =>
              ArrPilotPopupMenuButton<SonarrSeriesSorting>(
            tooltip: 'sonarr.SortCatalogue'.tr(),
            icon: Icons.sort_rounded,
            onSelected: (result) {
              if (state.seriesSortType == result) {
                state.seriesSortAscending = !state.seriesSortAscending;
              } else {
                state.seriesSortAscending = true;
                state.seriesSortType = result;
              }
              widget.controller.animateToStart();
            },
            itemBuilder: (context) =>
                List<PopupMenuEntry<SonarrSeriesSorting>>.generate(
              SonarrSeriesSorting.values.length,
              (index) => PopupMenuItem<SonarrSeriesSorting>(
                value: SonarrSeriesSorting.values[index],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      SonarrSeriesSorting.values[index].readable,
                      style: TextStyle(
                        fontSize: ArrPilotUI.FONT_SIZE_H3,
                        color: state.seriesSortType ==
                                SonarrSeriesSorting.values[index]
                            ? ArrPilotColours.accent
                            : Colors.white,
                      ),
                    ),
                    if (state.seriesSortType ==
                        SonarrSeriesSorting.values[index])
                      Icon(
                        state.seriesSortAscending
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
        height: ArrPilotTextInputBar.defaultHeight,
        width: ArrPilotTextInputBar.defaultHeight,
        margin: const EdgeInsets.only(left: ArrPilotUI.DEFAULT_MARGIN_SIZE),
        color: Theme.of(context).canvasColor,
      );
}

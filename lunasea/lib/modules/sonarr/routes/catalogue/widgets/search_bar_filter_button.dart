import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/scroll_controller.dart';
import 'package:arrpilot/modules/sonarr.dart';

class SonarrSeriesSearchBarFilterButton extends StatefulWidget {
  final ScrollController controller;

  const SonarrSeriesSearchBarFilterButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<SonarrSeriesSearchBarFilterButton> createState() => _State();
}

class _State extends State<SonarrSeriesSearchBarFilterButton> {
  @override
  Widget build(BuildContext context) => ArrPilotCard(
        context: context,
        child: Consumer<SonarrState>(
          builder: (context, state, _) =>
              ArrPilotPopupMenuButton<SonarrSeriesFilter>(
            tooltip: 'sonarr.FilterCatalogue'.tr(),
            icon: Icons.filter_list_rounded,
            onSelected: (result) {
              state.seriesFilterType = result;
              widget.controller.animateToStart();
            },
            itemBuilder: (context) =>
                List<PopupMenuEntry<SonarrSeriesFilter>>.generate(
              SonarrSeriesFilter.values.length,
              (index) => PopupMenuItem<SonarrSeriesFilter>(
                value: SonarrSeriesFilter.values[index],
                child: Text(
                  SonarrSeriesFilter.values[index].readable,
                  style: TextStyle(
                    fontSize: ArrPilotUI.FONT_SIZE_H3,
                    color: state.seriesFilterType ==
                            SonarrSeriesFilter.values[index]
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

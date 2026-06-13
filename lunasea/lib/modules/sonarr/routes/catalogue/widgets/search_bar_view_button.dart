import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/scroll_controller.dart';
import 'package:arrpilot/modules/sonarr.dart';
import 'package:arrpilot/types/list_view_option.dart';

class SonarrSeriesSearchBarViewButton extends StatefulWidget {
  final ScrollController controller;

  const SonarrSeriesSearchBarViewButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<SonarrSeriesSearchBarViewButton> createState() => _State();
}

class _State extends State<SonarrSeriesSearchBarViewButton> {
  @override
  Widget build(BuildContext context) {
    return ArrPilotCard(
      context: context,
      child: Consumer<SonarrState>(
        builder: (context, state, _) => ArrPilotPopupMenuButton<ArrPilotListViewOption>(
          tooltip: 'lunasea.View'.tr(),
          icon: ArrPilotIcons.VIEW,
          onSelected: (result) {
            state.seriesViewType = result;
            widget.controller.animateToStart();
          },
          itemBuilder: (context) =>
              List<PopupMenuEntry<ArrPilotListViewOption>>.generate(
            ArrPilotListViewOption.values.length,
            (index) => PopupMenuItem<ArrPilotListViewOption>(
              value: ArrPilotListViewOption.values[index],
              child: Text(
                ArrPilotListViewOption.values[index].readable,
                style: TextStyle(
                  fontSize: ArrPilotUI.FONT_SIZE_H3,
                  color:
                      state.seriesViewType == ArrPilotListViewOption.values[index]
                          ? ArrPilotColours.accent
                          : Colors.white,
                ),
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

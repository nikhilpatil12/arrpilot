import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/scroll_controller.dart';
import 'package:arrpilot/modules/radarr.dart';
import 'package:arrpilot/types/list_view_option.dart';

class RadarrCatalogueSearchBarViewButton extends StatefulWidget {
  final ScrollController controller;

  const RadarrCatalogueSearchBarViewButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<RadarrCatalogueSearchBarViewButton> createState() => _State();
}

class _State extends State<RadarrCatalogueSearchBarViewButton> {
  @override
  Widget build(BuildContext context) {
    return ArrPilotCard(
      context: context,
      child: Consumer<RadarrState>(
        builder: (context, state, _) => ArrPilotPopupMenuButton<ArrPilotListViewOption>(
          tooltip: 'lunasea.View'.tr(),
          icon: ArrPilotIcons.VIEW,
          onSelected: (result) {
            state.moviesViewType = result;
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
                      state.moviesViewType == ArrPilotListViewOption.values[index]
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

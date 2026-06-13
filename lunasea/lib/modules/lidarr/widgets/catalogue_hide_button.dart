import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/lidarr.dart';

class LidarrCatalogueHideButton extends StatefulWidget {
  final ScrollController controller;

  const LidarrCatalogueHideButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<LidarrCatalogueHideButton> createState() => _State();
}

class _State extends State<LidarrCatalogueHideButton> {
  @override
  Widget build(BuildContext context) => ArrPilotCard(
        context: context,
        child: Consumer<LidarrState>(
          builder: (context, model, widget) => InkWell(
            child: ArrPilotIconButton(
              icon: model.hideUnmonitoredArtists
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
            ),
            onTap: () =>
                model.hideUnmonitoredArtists = !model.hideUnmonitoredArtists,
            borderRadius: BorderRadius.circular(ArrPilotUI.BORDER_RADIUS),
          ),
        ),
        height: ArrPilotTextInputBar.defaultHeight,
        width: ArrPilotTextInputBar.defaultHeight,
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        color: Theme.of(context).canvasColor,
      );
}

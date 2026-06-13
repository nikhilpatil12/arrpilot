import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';

class RadarrDiskSpaceTile extends StatelessWidget {
  final RadarrDiskSpace diskSpace;

  const RadarrDiskSpaceTile({
    Key? key,
    required this.diskSpace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      title: diskSpace.lunaPath,
      body: [TextSpan(text: diskSpace.lunaSpace)],
      bottom: ArrPilotLinearPercentIndicator(
        percent: diskSpace.lunaPercentage / 100,
        progressColor: diskSpace.lunaColor,
      ),
      bottomHeight: ArrPilotLinearPercentIndicator.height,
      trailing: ArrPilotIconButton(
        text: diskSpace.lunaPercentageString,
        textSize: ArrPilotUI.FONT_SIZE_H4,
        color: diskSpace.lunaColor,
      ),
    );
  }
}

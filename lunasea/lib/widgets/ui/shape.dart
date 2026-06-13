import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';

class ArrPilotShapeBorder extends RoundedRectangleBorder {
  ArrPilotShapeBorder({
    bool useBorder = false,
    bool topOnly = false,
  }) : super(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(ArrPilotUI.BORDER_RADIUS),
            topRight: const Radius.circular(ArrPilotUI.BORDER_RADIUS),
            bottomLeft: topOnly
                ? Radius.zero
                : const Radius.circular(ArrPilotUI.BORDER_RADIUS),
            bottomRight: topOnly
                ? Radius.zero
                : const Radius.circular(ArrPilotUI.BORDER_RADIUS),
          ),
          side: useBorder
              ? const BorderSide(color: ArrPilotColours.white10)
              : BorderSide.none,
        );
}

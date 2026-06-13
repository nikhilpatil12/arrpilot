import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';

class ArrPilotDivider extends Divider {
  ArrPilotDivider({
    Key? key,
  }) : super(
          key: key,
          thickness: 1.0,
          color: ArrPilotColours.accent.dimmed(),
          indent: ArrPilotUI.DEFAULT_MARGIN_SIZE * 5,
          endIndent: ArrPilotUI.DEFAULT_MARGIN_SIZE * 5,
        );
}

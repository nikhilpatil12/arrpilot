import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';

class ArrPilotTextSpan extends TextSpan {
  const ArrPilotTextSpan.extended({
    required String? text,
  }) : super(
          text: text,
          style: const TextStyle(
            height: ArrPilotBlock.SUBTITLE_HEIGHT / ArrPilotUI.FONT_SIZE_H3,
          ),
        );
}

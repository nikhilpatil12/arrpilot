import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';

class ArrPilotHighlightedNode extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String text;

  const ArrPilotHighlightedNode({
    Key? key,
    required this.text,
    this.backgroundColor = ArrPilotColours.accent,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        child: Text(
          text,
          maxLines: 1,
          style: TextStyle(
            fontSize: ArrPilotUI.FONT_SIZE_H4,
            color: textColor,
            fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(ArrPilotUI.BORDER_RADIUS),
      ),
    );
  }
}

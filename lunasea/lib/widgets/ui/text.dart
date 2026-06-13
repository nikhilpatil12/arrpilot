import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';

class ArrPilotText extends Text {
  /// Create a new [Text] widget.
  const ArrPilotText({
    required String text,
    Key? key,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    TextStyle? style,
    TextAlign? textAlign,
  }) : super(
          text,
          key: key,
          maxLines: maxLines == 0 ? null : maxLines,
          overflow: overflow,
          softWrap: softWrap,
          style: style,
          textAlign: textAlign,
        );

  /// Create a [ArrPilotText] widget with the styling pre-assigned to be a ArrPilot title.
  factory ArrPilotText.title({
    Key? key,
    required String text,
    int maxLines = 1,
    bool softWrap = false,
    TextAlign textAlign = TextAlign.start,
    TextOverflow overflow = TextOverflow.fade,
    Color color = Colors.white,
  }) =>
      ArrPilotText(
        text: text,
        key: key,
        maxLines: maxLines,
        overflow: overflow,
        softWrap: softWrap,
        textAlign: textAlign,
        style: TextStyle(
          color: color,
          fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
          fontSize: ArrPilotUI.FONT_SIZE_H2,
        ),
      );

  /// Create a [ArrPilotText] widget with the styling pre-assigned to be a ArrPilot subtitle.
  factory ArrPilotText.subtitle({
    Key? key,
    required String text,
    int maxLines = 1,
    bool softWrap = false,
    TextAlign textAlign = TextAlign.start,
    TextOverflow overflow = TextOverflow.fade,
    Color color = ArrPilotColours.grey,
    FontStyle fontStyle = FontStyle.normal,
  }) =>
      ArrPilotText(
        key: key,
        text: text,
        softWrap: softWrap,
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow,
        style: TextStyle(
          color: color,
          fontSize: ArrPilotUI.FONT_SIZE_H3,
          fontStyle: fontStyle,
        ),
      );
}

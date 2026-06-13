import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';

class ArrPilotHeader extends StatelessWidget {
  final String? text;
  final String? subtitle;

  const ArrPilotHeader({
    Key? key,
    required this.text,
    this.subtitle,
  }) : super(key: key);

  Widget _headerText() {
    return Text(
      text!,
      style: const TextStyle(
        fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
        fontSize: ArrPilotUI.FONT_SIZE_H2,
        color: Colors.white,
      ),
    );
  }

  Widget _barSeperator() {
    return Padding(
      child: Container(
        height: 2.0,
        width: ArrPilotUI.DEFAULT_MARGIN_SIZE * 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ArrPilotUI.BORDER_RADIUS),
          color: ArrPilotColours.accent,
        ),
      ),
      padding: const EdgeInsets.only(
        top: ArrPilotUI.DEFAULT_MARGIN_SIZE / 2,
        left: 0,
        bottom: ArrPilotUI.DEFAULT_MARGIN_SIZE / 2,
      ),
    );
  }

  Widget _subtitle() {
    return Padding(
      child: Text(
        subtitle!,
        style: const TextStyle(
          fontSize: ArrPilotUI.FONT_SIZE_H4,
          color: ArrPilotColours.grey,
          fontWeight: FontWeight.w300,
        ),
      ),
      padding: const EdgeInsets.only(bottom: ArrPilotUI.DEFAULT_MARGIN_SIZE / 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _headerText(),
          _barSeperator(),
          if (subtitle != null) _subtitle(),
        ],
      ),
      padding: const EdgeInsets.only(
        left: ArrPilotUI.DEFAULT_MARGIN_SIZE,
        right: ArrPilotUI.DEFAULT_MARGIN_SIZE,
        top: ArrPilotUI.DEFAULT_MARGIN_SIZE / 2,
      ),
    );
  }
}

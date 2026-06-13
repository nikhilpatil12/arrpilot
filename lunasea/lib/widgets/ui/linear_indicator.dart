import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ArrPilotLinearPercentIndicator extends StatelessWidget {
  static const _LINE_HEIGHT = 4.0;
  static const double height = _LINE_HEIGHT + ArrPilotUI.DEFAULT_MARGIN_SIZE / 2;

  final double? percent;
  final Color progressColor;
  final Color? backgroundColor;

  const ArrPilotLinearPercentIndicator({
    Key? key,
    this.percent,
    this.progressColor = ArrPilotColours.accent,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.bottomCenter,
      child: LinearPercentIndicator(
        percent: percent!,
        padding: EdgeInsets.zero,
        lineHeight: 4.0,
        progressColor: progressColor,
        barRadius: const Radius.circular(ArrPilotUI.BORDER_RADIUS),
        backgroundColor:
            backgroundColor ?? progressColor.withOpacity(ArrPilotUI.OPACITY_SPLASH),
      ),
    );
  }
}

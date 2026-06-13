import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:shimmer/shimmer.dart';

class ArrPilotShimmer extends StatelessWidget {
  final Widget child;

  const ArrPilotShimmer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: child,
      baseColor: Theme.of(context).primaryColor,
      highlightColor: ArrPilotColours.accent,
    );
  }
}

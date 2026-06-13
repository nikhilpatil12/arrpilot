import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';

class ArrPilotReorderableListViewDragger extends StatelessWidget {
  final int index;

  const ArrPilotReorderableListViewDragger({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ReorderableDragStartListener(
          index: index,
          child: const ArrPilotIconButton(
            icon: Icons.menu_rounded,
            mouseCursor: SystemMouseCursors.click,
          ),
        ),
      ],
    );
  }
}

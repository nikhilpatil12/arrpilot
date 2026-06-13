import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arrpilot/core.dart';

class ArrPilotPopupMenuButton<T> extends PopupMenuButton<T> {
  ArrPilotPopupMenuButton({
    required PopupMenuItemSelected<T> onSelected,
    required PopupMenuItemBuilder<T> itemBuilder,
    Key? key,
    IconData? icon,
    Widget? child,
    String? tooltip,
  }) : super(
          key: key,
          shape: ArrPilotUI.shapeBorder,
          tooltip: tooltip,
          icon: icon == null ? null : Icon(icon),
          child: child,
          onSelected: (result) {
            HapticFeedback.selectionClick();
            onSelected(result);
          },
          itemBuilder: itemBuilder,
        );
}

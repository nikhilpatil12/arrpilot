import 'package:flutter/material.dart';
import 'package:arrpilot/system/state.dart';
import 'package:arrpilot/widgets/ui.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ArrPilotBottomModalSheet<T> {
  @protected
  Future<T?> showModal({
    Widget Function(BuildContext context)? builder,
  }) async {
    return showBarModalBottomSheet<T>(
      context: ArrPilotState.context,
      expand: false,
      backgroundColor:
          ArrPilotTheme.isAMOLEDTheme ? Colors.black : ArrPilotColours.primary,
      shape: ArrPilotShapeBorder(
        topOnly: true,
        useBorder: ArrPilotUI.shouldUseBorder,
      ),
      builder: builder ?? this.builder as Widget Function(BuildContext),
      closeProgressThreshold: 0.90,
      elevation: ArrPilotUI.ELEVATION,
      overlayStyle: ArrPilotTheme().overlayStyle,
    );
  }

  Widget? builder(BuildContext context) => null;

  Future<dynamic> show({
    Widget Function(BuildContext context)? builder,
  }) async =>
      showModal(builder: builder);
}

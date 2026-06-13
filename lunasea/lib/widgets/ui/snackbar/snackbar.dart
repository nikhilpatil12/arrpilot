import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arrpilot/core.dart';

enum ArrPilotSnackbarType {
  SUCCESS,
  ERROR,
  INFO,
}

extension ArrPilotSnackbarTypeExtension on ArrPilotSnackbarType {
  Color get color {
    switch (this) {
      case ArrPilotSnackbarType.SUCCESS:
        return ArrPilotColours.accent;
      case ArrPilotSnackbarType.ERROR:
        return ArrPilotColours.red;
      case ArrPilotSnackbarType.INFO:
        return ArrPilotColours.blue;
      default:
        return ArrPilotColours.purple;
    }
  }

  IconData get icon {
    switch (this) {
      case ArrPilotSnackbarType.SUCCESS:
        return Icons.check_circle_outline_rounded;
      case ArrPilotSnackbarType.ERROR:
        return Icons.error_outline_rounded;
      case ArrPilotSnackbarType.INFO:
        return Icons.info_outline_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }
}

Future<void> showLunaSnackBar({
  required String title,
  required ArrPilotSnackbarType type,
  required String message,
  Duration? duration,
  FlashPosition position = FlashPosition.bottom,
  bool showButton = false,
  String buttonText = 'view',
  Function? buttonOnPressed,
}) async {
  showFlash(
    context: ArrPilotState.context,
    duration: duration ?? Duration(seconds: showButton ? 4 : 2),
    transitionDuration: const Duration(milliseconds: ArrPilotUI.ANIMATION_SPEED),
    reverseTransitionDuration:
        const Duration(milliseconds: ArrPilotUI.ANIMATION_SPEED),
    builder: (context, controller) => FlashBar(
      controller: controller,
      backgroundColor: Theme.of(context).primaryColor,
      behavior: FlashBehavior.floating,
      margin: ArrPilotUI.MARGIN_DEFAULT,
      position: position,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color:
              ArrPilotUI.shouldUseBorder ? ArrPilotColours.white10 : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(ArrPilotUI.BORDER_RADIUS),
      ),
      title: ArrPilotText.title(
        text: title,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
      ),
      content: ArrPilotText.subtitle(
        text: message,
        maxLines: 8,
        overflow: TextOverflow.ellipsis,
      ),
      shouldIconPulse: false,
      icon: Padding(
        child: ArrPilotIconButton(
          icon: type.icon,
          color: type.color,
        ),
        padding: const EdgeInsets.only(
          left: ArrPilotUI.DEFAULT_MARGIN_SIZE / 2,
        ),
      ),
      primaryAction: showButton
          ? TextButton(
              child: Text(
                buttonText.toUpperCase(),
                style: const TextStyle(
                  fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
                  color: ArrPilotColours.accent,
                ),
              ),
              onPressed: () {
                HapticFeedback.lightImpact();
                controller.dismiss();
                buttonOnPressed!();
              },
            )
          : null,
    ),
  );
}

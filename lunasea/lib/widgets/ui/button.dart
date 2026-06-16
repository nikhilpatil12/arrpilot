import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arrpilot/system/state.dart';
import 'package:arrpilot/types/loading_state.dart';
import 'package:arrpilot/widgets/ui.dart';

enum ArrPilotButtonType {
  TEXT,
  ICON,
  LOADER,
}

/// An ArrPilot-styled button.
class ArrPilotButton extends Card {
  static const DEFAULT_HEIGHT = 48.0;

  ArrPilotButton._({
    Key? key,
    required Widget child,
    EdgeInsets margin = ArrPilotUI.MARGIN_HALF,
    Color? backgroundColor,
    double height = DEFAULT_HEIGHT,
    Alignment alignment = Alignment.center,
    Decoration? decoration,
    Function? onTap,
    Function? onLongPress,
    ArrPilotLoadingState? loadingState,
  }) : super(
          key: key,
          child: InkWell(
            child: Container(
              child: child,
              decoration: decoration,
              height: height,
              alignment: alignment,
            ),
            borderRadius: BorderRadius.circular(ArrPilotUI.BORDER_RADIUS),
            onTap: () async {
              HapticFeedback.lightImpact();
              if (onTap != null && loadingState != ArrPilotLoadingState.ACTIVE)
                onTap();
            },
            onLongPress: () async {
              HapticFeedback.heavyImpact();
              if (onLongPress != null &&
                  loadingState != ArrPilotLoadingState.ACTIVE) onLongPress();
            },
          ),
          margin: margin,
          color: backgroundColor != null
              ? backgroundColor.withOpacity(ArrPilotUI.OPACITY_DIMMED)
              : Theme.of(ArrPilotState.context)
                  .canvasColor
                  .withOpacity(ArrPilotUI.OPACITY_DIMMED),
          shape:
              backgroundColor != null ? ArrPilotShapeBorder() : ArrPilotUI.shapeBorder,
          elevation: ArrPilotUI.ELEVATION,
          clipBehavior: Clip.antiAlias,
        );

  /// Create a default button.
  ///
  /// If [ArrPilotLoadingState] is passed in, will build the correct button based on the type.
  factory ArrPilotButton({
    required ArrPilotButtonType type,
    Color color = ArrPilotColours.accent,
    Color? backgroundColor,
    String? text,
    IconData? icon,
    double iconSize = ArrPilotUI.ICON_SIZE,
    ArrPilotLoadingState? loadingState,
    EdgeInsets margin = ArrPilotUI.MARGIN_HALF,
    double height = DEFAULT_HEIGHT,
    Alignment alignment = Alignment.center,
    Decoration? decoration,
    Function? onTap,
    Function? onLongPress,
  }) {
    switch (loadingState) {
      case ArrPilotLoadingState.ACTIVE:
        return ArrPilotButton.loader(
          color: color,
          backgroundColor: backgroundColor,
          margin: margin,
          height: height,
          alignment: alignment,
          decoration: decoration,
          onTap: onTap,
          onLongPress: onLongPress,
          loadingState: loadingState,
        );
      case ArrPilotLoadingState.ERROR:
        return ArrPilotButton.icon(
          icon: Icons.error_rounded,
          iconSize: iconSize,
          color: color,
          backgroundColor: backgroundColor,
          margin: margin,
          height: height,
          alignment: alignment,
          decoration: decoration,
          onTap: onTap,
          onLongPress: onLongPress,
          loadingState: loadingState,
        );
      default:
        break;
    }
    switch (type) {
      case ArrPilotButtonType.TEXT:
        return ArrPilotButton.text(
          text: text!,
          icon: icon,
          iconSize: iconSize,
          color: color,
          backgroundColor: backgroundColor,
          margin: margin,
          height: height,
          alignment: alignment,
          decoration: decoration,
          onTap: onTap,
          onLongPress: onLongPress,
          loadingState: loadingState,
        );
      case ArrPilotButtonType.ICON:
        assert(icon != null);
        return ArrPilotButton.icon(
          icon: icon,
          iconSize: iconSize,
          color: color,
          backgroundColor: backgroundColor,
          margin: margin,
          height: height,
          alignment: alignment,
          decoration: decoration,
          onTap: onTap,
          onLongPress: onLongPress,
          loadingState: loadingState,
        );
      case ArrPilotButtonType.LOADER:
        return ArrPilotButton.loader(
          color: color,
          backgroundColor: backgroundColor,
          margin: margin,
          height: height,
          alignment: alignment,
          decoration: decoration,
          onTap: onTap,
          onLongPress: onLongPress,
          loadingState: loadingState,
        );
    }
  }

  /// Build a button that contains a centered text string.
  factory ArrPilotButton.text({
    required String text,
    required IconData? icon,
    double iconSize = ArrPilotUI.ICON_SIZE,
    Color color = ArrPilotColours.accent,
    Color? backgroundColor,
    EdgeInsets margin = ArrPilotUI.MARGIN_HALF,
    double height = DEFAULT_HEIGHT,
    Alignment alignment = Alignment.center,
    Decoration? decoration,
    ArrPilotLoadingState? loadingState,
    Function? onTap,
    Function? onLongPress,
  }) {
    return ArrPilotButton._(
      child: Padding(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                child: Icon(
                  icon,
                  color: color,
                  size: iconSize,
                ),
                padding: const EdgeInsets.only(
                    right: ArrPilotUI.DEFAULT_MARGIN_SIZE / 2),
              ),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
                  fontSize: ArrPilotUI.FONT_SIZE_H3,
                ),
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: 1,
              ),
            ),
          ],
        ),
        padding:
            const EdgeInsets.symmetric(horizontal: ArrPilotUI.DEFAULT_MARGIN_SIZE),
      ),
      margin: margin,
      height: height,
      backgroundColor: backgroundColor,
      alignment: alignment,
      decoration: decoration,
      onTap: onTap,
      onLongPress: onLongPress,
      loadingState: loadingState,
    );
  }

  /// Build a button that contains a [ArrPilotLoader].
  factory ArrPilotButton.loader({
    EdgeInsets margin = ArrPilotUI.MARGIN_HALF,
    Color color = ArrPilotColours.accent,
    Color? backgroundColor,
    double height = DEFAULT_HEIGHT,
    Alignment alignment = Alignment.center,
    Decoration? decoration,
    Function? onTap,
    Function? onLongPress,
    ArrPilotLoadingState? loadingState,
  }) {
    return ArrPilotButton._(
      child: ArrPilotLoader(
        useSafeArea: false,
        color: color,
        size: ArrPilotUI.FONT_SIZE_H3,
      ),
      margin: margin,
      height: height,
      backgroundColor: backgroundColor,
      alignment: alignment,
      decoration: decoration,
      onTap: onTap,
      onLongPress: onLongPress,
      loadingState: loadingState,
    );
  }

  /// Build a button that contains a single, centered [Icon].
  factory ArrPilotButton.icon({
    required IconData? icon,
    Color color = ArrPilotColours.accent,
    Color? backgroundColor,
    EdgeInsets margin = ArrPilotUI.MARGIN_HALF,
    double height = DEFAULT_HEIGHT,
    double iconSize = ArrPilotUI.ICON_SIZE,
    Alignment alignment = Alignment.center,
    Decoration? decoration,
    Function? onTap,
    Function? onLongPress,
    ArrPilotLoadingState? loadingState,
  }) {
    return ArrPilotButton._(
      child: Icon(
        icon,
        color: color,
        size: iconSize,
      ),
      margin: margin,
      height: height,
      backgroundColor: backgroundColor,
      alignment: alignment,
      decoration: decoration,
      onTap: onTap,
      onLongPress: onLongPress,
      loadingState: loadingState,
    );
  }
}

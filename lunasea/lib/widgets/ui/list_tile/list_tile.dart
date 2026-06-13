import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';

@Deprecated("Use ArrPilotBlock instead")
class ArrPilotListTile extends Card {
  ArrPilotListTile({
    Key? key,
    required BuildContext context,
    required Widget title,
    required double height,
    Widget? subtitle,
    Widget? trailing,
    Widget? leading,
    Color? color,
    Decoration? decoration,
    Function? onTap,
    Function? onLongPress,
    bool drawBorder = true,
    EdgeInsets margin = ArrPilotUI.MARGIN_H_DEFAULT_V_HALF,
  }) : super(
          key: key,
          child: Container(
            height: height,
            child: InkWell(
              child: Row(
                children: [
                  if (leading != null)
                    SizedBox(
                      width: ArrPilotUI.DEFAULT_MARGIN_SIZE * 4 +
                          ArrPilotUI.DEFAULT_MARGIN_SIZE / 2,
                      child: leading,
                    ),
                  Expanded(
                    child: Padding(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: title,
                            height: ArrPilotBlock.TITLE_HEIGHT,
                          ),
                          if (subtitle != null) subtitle,
                        ],
                      ),
                      padding: EdgeInsets.only(
                        top: ArrPilotUI.DEFAULT_MARGIN_SIZE,
                        bottom: ArrPilotUI.DEFAULT_MARGIN_SIZE,
                        left: leading != null ? 0 : ArrPilotUI.DEFAULT_MARGIN_SIZE,
                        right:
                            trailing != null ? 0 : ArrPilotUI.DEFAULT_MARGIN_SIZE,
                      ),
                    ),
                  ),
                  if (trailing != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        right: ArrPilotUI.DEFAULT_MARGIN_SIZE / 2,
                      ),
                      child: SizedBox(
                        width: ArrPilotUI.DEFAULT_MARGIN_SIZE * 4,
                        child: trailing,
                      ),
                    ),
                ],
              ),
              borderRadius: BorderRadius.circular(ArrPilotUI.BORDER_RADIUS),
              onTap: onTap as void Function()?,
              onLongPress: onLongPress as void Function()?,
              mouseCursor: MouseCursor.defer,
            ),
            decoration: decoration,
          ),
          margin: margin,
          elevation: ArrPilotUI.ELEVATION,
          shape: drawBorder ? ArrPilotUI.shapeBorder : ArrPilotShapeBorder(),
          color: color ?? Theme.of(context).primaryColor,
        );
}

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';

class ArrPilotNavigationBarBadge extends badges.Badge {
  ArrPilotNavigationBarBadge({
    Key? key,
    required String text,
    required IconData icon,
    required bool showBadge,
    required bool isActive,
  }) : super(
          key: key,
          badgeStyle: badges.BadgeStyle(
            badgeColor: ArrPilotColours.accent.dimmed(),
            elevation: ArrPilotUI.ELEVATION,
            shape: badges.BadgeShape.circle,
          ),
          badgeAnimation: const badges.BadgeAnimation.scale(
            animationDuration:
                Duration(milliseconds: ArrPilotUI.ANIMATION_SPEED_SCROLLING),
          ),
          position: badges.BadgePosition.topEnd(
            top: -ArrPilotUI.DEFAULT_MARGIN_SIZE,
            end: -ArrPilotUI.DEFAULT_MARGIN_SIZE,
          ),
          badgeContent: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
          child: Icon(
            icon,
            color: isActive ? ArrPilotColours.accent : Colors.white,
          ),
          showBadge: showBadge,
        );
}

import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';

class ArrPilotColours {
  /// List of ArrPilot colours in order that the should appear in a list.
  ///
  /// Use [byListIndex] to fetch the colour at the any index
  static const _LIST_COLOR_ICONS = [
    blue,
    accent,
    red,
    orange,
    purple,
    blueGrey,
  ];

  /// Core accent colour - Deep Cyan (ArrPilot brand)
  static const Color accent = Color(0xFF00B4D8);

  /// Core primary colour (background) - Deep Navy Blue
  static const Color primary = Color(0xFF1E2749);

  /// Core secondary colour (appbar, bottom bar, etc.) - Darker Navy
  static const Color secondary = Color(0xFF0D1B2A);

  static const Color blue = Color(0xFF0077B6);
  static const Color blueGrey = Color(0xFF778DA9);
  static const Color grey = Color(0xFFBBBBBB);
  static const Color orange = Color(0xFFFCA311);
  static const Color purple = Color(0xFF7209B7);
  static const Color red = Color(0xFFD00000);

  /// Shades of White
  static const Color white = Color(0xFFFFFFFF);
  static const Color white70 = Color(0xB3FFFFFF);
  static const Color white10 = Color(0x1AFFFFFF);

  /// Returns the correct colour for a graph by what layer it is on the graph canvas.
  Color byGraphLayer(int index) {
    switch (index) {
      case 0:
        return ArrPilotColours.accent;
      case 1:
        return ArrPilotColours.purple;
      case 2:
        return ArrPilotColours.blue;
      default:
        return byListIndex(index);
    }
  }

  /// Return the correct colour for a list.
  /// If the index is greater than the list of colour's length, uses modulus to loop list.
  Color byListIndex(int index) {
    return _LIST_COLOR_ICONS[index % _LIST_COLOR_ICONS.length];
  }
}

extension ArrPilotColor on Color {
  Color disabled([bool condition = true]) {
    if (condition) return this.withOpacity(ArrPilotUI.OPACITY_DISABLED);
    return this;
  }

  Color enabled([bool condition = true]) {
    if (condition) return this;
    return this.withOpacity(ArrPilotUI.OPACITY_DISABLED);
  }

  Color selected([bool condition = true]) {
    if (condition) return this.withOpacity(ArrPilotUI.OPACITY_SELECTED);
    return this;
  }

  Color dimmed() => this.withOpacity(ArrPilotUI.OPACITY_DIMMED);
}

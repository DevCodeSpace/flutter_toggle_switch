import 'package:flutter/material.dart';

class Utils {
  /// Calculates width per switch, capping at screen width to avoid overflow.
  /// Ignores [customWidths] if the toggle is vertical.
  static double calculateWidth({
    required BuildContext context,
    required int index,
    required int totalSwitches,
    List<double>? customWidths,
    required double minWidth,
  }) {
    final double extraWidth = 0.10 * totalSwitches;
    final double screenWidth = MediaQuery.of(context).size.width;

    if (customWidths != null && index < customWidths.length) {
      return customWidths[index];
    }

    final bool fits = (totalSwitches + extraWidth) * minWidth < screenWidth;
    return fits ? minWidth : screenWidth / (totalSwitches + extraWidth);
  }

  /// Calculates height per switch for vertical layouts.
  /// Ignores [customHeights] if the toggle is horizontal.
  static double calculateHeight({
    required BuildContext context,
    required int index,
    required int totalSwitches,
    List<double>? customHeights,
    required double minHeight,
  }) {
    final double extraHeight = 0.10 * totalSwitches;
    final double screenHeight = MediaQuery.of(context).size.height;

    if (customHeights != null && index < customHeights.length) {
      return customHeights[index];
    }

    final bool fits = (totalSwitches + extraHeight) * minHeight < screenHeight;
    return fits ? minHeight : screenHeight / (totalSwitches + extraHeight);
  }
}

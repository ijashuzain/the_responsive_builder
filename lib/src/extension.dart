import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'helper.dart';

/// This extension is added to the 'num' data type to help with responsive measurements.
extension TheResponsiveExtension on num {
  /// Returns the adaptive height. It multiplies the provided number (this)
  /// with the actual screen height, then divides by 100 to get a percentage value.
  double get h => this * TheResponsiveHelper.height / 100;

  /// Returns the adaptive width. It multiplies the provided number (this)
  /// with the actual screen width, then divides by 100 to get a percentage value.
  double get w => this * TheResponsiveHelper.width / 100;

  /// Returns the adaptive density pixel. This calculation uses the scale factors
  /// from TheResponsiveHelper to provide consistency with other responsive elements.
  double get dp {
    // Use the minimum of horizontal and vertical scaling to ensure consistency
    double scaleFactor = math.min(TheResponsiveHelper.horizontalScaling,
        TheResponsiveHelper.verticalScaling);

    // Apply the scaling factor with a slight dampening effect
    return (this * math.pow(scaleFactor, 0.5)).round().toDouble();
  }

  /// Returns the adaptive scalable pixel for text. This takes the 'dp' value and scales it
  /// using the textScaleFactor, which respects the user's font size settings.
  double get sp => TheResponsiveHelper.scaledTextSize(double.parse('$this'));
}

/// This extension is added to the 'BuildContext' to provide easy access to properties
/// related to the screen type and orientation.
extension TheResponsiveScreenTypeExtension on BuildContext {
  /// Provides a quick way to get the current screen type (mobile or tablet) using the ResponsiveHelper.
  ScreenType get screenType => TheResponsiveHelper.screenType;

  /// Provides a quick way to get the current orientation (portrait or landscape) using the ResponsiveHelper.
  Orientation get orientation => TheResponsiveHelper.orientation;
}

/// This extension is added to the 'BuildContext' data type to help with set lock on specific orientation.
extension TheResponsiveOrientationLockExtension on BuildContext {
  /// Locks the orientation to portrait mode.
  void lockToPortrait() => TheResponsiveHelper.lockToPortrait(this);

  /// Locks the orientation to landscape mode.
  void lockToLandscape() => TheResponsiveHelper.lockToLandscape(this);

  /// Unlocks the orientation to allow both portrait and landscape modes.
  void unlockOrientation() => TheResponsiveHelper.unlockOrientation(this);
}

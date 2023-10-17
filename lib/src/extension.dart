import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'helper.dart';

/// This extension is added to the 'num' data type to help with responsive measurements.
extension ResponsiveExtension on num {
  /// Returns the adaptive height. It multiplies the provided number (this)
  /// with the actual screen height, then divides by 100 to get a percentage value.
  double get h => this * ResponsiveHelper.height / 100;

  /// Returns the adaptive width. It multiplies the provided number (this)
  /// with the actual screen width, then divides by 100 to get a percentage value.
  double get w => this * ResponsiveHelper.width / 100;

  /// Returns the adaptive density pixel. The formula uses logarithms to calculate a value based on
  /// the width, height, and devicePixelRatio. The magic number '18' is used for normalization.
  double get dp => (math.log(ResponsiveHelper.width * ResponsiveHelper.height * ResponsiveHelper.devicePixelRatio) / math.log(2) / 18 * this).abs();

  /// Returns the adaptive scalable pixel for text. This takes the 'dp' value and scales it
  /// using the textScaleFactor, which respects the user's font size settings.
  double get sp => dp * ResponsiveHelper.textScaleFactor;
}

/// This extension is added to the 'BuildContext' to provide easy access to properties
/// related to the screen type and orientation.
extension ResponsiveScreenTypeExtension on BuildContext {
  /// Provides a quick way to get the current screen type (mobile or tablet) using the ResponsiveHelper.
  ScreenType get screenType => ResponsiveHelper.screenType;

  /// Provides a quick way to get the current orientation (portrait or landscape) using the ResponsiveHelper.
  Orientation get orientation => ResponsiveHelper.orientation;
}

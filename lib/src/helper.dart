import 'package:flutter/material.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

/// Enumeration to define the two types of screen sizes we want to cater to.
enum ScreenType { mobile, tablet }

class TheResponsiveHelper {
  /// These properties define the size and characteristics of the current screen.
  static late BoxConstraints boxConstraints;
  static late Orientation orientation;
  static late ScreenType screenType;
  static late double height;
  static late double width;

  /// Reference baseline values for width and height.
  static const double baselineWidth = 375.0;
  static const double baselineHeight = 667.0;

  /// Get scaling factors for width and height compared to the baseline.
  static double get horizontalScaling => width / baselineWidth;
  static double get verticalScaling => height / baselineHeight;

  /// Get the aspect ratio of the current screen.
  static double get aspectRatio => width / height;

  /// Get the device's pixel density.
  static double get devicePixelRatio => WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

  /// Calculate screen density using devicePixelRatio and aspectRatio.
  static double get screenDensity => devicePixelRatio * aspectRatio;

  /// Get the text scale factor, considering user preferences.
  static double get textScaleFactor => WidgetsBinding.instance.platformDispatcher.textScaleFactor;

  /// Fetch the safe area insets, accounting for notches, cutouts, etc.
  static EdgeInsets get safeAreaInsets => MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding;

  /// Determine the type of screen (mobile or tablet) based on width, height, and orientation.
  static void setScreenSize(BoxConstraints constraints, Orientation currentOrientation, [double mobileBreakpoint = 600.0]) {
    boxConstraints = constraints;
    orientation = currentOrientation;

    width = boxConstraints.maxWidth;
    height = boxConstraints.maxHeight;

    if ((orientation == Orientation.portrait && width < mobileBreakpoint) || (orientation == Orientation.landscape && height < mobileBreakpoint)) {
      screenType = ScreenType.mobile;
    } else {
      screenType = ScreenType.tablet;
    }
  }

  /// Calculate the text size scaled based on the horizontal scaling factor and user's text preferences.
  static double scaledTextSize(double size) {
    return size * horizontalScaling * textScaleFactor;
  }
}

/// Utility class to fetch adaptive measurements using the ResponsiveHelper.
class Adaptive {
  static double h(num height) => height.h;

  /// Fetch the adaptive height.
  static double w(num width) => width.w;

  /// Fetch the adaptive width.
  static double sp(num scalablePixel) => scalablePixel.sp;

  /// Fetch the adaptive scalable pixel for text.
  static double dp(num scalablePixel) => scalablePixel.dp;

  /// Fetch the adaptive density pixel.
}

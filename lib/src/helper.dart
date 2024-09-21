import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  static late double baselineWidth;
  static late double baselineHeight;

  static bool enableScaleFactor = true;

  /// Get scaling factors for width and height compared to the baseline.
  static double get horizontalScaling => min(width / baselineWidth, 1.0);
  static double get verticalScaling => min(height / baselineHeight, 1.0);

  static bool get enableTextScaleFactor => enableScaleFactor;

  /// Get the aspect ratio of the current screen.
  static double get aspectRatio => width / height;

  /// Get the device's pixel density.
  static double get devicePixelRatio =>
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

  /// Calculate screen density using devicePixelRatio and aspectRatio.
  static double get screenDensity => devicePixelRatio * aspectRatio;

  /// Get the text scale factor, considering user preferences.
  static double get textScaleFactor =>
      WidgetsBinding.instance.platformDispatcher.textScaleFactor;

  /// Determine the type of screen (mobile or tablet) based on width, height, and orientation.
  static void setScreenSize({
    required BoxConstraints constraints,
    required Orientation currentOrientation,
    required double mobileBreakpoint,
    required bool enableTextScaleFactor,
    required double baseWidth,
    required double baseHeight,
  }) {

    boxConstraints = constraints;
    orientation = currentOrientation;
    enableScaleFactor = enableTextScaleFactor;
    baselineWidth = baseWidth;
    baselineHeight = baseHeight;
    width = boxConstraints.maxWidth;
    height = boxConstraints.maxHeight;

    if ((orientation == Orientation.portrait && width < mobileBreakpoint) ||
        (orientation == Orientation.landscape && height < mobileBreakpoint)) {
      screenType = ScreenType.mobile;
    } else {
      screenType = ScreenType.tablet;
    }

    debugPrint("=============================================");
    debugPrint("         The Responsive Builder              ");
    debugPrint("=============================================");
    debugPrint("Scale Factor : $textScaleFactor");
    debugPrint("Device Pixel Ratio : $devicePixelRatio");
    debugPrint("Horizontal scaling : $horizontalScaling");
    debugPrint("Vertical scaling : $verticalScaling");
    debugPrint("Screen Density : $screenDensity");
    debugPrint("Screen Aspect Ratio : $aspectRatio");
    debugPrint("Baseline Width : $baselineWidth");
    debugPrint("Baseline Height : $baselineHeight");
    debugPrint("Screen Width : $width");
    debugPrint("Screen Height : $height");
    debugPrint("Screen Type : $screenType");
    debugPrint("=============================================");
  }

  /// Calculate the text size scaled based on the horizontal scaling factor and user's text preferences.
  // static double scaledTextSize(double size) {
  //   return size *
  //       min(horizontalScaling, verticalScaling) *
  //       (enableScaleFactor ? textScaleFactor : 1);
  // }
  static double scaledTextSize(double size) {
    double scaleFactor = min(horizontalScaling, verticalScaling);
    
    // Ensure the scale factor doesn't exceed 1.0
    scaleFactor = min(scaleFactor, 1.0);
    
    return size * scaleFactor * (enableScaleFactor ? textScaleFactor : 1);
  }

  /// Lock the orientation to portrait mode.
  static void lockToPortrait(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  /// Lock the orientation to landscape mode.
  static void lockToLandscape(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  /// Unlock the orientation to allow both portrait and landscape modes.
  static void unlockOrientation(BuildContext context) {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
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

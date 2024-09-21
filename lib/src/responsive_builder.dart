import 'package:flutter/material.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

/// A typedef for a function that returns a widget based on the BuildContext, current Orientation, and ScreenType.
typedef ResponsiveBuild = Widget Function(
  BuildContext,
  Orientation,
  ScreenType,
);

/// This is a custom widget that helps in building responsive UI based on the screen size and orientation.
class TheResponsiveBuilder extends StatelessWidget {
  /// Constructor to initialize the ResponsiveBuilder with a required builder function.
  const TheResponsiveBuilder({
    super.key,
    this.mobileBreakPoint = 600.0,
    this.enableTextScaleFactor = true,
    required this.builder,
    this.baselineWidth = 375.0,
    this.baselineHeight = 667.0,
  });

  /// The builder function which will be used to create the responsive UI.
  final ResponsiveBuild builder;

  final bool enableTextScaleFactor;

  final double baselineWidth;
  final double baselineHeight;

  /// The breakPoint is the width at which the UI should switch from mobile to tablet mode.
  final double mobileBreakPoint;

  @override
  Widget build(BuildContext context) {
    /// LayoutBuilder gives us access to the parent widget's constraints, like max and min width/height.
    return LayoutBuilder(
      builder: (context, constraints) {
        /// OrientationBuilder gives us the current orientation (portrait or landscape).
        return OrientationBuilder(
          builder: (context, orientation) {
            /// Before building the responsive UI, we set the screen size and orientation in our helper class.
            TheResponsiveHelper.setScreenSize(
              constraints: constraints,
              currentOrientation: orientation,
              mobileBreakpoint: mobileBreakPoint,
              enableTextScaleFactor: enableTextScaleFactor,
              baseWidth: baselineWidth,
              baseHeight: baselineHeight,
            );

            /// Now, using the provided builder function, we return the appropriate widget based on the current screen properties.
            /// This builder function will likely contain the responsive logic, deciding how the UI should look based on the screen type.
            return builder(
                context, orientation, TheResponsiveHelper.screenType);
          },
        );
      },
    );
  }
}

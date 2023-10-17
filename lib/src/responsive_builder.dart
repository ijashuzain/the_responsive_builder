import 'package:flutter/material.dart';

import 'helper.dart';

/// A typedef for a function that returns a widget based on the BuildContext, current Orientation, and ScreenType.
typedef ResponsiveBuild = Widget Function(
  BuildContext,
  Orientation,
  ScreenType,
);

/// This is a custom widget that helps in building responsive UI based on the screen size and orientation.
class ResponsiveBuilder extends StatelessWidget {
  /// Constructor to initialize the ResponsiveBuilder with a required builder function.
  const ResponsiveBuilder({Key? key, required this.builder}) : super(key: key);

  /// The builder function which will be used to create the responsive UI.
  final ResponsiveBuild builder;

  @override
  Widget build(BuildContext context) {
    /// LayoutBuilder gives us access to the parent widget's constraints, like max and min width/height.
    return LayoutBuilder(
      builder: (context, constraints) {
        /// OrientationBuilder gives us the current orientation (portrait or landscape).
        return OrientationBuilder(
          builder: (context, orientation) {
            /// Before building the responsive UI, we set the screen size and orientation in our helper class.
            ResponsiveHelper.setScreenSize(constraints, orientation);

            /// Now, using the provided builder function, we return the appropriate widget based on the current screen properties.
            /// This builder function will likely contain the responsive logic, deciding how the UI should look based on the screen type.
            return builder(context, orientation, ResponsiveHelper.screenType);
          },
        );
      },
    );
  }
}

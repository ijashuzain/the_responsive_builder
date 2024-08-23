import 'package:flutter/material.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class TheResponsiveWidget extends StatelessWidget {
  const TheResponsiveWidget(
      {super.key, required this.mobile, required this.tablet});

  final Widget? mobile;
  final Widget? tablet;

  @override
  Widget build(BuildContext context) {
    if (context.screenType == ScreenType.mobile) {
      return mobile ?? const SizedBox();
    }
    if (context.screenType == ScreenType.tablet) {
      return tablet ?? const SizedBox();
    }

    return const SizedBox();
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TheResponsiveGridView extends StatelessWidget {
  // Core properties for responsive behavior
  final double childWidth;  
  // Desired width of each grid item
  final double childHeight;  
  // Desired height of each grid item
  final double minSpacing;  
  // Minimum spacing between grid items
  final int? columnCount;  
  // Standard GridView properties
  final EdgeInsetsGeometry? padding;  
  // Padding around the grid
  final bool shrinkWrap;  
  // Whether the grid should shrink wrap its contents
  final bool? primary;  
  // Whether this is the primary scroll view associated with the parent
  final ScrollPhysics? physics;  
  // How the grid should respond to user scrolling
  final bool addAutomaticKeepAlives;  
  // Whether to wrap each child in an AutomaticKeepAlive
  final bool addRepaintBoundaries;  
  // Whether to wrap each child in a RepaintBoundary
  final bool addSemanticIndexes;  
  // Whether to wrap each child in an IndexedSemantics
  final double? cacheExtent;  
  // The viewport's cache extent
  final int? semanticChildCount;  
  // The number of children that will contribute semantic information
  final DragStartBehavior dragStartBehavior;  
  // Determines the way that drag start behavior is handled
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;  
  // How the grid will dismiss the keyboard
  final String? restorationId;  
  // Restoration ID to save and restore the scroll offset of the grid
  final Clip clipBehavior;  
  // How to clip the grid's contents

  // Properties specific to the non-builder constructor
  final List<Widget>? children;  
  // The widgets to display in the grid

  // Properties specific to the builder constructor
  final int? itemCount;  
  // The total number of items in the grid
  final Widget Function(BuildContext, int)? itemBuilder;  
  // Function to build grid items

  final ScrollController? controller;  
  // The controller for the grid

  // Constructor for creating a ResponsiveGridView with a list of children
  const TheResponsiveGridView({
    super.key,
    required this.childWidth,
    required this.childHeight,
    required this.children,
    this.columnCount,
    this.minSpacing = 10,
    this.padding,
    this.shrinkWrap = false,
    this.primary,
    this.physics,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge, this.controller,
  }) : itemCount = null,
       itemBuilder = null;

  // Constructor for creating a ResponsiveGridView with a builder function
  const TheResponsiveGridView.builder({
    super.key,
    required this.childWidth,
    required this.childHeight,
    required this.itemCount,
    required this.itemBuilder,
    this.columnCount,
    this.minSpacing = 10,
    this.padding,
    this.shrinkWrap = false,
    this.primary,
    this.physics,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge, this.controller,
  }) : children = null;

  @override
  Widget build(BuildContext context) {
    // Use LayoutBuilder to get the available width from the parent
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Use the maximum width provided by the parent's constraints
        final double availableWidth = constraints.maxWidth;

        int effectiveColumnCount;
        double actualSpacing;

        // Determine the number of columns and spacing
        if (columnCount != null) {
          // If columnCount is provided, use it directly
          effectiveColumnCount = columnCount!;
          // Calculate spacing based on fixed column count
          actualSpacing = (availableWidth - (childWidth * effectiveColumnCount)) / (effectiveColumnCount + 1);
        } else {
          // Calculate the number of columns that can fit in the available width
          effectiveColumnCount = ((availableWidth + minSpacing) / (childWidth + minSpacing)).floor();
          // Ensure at least one column
          effectiveColumnCount = effectiveColumnCount > 0 ? effectiveColumnCount : 1;
          // Calculate the actual spacing between items to distribute remaining space evenly
          actualSpacing = (availableWidth - (childWidth * effectiveColumnCount)) / (effectiveColumnCount + 1);
        }

        // Calculate the aspect ratio of each child to maintain dimensions
        double childAspectRatio = childWidth / childHeight;

        // Create the grid delegate with calculated parameters
        final SliverGridDelegate gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: effectiveColumnCount,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: minSpacing,
          mainAxisSpacing: minSpacing,
        );

        // Build the appropriate GridView based on the provided constructor
        if (itemBuilder != null) {
          // If an itemBuilder is provided, use GridView.builder
          return GridView.builder(
            controller: controller,
            gridDelegate: gridDelegate,
            itemCount: itemCount,
            itemBuilder: itemBuilder!,
            padding: padding ?? EdgeInsets.all(actualSpacing),
            shrinkWrap: shrinkWrap,
            primary: primary,
            physics: physics,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            cacheExtent: cacheExtent,
            semanticChildCount: semanticChildCount,
            dragStartBehavior: dragStartBehavior,
            keyboardDismissBehavior: keyboardDismissBehavior,
            restorationId: restorationId,
            clipBehavior: clipBehavior,
          );
        } else {
          // Otherwise, use standard GridView with provided children
          return GridView(
            controller: controller,
            gridDelegate: gridDelegate,
            padding: padding ?? EdgeInsets.all(actualSpacing),
            shrinkWrap: shrinkWrap,
            primary: primary,
            physics: physics,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            cacheExtent: cacheExtent,
            semanticChildCount: semanticChildCount,
            dragStartBehavior: dragStartBehavior,
            keyboardDismissBehavior: keyboardDismissBehavior,
            restorationId: restorationId,
            clipBehavior: clipBehavior,
            children: children ?? [],
          );
        }
      },
    );
  }
}
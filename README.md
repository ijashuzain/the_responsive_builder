# The Responsive Builder

This package provides a set of utilities to aid in building responsive Flutter applications that adapt to different screen sizes and orientations.

### 1. Setup

Firstly, add package to `pubspec.yaml`.

Then, wrap your main `MaterialApp` widget with the `TheResponsiveBuilder`

```dart
void main() => runApp(
  TheResponsiveBuilder(
    builder: (context, orientation, screenType) {
      return MaterialApp(
        //... your other MaterialApp properties
      );
    },
  ),
);
```

### 2. Usage of extensions

With the utilities set up, you can easily use the extensions provided:


#### - Height & Width
```dart
// This will set the height to 20% of the screen height
Container(height: 20.h, ...);

// This will set the width to 50% of the screen width
Container(width: 50.w, ...);
```


#### - Density Pixels & Scaled Pixels
```dart
// This uses a logarithmic formula to scale UI elements based on screen size and pixel density.
TextStyle(fontSize: 16.dp, ...);

// This scales the text size based on the user's font size settings.
TextStyle(fontSize: 16.sp, ...);
```


#### - Screen Type & Orientation
```dart
if (context.screenType == ScreenType.mobile) {
  // Build UI for mobile
} else {
  // Build UI for tablet
}

if (context.orientation == Orientation.portrait) {
  // Build UI for portrait mode
} else {
  // Build UI for landscape mode
}
```


#### - Lock & Unlock Screen Orientation
```dart
// Lock screen orientation to Portrait mode
context.lockToPortrait();

// Lock screen orientation to Landscape mode
context.lockToLandscape();

// Unlock screen orientation to automatic mode
context.unlockOrientation();
```



# apple_color_list

A Flutter plugin to read and write Apple color list (.clr) files.

## Platform Support

This plugin supports macOS platform only.

## Getting Started

To use this plugin, add the following dependencies to your `pubspec.yaml` file:

```yaml
dependencies:
  apple_color_list:
    git:
      url: https://github.com/albemala/apple_color_list
      ref: v1.0.0
```

## Usage

Import the package in your Dart code:

```dart
import 'package:apple_color_list/apple_color_list.dart';
```

Here are some examples of how to use the plugin:

```dart
// Read a color list from a file
final colorList = await _colorList.readColorList(tempFile.path);

// Write a color list to a file
await _colorListPlugin.writeColorList(colorList, filePath);
```

For more detailed usage instructions and a complete API reference, please refer to the documentation.

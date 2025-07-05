import 'package:apple_color_list/apple_color_list.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class ColorListWriter {
  final AppleColorListPlugin _colorListPlugin;

  ColorListWriter(this._colorListPlugin);

  Future<void> writeColorList(AppleColorList colorList) async {
    // Pick a file location to save the color list
    final selectedDirectory = await FilePicker.platform.getDirectoryPath();

    // If no directory was selected, return
    if (selectedDirectory == null) return;

    // Construct the file path
    final filePath = '$selectedDirectory/${colorList.name}.clr';

    try {
      // Use the plugin to write the color list
      await _colorListPlugin.writeColorList(colorList, filePath);

      // Optional: Add some logging or user feedback
      if (kDebugMode) print('Color list saved successfully to $filePath');
    } catch (e) {
      // Handle any errors that might occur during writing
      if (kDebugMode) print('Error writing color list: $e');
    }
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:apple_color_list/apple_color_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class ColorListReader {
  final AppleColorListPlugin _colorList;

  ColorListReader(this._colorList);

  Future<List<AppleColorList>> loadColorLists() async {
    final List<AppleColorList> loadedColorLists = [];

    try {
      // Get the assets directory content
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final manifestMap = jsonDecode(manifestContent);

      // Filter for .clr files
      final colorListPaths = manifestMap.keys
          .where(
            (key) => key.startsWith('assets/') && key.endsWith('.clr'),
          )
          .toList();

      // Get temporary directory to save the files
      final tempDir = await getTemporaryDirectory();

      for (final assetPath in colorListPaths) {
        // Read the asset file
        final data = await rootBundle.load(assetPath);
        final fileName = assetPath.split('/').last;
        final tempFile = File('${tempDir.path}/$fileName');

        // Write to temporary file
        await tempFile.writeAsBytes(
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
        );

        // Read the color list
        final colorList = await _colorList.readColorList(tempFile.path);
        loadedColorLists.add(colorList);

        // Clean up
        await tempFile.delete();
      }
    } catch (e) {
      debugPrint('Error loading color lists: $e');
    }

    return loadedColorLists;
  }
}

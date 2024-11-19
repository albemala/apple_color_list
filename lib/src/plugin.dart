import 'package:apple_color_list/src/api.g.dart';

/// The main API class for interacting with Apple Color Lists (.clr files)
class AppleColorListPlugin {
  final _api = AppleColorListApi();

  /// Reads a color list from the specified file path.
  ///
  /// Returns an [AppleColorList] containing the colors and their names.
  /// Throws an exception if the file cannot be read or is invalid.
  Future<AppleColorList> readColorList(String path) async {
    try {
      return _api.readColorList(path);
    } catch (e) {
      throw ColorListException('Failed to read color list: $e');
    }
  }

  /// Writes a color list to the specified file path.
  ///
  /// Takes an [AppleColorList] containing the colors to write and the target file path.
  /// Throws an exception if the file cannot be written.
  Future<void> writeColorList(AppleColorList colorList, String path) async {
    try {
      _api.writeColorList(colorList, path);
    } catch (e) {
      throw ColorListException('Failed to write color list: $e');
    }
  }
}

/// Exception thrown when color list operations fail
class ColorListException implements Exception {
  final String message;

  ColorListException(this.message);

  @override
  String toString() => message;
}

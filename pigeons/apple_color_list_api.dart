import 'package:pigeon/pigeon.dart';

class AppleColorList {
  final String name;
  final List<AppleColor> colors;

  AppleColorList({
    required this.name,
    required this.colors,
  });
}

class AppleColor {
  final String name;
  final double red;
  final double green;
  final double blue;
  final double alpha;

  AppleColor({
    required this.name,
    required this.red,
    required this.green,
    required this.blue,
    required this.alpha,
  });
}

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/api.g.dart',
    dartOptions: DartOptions(),
    swiftOut: 'macos/Classes/AppleColorListApi.g.swift',
    swiftOptions: SwiftOptions(),
    dartPackageName: 'apple_color_list',
  ),
)
@HostApi()
abstract class AppleColorListApi {
  @SwiftFunction('readColorList(from:)')
  AppleColorList readColorList(String path);

  @SwiftFunction('writeColorList(_:to:)')
  void writeColorList(AppleColorList colorList, String path);
}

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'apple_color_list_platform_interface.dart';

/// An implementation of [AppleColorListPlatform] that uses method channels.
class MethodChannelAppleColorList extends AppleColorListPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('apple_color_list');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:apple_color_list/apple_color_list.dart';
import 'package:apple_color_list/apple_color_list_platform_interface.dart';
import 'package:apple_color_list/apple_color_list_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAppleColorListPlatform
    with MockPlatformInterfaceMixin
    implements AppleColorListPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AppleColorListPlatform initialPlatform = AppleColorListPlatform.instance;

  test('$MethodChannelAppleColorList is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAppleColorList>());
  });

  test('getPlatformVersion', () async {
    AppleColorList appleColorListPlugin = AppleColorList();
    MockAppleColorListPlatform fakePlatform = MockAppleColorListPlatform();
    AppleColorListPlatform.instance = fakePlatform;

    expect(await appleColorListPlugin.getPlatformVersion(), '42');
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:ios_teamid/ios_teamid_platform_interface.dart';
import 'package:ios_teamid/ios_teamid_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIosTeamidPlatform 
    with MockPlatformInterfaceMixin
    implements IosTeamidPlatform {
  
  @override
  Future<String?> getTeamId() => Future.value('mock_team_id');
}

void main() {
  final IosTeamidPlatform initialPlatform = IosTeamidPlatform.instance;

  test('$MethodChannelIosTeamid is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIosTeamid>());
  });

  test('getInstance returns the default instance', () {
    expect(IosTeamidPlatform.instance, isInstanceOf<MethodChannelIosTeamid>());
  });

  test('Can set instance', () {
    final mockPlatform = MockIosTeamidPlatform();
    IosTeamidPlatform.instance = mockPlatform;
    expect(IosTeamidPlatform.instance, mockPlatform);
  });

  test('getTeamId throws unimplemented error in base class', () {
    // Create a new instance of the base class
    final platform = TestIosTeamidPlatform();
    
    // Verify that calling getTeamId throws an UnimplementedError
    expect(
      () => platform.getTeamId(),
      throwsA(isA<UnimplementedError>()),
    );
  });
}

// Test implementation of the platform interface
class TestIosTeamidPlatform extends IosTeamidPlatform {}

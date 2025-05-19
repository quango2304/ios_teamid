import 'package:flutter_test/flutter_test.dart';
import 'package:ios_teamid/ios_teamid.dart';
import 'package:ios_teamid/ios_teamid_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' as io;

// Mock implementation of the platform interface for testing
class MockIosTeamidPlatform with MockPlatformInterfaceMixin implements IosTeamidPlatform {
  @override
  Future<String?> getTeamId() => Future.value('mock_team_id');
}

// Mock for testing platform detection
class MockIosTeamid extends IosTeamid {
  final bool mockIsIOS;

  MockIosTeamid({this.mockIsIOS = true});

  @override
  bool get isIOS => mockIsIOS;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('IosTeamid', () {
    late IosTeamid iosTeamid;
    late MockIosTeamidPlatform mockPlatform;

    setUp(() {
      mockPlatform = MockIosTeamidPlatform();
      IosTeamidPlatform.instance = mockPlatform;
      iosTeamid = IosTeamid();
    });

    test('getTeamId returns correct value on iOS platform', () async {
      // Create a mock that simulates being on iOS
      final mockIosTeamid = MockIosTeamid(mockIsIOS: true);
      
      // Call the method
      final teamId = await mockIosTeamid.getTeamId();
      
      // Verify the result
      expect(teamId, 'mock_team_id');
    });

    test('getTeamId returns empty string on non-iOS platforms', () async {
      // Create a mock that simulates being on a non-iOS platform
      final mockIosTeamid = MockIosTeamid(mockIsIOS: false);
      
      // Call the method
      final teamId = await mockIosTeamid.getTeamId();
      
      // Verify the result
      expect(teamId, '');
    });

    test('isIOS getter returns correct value based on platform', () {
      // Test with iOS mock
      final iosMock = MockIosTeamid(mockIsIOS: true);
      expect(iosMock.isIOS, true);
      
      // Test with non-iOS mock
      final nonIosMock = MockIosTeamid(mockIsIOS: false);
      expect(nonIosMock.isIOS, false);
      
      // Test the actual implementation (will depend on the test environment)
      final actual = IosTeamid();
      expect(actual.isIOS, !kIsWeb && (io.Platform.isIOS));
    });
  });
}

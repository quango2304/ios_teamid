import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ios_teamid/ios_teamid_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelIosTeamid platform = MethodChannelIosTeamid();
  const MethodChannel channel = MethodChannel('ios_teamid');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        if (methodCall.method == 'getTeamId') {
          return 'test_team_id';
        }
        return null;
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getTeamId', () async {
    expect(await platform.getTeamId(), 'test_team_id');
  });

  test('method channel name is correct', () {
    expect(platform.methodChannel.name, 'ios_teamid');
  });
}

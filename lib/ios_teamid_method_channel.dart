import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ios_teamid_platform_interface.dart';

/// An implementation of [IosTeamidPlatform] that uses method channels.
class MethodChannelIosTeamid extends IosTeamidPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ios_teamid');

  @override
  Future<String?> getTeamId() async {
    final version = await methodChannel.invokeMethod<String>('getTeamId');
    return version;
  }
}

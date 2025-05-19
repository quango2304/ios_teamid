import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ios_teamid_platform_interface.dart';

/// An implementation of [IosTeamidPlatform] that uses method channels.
///
/// This implementation uses Flutter's method channel mechanism to communicate
/// with the native iOS code that retrieves the Team ID.
class MethodChannelIosTeamid extends IosTeamidPlatform {
  /// The method channel used to interact with the native platform.
  ///
  /// This channel is named 'ios_teamid' and must match the channel name
  /// used in the native iOS code.
  @visibleForTesting
  final methodChannel = const MethodChannel('ios_teamid');

  /// Retrieves the iOS Team ID by calling the native iOS implementation.
  ///
  /// This method invokes the 'getTeamId' method on the native side through
  /// the method channel and returns the result.
  ///
  /// Returns a [Future] that completes with the Team ID as a [String],
  /// or null if the Team ID could not be retrieved.
  @override
  Future<String?> getTeamId() async {
    final teamId = await methodChannel.invokeMethod<String>('getTeamId');
    return teamId;
  }
}

import 'dart:io';

import 'package:flutter/foundation.dart';

import 'ios_teamid_platform_interface.dart';

/// A Flutter plugin to retrieve the iOS Team ID (also known as the Developer Team ID)
/// from an iOS application.
///
/// This plugin only works on iOS devices. On other platforms, it returns an empty string.
/// The Team ID is useful for various iOS-specific features like App Groups, iCloud,
/// and other capabilities that require the developer's Team ID.
class IosTeamid {
  /// Determines if the current platform is iOS.
  ///
  /// Returns `true` if the app is running on an iOS device,
  /// and `false` for web or any other platform.
  bool get isIOS => !kIsWeb && Platform.isIOS;

  /// Retrieves the iOS Team ID (Developer Team ID) from the application.
  ///
  /// On iOS devices, this method returns the Team ID associated with the app.
  /// On non-iOS platforms (including web), it returns an empty string.
  ///
  /// Returns a [Future] that completes with the Team ID as a [String],
  /// or an empty string if not available or not on iOS.
  Future<String?> getTeamId() async {
    if (isIOS) {
      return IosTeamidPlatform.instance.getTeamId();
    }
    return "";
  }
}

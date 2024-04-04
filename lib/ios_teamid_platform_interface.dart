import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ios_teamid_method_channel.dart';

abstract class IosTeamidPlatform extends PlatformInterface {
  /// Constructs a IosTeamidPlatform.
  IosTeamidPlatform() : super(token: _token);

  static final Object _token = Object();

  static IosTeamidPlatform _instance = MethodChannelIosTeamid();

  /// The default instance of [IosTeamidPlatform] to use.
  ///
  /// Defaults to [MethodChannelIosTeamid].
  static IosTeamidPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IosTeamidPlatform] when
  /// they register themselves.
  static set instance(IosTeamidPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getTeamId() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

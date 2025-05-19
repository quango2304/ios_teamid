import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ios_teamid_method_channel.dart';

/// The platform interface for the ios_teamid plugin.
///
/// This abstract class defines the interface that platform-specific implementations
/// must implement. It uses the [PlatformInterface] from the plugin_platform_interface
/// package to enforce that only a single implementation can be registered at once.
abstract class IosTeamidPlatform extends PlatformInterface {
  /// Constructs a IosTeamidPlatform.
  ///
  /// Subclasses must call this constructor with the unique token.
  IosTeamidPlatform() : super(token: _token);

  /// A unique token used to verify that implementations are properly registered.
  static final Object _token = Object();

  /// The default instance of [IosTeamidPlatform] to use.
  ///
  /// Platform-specific plugins should override this with their own
  /// platform-specific implementation that extends [IosTeamidPlatform].
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

  /// Retrieves the iOS Team ID (Developer Team ID) from the application.
  ///
  /// Platform-specific implementations must override this method to provide
  /// the actual implementation for retrieving the Team ID.
  ///
  /// Returns a [Future] that completes with the Team ID as a [String],
  /// or null if not available.
  Future<String?> getTeamId() {
    throw UnimplementedError('getTeamId() has not been implemented.');
  }
}

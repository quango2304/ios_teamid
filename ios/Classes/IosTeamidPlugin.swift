import Flutter
import UIKit

/// A Flutter plugin that provides access to the iOS Team ID (Developer Team ID).
///
/// This plugin implements the iOS-specific code to retrieve the Team ID
/// associated with the application using the iOS Keychain API.
public class IosTeamidPlugin: NSObject, FlutterPlugin {
  /// Registers this plugin with the Flutter engine.
  ///
  /// - Parameter registrar: The plugin registrar used to register the plugin with the Flutter engine.
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ios_teamid", binaryMessenger: registrar.messenger())
    let instance = IosTeamidPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  /// Handles method calls from the Flutter side.
  ///
  /// - Parameters:
  ///   - call: The method call received from Flutter.
  ///   - result: The result callback to send the response back to Flutter.
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getTeamId":
      // Return the Team ID or an empty string if not available
      result(getAppGroupId() ?? "")
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  /// Retrieves the iOS Team ID (Developer Team ID) from the application.
  ///
  /// This method uses the iOS Keychain API to access the Team ID (also known as the
  /// bundleSeedID) associated with the application. The Team ID is the prefix used
  /// in App Group identifiers and other app capabilities.
  ///
  /// - Returns: The Team ID as a String, or nil if it could not be retrieved.
  private func getAppGroupId() -> String? {
    // Create a query for the Keychain to retrieve the bundleSeedID
    let queryLoad: [String: AnyObject] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrAccount as String: "bundleSeedID" as AnyObject,
      kSecAttrService as String: "" as AnyObject,
      kSecReturnAttributes as String: kCFBooleanTrue
    ]

    var result: AnyObject?
    var status = withUnsafeMutablePointer(to: &result) {
      SecItemCopyMatching(queryLoad as CFDictionary, UnsafeMutablePointer($0))
    }

    // If the item doesn't exist, try to add it
    if status == errSecItemNotFound {
      status = withUnsafeMutablePointer(to: &result) {
        SecItemAdd(queryLoad as CFDictionary, UnsafeMutablePointer($0))
      }
    }

    if status == noErr {
      // Extract the Team ID from the access group string
      if let resultDict = result as? [String: Any], let accessGroup = resultDict[kSecAttrAccessGroup as String] as? String {
        // The Team ID is the first component of the access group string (before the first period)
        let components = accessGroup.components(separatedBy: ".")
        return components.first
      } else {
        return nil
      }
    } else {
      print("Error getting bundleSeedID from Keychain: \(status)")
      return nil
    }
  }
}

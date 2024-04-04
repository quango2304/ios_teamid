import Flutter
import UIKit

public class IosTeamidPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ios_teamid", binaryMessenger: registrar.messenger())
    let instance = IosTeamidPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getTeamId":
      result(getAppGroupId() ?? "")
    default:
      result(FlutterMethodNotImplemented)
    }
  }

      private func getAppGroupId() -> String? {
              let queryLoad: [String: AnyObject] = [
                  kSecClass as String: kSecClassGenericPassword,
                  kSecAttrAccount as String: "bundleSeedID" as AnyObject,
                  kSecAttrService as String: "" as AnyObject,
                  kSecReturnAttributes as String: kCFBooleanTrue
              ]

              var result : AnyObject?
              var status = withUnsafeMutablePointer(to: &result) {
                  SecItemCopyMatching(queryLoad as CFDictionary, UnsafeMutablePointer($0))
              }

              if status == errSecItemNotFound {
                  status = withUnsafeMutablePointer(to: &result) {
                      SecItemAdd(queryLoad as CFDictionary, UnsafeMutablePointer($0))
                  }
              }

              if status == noErr {
                  if let resultDict = result as? [String: Any], let accessGroup = resultDict[kSecAttrAccessGroup as String] as? String {
                      let components = accessGroup.components(separatedBy: ".")
                      return components.first
                  }else {
                      return nil
                  }
              } else {
                  print("Error getting bundleSeedID to Keychain")
                  return nil
              }
          }
  }

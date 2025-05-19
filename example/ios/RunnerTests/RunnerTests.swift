import Flutter
import UIKit
import XCTest

@testable import ios_teamid

// This demonstrates a simple unit test of the Swift portion of this plugin's implementation.
//
// See https://developer.apple.com/documentation/xctest for more information about using XCTest.

class RunnerTests: XCTestCase {

  func testGetTeamId() {
    let plugin = IosTeamidPlugin()

    let call = FlutterMethodCall(methodName: "getTeamId", arguments: [])

    let resultExpectation = expectation(description: "result block must be called.")
    plugin.handle(call) { result in
      // The result could be an empty string or a valid Team ID depending on the test environment
      // We just verify that we get a string result and don't throw an error
      XCTAssertNotNil(result)
      XCTAssertTrue(result is String)
      resultExpectation.fulfill()
    }
    waitForExpectations(timeout: 1)
  }

  func testInvalidMethodCall() {
    let plugin = IosTeamidPlugin()

    let call = FlutterMethodCall(methodName: "invalidMethod", arguments: [])

    let resultExpectation = expectation(description: "result block must be called.")
    plugin.handle(call) { result in
      XCTAssertEqual(result as! FlutterMethodNotImplemented, FlutterMethodNotImplemented)
      resultExpectation.fulfill()
    }
    waitForExpectations(timeout: 1)
  }

}

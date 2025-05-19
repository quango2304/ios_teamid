# iOS Team ID

A Flutter plugin to retrieve the iOS Developer Team ID from an iOS application.

[![pub package](https://img.shields.io/pub/v/ios_teamid.svg)](https://pub.dev/packages/ios_teamid)

## Overview

This plugin provides a simple way to retrieve the iOS Developer Team ID (also known as the Team ID) from an iOS application. The Team ID is a unique identifier assigned to your Apple Developer account and is used in various iOS features such as App Groups, iCloud, and other app capabilities.

## Features

- Retrieve the iOS Developer Team ID
- Works on iOS devices only (returns empty string on other platforms)
- Simple API with Future-based async calls

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  ios_teamid: ^0.0.4
```

Then run:

```bash
flutter pub get
```

## Usage

```dart
import 'package:ios_teamid/ios_teamid.dart';

// Create an instance of the plugin
final iosTeamidPlugin = IosTeamid();

// Get the Team ID
try {
  String? teamId = await iosTeamidPlugin.getTeamId();
  print('iOS Team ID: $teamId');
} catch (e) {
  print('Failed to get Team ID: $e');
}
```

## How it works

The plugin uses the iOS Keychain API to access the Team ID (bundleSeedID) associated with the application. On non-iOS platforms, it returns an empty string.

## Use cases

- Setting up App Groups for sharing data between your app and extensions
- Configuring iCloud capabilities
- Working with other iOS features that require the Team ID

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Testing

This plugin includes comprehensive unit tests for both the Dart and Swift implementations. To run the tests:

```bash
# Run Dart tests
flutter test

# Run iOS tests (from the example app directory)
cd example/ios
xcodebuild test -workspace Runner.xcworkspace -scheme Runner -destination 'platform=iOS Simulator,name=iPhone 14'
```

The test suite includes:
- Tests for the main plugin class
- Tests for the method channel implementation
- Tests for the platform interface
- Tests for iOS-specific functionality
- Tests for cross-platform behavior

import 'dart:io';

import 'package:flutter/foundation.dart';

import 'ios_teamid_platform_interface.dart';

class IosTeamid {
  bool get isIOS => !kIsWeb && Platform.isIOS;
  Future<String?> getTeamId() async {
    if (isIOS) {
      return IosTeamidPlatform.instance.getTeamId();
    }
    return "";
  }
}

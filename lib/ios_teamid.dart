import 'dart:io';

import 'ios_teamid_platform_interface.dart';

class IosTeamid {
  Future<String?> getTeamId() async {
    if (Platform.isIOS) {
      return IosTeamidPlatform.instance.getTeamId();
    }
    return "";
  }
}

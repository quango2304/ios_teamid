
import 'ios_teamid_platform_interface.dart';

class IosTeamid {
  Future<String?> getTeamId() {
    return IosTeamidPlatform.instance.getTeamId();
  }
}

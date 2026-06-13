import 'package:arrpilot/core.dart';

abstract class ArrPilotWebhooks {
  Future<void> handle(Map<dynamic, dynamic> data);

  static String buildUserTokenURL(String token, ArrPilotModule module) {
    return 'https://notify.arrpilot.app/v1/${module.key}/user/$token';
  }

  static String buildDeviceTokenURL(String token, ArrPilotModule module) {
    return 'https://notify.arrpilot.app/v1/${module.key}/device/$token';
  }
}

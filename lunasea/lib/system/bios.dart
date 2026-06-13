import 'package:flutter/material.dart';

import 'package:arrpilot/system/quick_actions/quick_actions.dart';

class ArrPilotOS {
  Future<void> boot(BuildContext context) async {
    if (ArrPilotQuickActions.isSupported) ArrPilotQuickActions().initialize();
  }
}

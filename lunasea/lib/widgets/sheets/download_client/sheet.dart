import 'package:flutter/material.dart';
import 'package:arrpilot/database/models/profile.dart';
import 'package:arrpilot/modules.dart';
import 'package:arrpilot/modules/nzbget.dart';
import 'package:arrpilot/modules/sabnzbd/routes.dart';
import 'package:arrpilot/utils/dialogs.dart';
import 'package:arrpilot/vendor.dart';
import 'package:arrpilot/widgets/pages/invalid_route.dart';
import 'package:arrpilot/widgets/ui.dart';

class DownloadClientSheet extends ArrPilotBottomModalSheet {
  Future<ArrPilotModule?> getDownloadClient() async {
    final profile = ArrPilotProfile.current;
    final nzbget = profile.nzbgetEnabled;
    final sabnzbd = profile.sabnzbdEnabled;

    if (nzbget && sabnzbd) {
      return ArrPilotDialogs().selectDownloadClient();
    }
    if (nzbget) {
      return ArrPilotModule.NZBGET;
    }
    if (sabnzbd) {
      return ArrPilotModule.SABNZBD;
    }

    return null;
  }

  @override
  Future<dynamic> show({
    Widget Function(BuildContext context)? builder,
  }) async {
    final module = await getDownloadClient();
    if (module != null) {
      return showModal(builder: (context) {
        if (module == ArrPilotModule.SABNZBD) {
          return const SABnzbdRoute(showDrawer: false);
        }
        if (module == ArrPilotModule.NZBGET) {
          return const NZBGetRoute(showDrawer: false);
        }
        return InvalidRoutePage();
      });
    }
  }
}

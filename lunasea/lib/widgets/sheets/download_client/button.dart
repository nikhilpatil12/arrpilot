import 'package:flutter/material.dart';
import 'package:arrpilot/database/models/profile.dart';
import 'package:arrpilot/widgets/sheets/download_client/sheet.dart';
import 'package:arrpilot/widgets/ui.dart';

class DownloadClientButton extends StatelessWidget {
  const DownloadClientButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (_shouldShow) {
      return ArrPilotIconButton.appBar(
        icon: ArrPilotIcons.DOWNLOAD,
        onPressed: DownloadClientSheet().show,
      );
    }
    return const SizedBox();
  }

  bool get _shouldShow {
    final profile = ArrPilotProfile.current;
    return profile.sabnzbdEnabled || profile.nzbgetEnabled;
  }
}

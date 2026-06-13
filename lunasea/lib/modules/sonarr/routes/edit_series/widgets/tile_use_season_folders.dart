import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/sonarr.dart';

class SonarrSeriesEditSeasonFoldersTile extends StatelessWidget {
  const SonarrSeriesEditSeasonFoldersTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      title: 'sonarr.UseSeasonFolders'.tr(),
      trailing: ArrPilotSwitch(
        value: context.watch<SonarrSeriesEditState>().useSeasonFolders,
        onChanged: (value) {
          context.read<SonarrSeriesEditState>().useSeasonFolders = value;
        },
      ),
    );
  }
}

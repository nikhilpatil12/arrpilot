import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/sonarr.dart';

class SonarrSeriesEditTagsTile extends StatelessWidget {
  const SonarrSeriesEditTagsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      title: 'sonarr.Tags'.tr(),
      body: [
        TextSpan(
          text: (context.watch<SonarrSeriesEditState>().tags?.isEmpty ?? true)
              ? 'arrpilot.NotSet'.tr()
              : context
                  .watch<SonarrSeriesEditState>()
                  .tags
                  ?.map((e) => e.label)
                  .join(', '),
        )
      ],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () async => await SonarrDialogs().setEditTags(context),
    );
  }
}

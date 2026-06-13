import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/sonarr.dart';

class SonarrSeriesAddDetailsTagsTile extends StatelessWidget {
  const SonarrSeriesAddDetailsTagsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SonarrTag> _tags = context.watch<SonarrSeriesAddDetailsState>().tags;
    return ArrPilotBlock(
      title: 'sonarr.Tags'.tr(),
      body: [
        TextSpan(
          text: _tags.isEmpty
              ? ArrPilotUI.TEXT_EMDASH
              : _tags.map((e) => e.label).join(', '),
        ),
      ],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () async => await SonarrDialogs().setAddTags(context),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';

class RadarrMoviesEditTagsTile extends StatelessWidget {
  const RadarrMoviesEditTagsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<RadarrTag> _tags = context.watch<RadarrMoviesEditState>().tags;
    return ArrPilotBlock(
      title: 'radarr.Tags'.tr(),
      body: [
        TextSpan(
          text: _tags.isEmpty
              ? ArrPilotUI.TEXT_EMDASH
              : _tags.map((e) => e.label).join(', '),
        ),
      ],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () async => await RadarrDialogs().setEditTags(context),
    );
  }
}

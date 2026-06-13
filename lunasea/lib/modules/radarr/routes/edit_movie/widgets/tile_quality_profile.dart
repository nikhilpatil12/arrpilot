import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';

class RadarrMoviesEditQualityProfileTile extends StatelessWidget {
  final List<RadarrQualityProfile?>? profiles;

  const RadarrMoviesEditQualityProfileTile({
    Key? key,
    required this.profiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<RadarrMoviesEditState, RadarrQualityProfile>(
      selector: (_, state) => state.qualityProfile,
      builder: (context, profile, _) => ArrPilotBlock(
        title: 'radarr.QualityProfile'.tr(),
        body: [TextSpan(text: profile.name ?? ArrPilotUI.TEXT_EMDASH)],
        trailing: const ArrPilotIconButton.arrow(),
        onTap: () async {
          Tuple2<bool, RadarrQualityProfile?> values =
              await RadarrDialogs().editQualityProfile(context, profiles!);
          if (values.item1)
            context.read<RadarrMoviesEditState>().qualityProfile =
                values.item2!;
        },
      ),
    );
  }
}

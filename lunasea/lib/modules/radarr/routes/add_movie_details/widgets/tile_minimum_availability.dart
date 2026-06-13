import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';

class RadarrAddMovieDetailsMinimumAvailabilityTile extends StatelessWidget {
  const RadarrAddMovieDetailsMinimumAvailabilityTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<RadarrAddMovieDetailsState, RadarrAvailability>(
      selector: (_, state) => state.availability,
      builder: (context, availability, _) {
        return ArrPilotBlock(
          title: 'radarr.MinimumAvailability'.tr(),
          body: [TextSpan(text: availability.readable)],
          trailing: const ArrPilotIconButton.arrow(),
          onTap: () async {
            Tuple2<bool, RadarrAvailability?> values =
                await RadarrDialogs().editMinimumAvailability(context);
            if (values.item1)
              context.read<RadarrAddMovieDetailsState>().availability =
                  values.item2!;
          },
        );
      },
    );
  }
}

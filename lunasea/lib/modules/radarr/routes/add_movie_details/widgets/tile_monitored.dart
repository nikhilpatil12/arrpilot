import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';

class RadarrAddMovieDetailsMonitoredTile extends StatelessWidget {
  const RadarrAddMovieDetailsMonitoredTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      title: 'radarr.Monitor'.tr(),
      trailing: Selector<RadarrAddMovieDetailsState, bool>(
        selector: (_, state) => state.monitored,
        builder: (context, monitored, _) => ArrPilotSwitch(
          value: monitored,
          onChanged: (value) =>
              context.read<RadarrAddMovieDetailsState>().monitored = value,
        ),
      ),
    );
  }
}

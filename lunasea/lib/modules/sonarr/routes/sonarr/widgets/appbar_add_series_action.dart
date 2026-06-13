import 'package:flutter/material.dart';
import 'package:arrpilot/router/routes/sonarr.dart';
import 'package:arrpilot/widgets/ui.dart';

class SonarrAppBarAddSeriesAction extends StatelessWidget {
  const SonarrAppBarAddSeriesAction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotIconButton(
      icon: Icons.add_rounded,
      onPressed: SonarrRoutes.ADD_SERIES.go,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/string/string.dart';
import 'package:arrpilot/modules/sonarr.dart';

class SonarrSeriesEditSeriesTypeTile extends StatelessWidget {
  const SonarrSeriesEditSeriesTypeTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'sonarr.SeriesType'.tr(),
      body: [
        TextSpan(
            text: context
                    .watch<SonarrSeriesEditState>()
                    .seriesType
                    ?.value
                    ?.toTitleCase() ??
                LunaUI.TEXT_EMDASH),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    Tuple2<bool, SonarrSeriesType?> result =
        await SonarrDialogs().editSeriesType(context);
    if (result.item1)
      context.read<SonarrSeriesEditState>().seriesType = result.item2!;
  }
}

import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';

class RadarrMoviesEditPathTile extends StatelessWidget {
  const RadarrMoviesEditPathTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<RadarrMoviesEditState, String>(
      selector: (_, state) => state.path,
      builder: (context, path, _) => ArrPilotBlock(
        title: 'radarr.MoviePath'.tr(),
        body: [TextSpan(text: path)],
        trailing: const ArrPilotIconButton.arrow(),
        onTap: () async {
          Tuple2<bool, String> _values = await ArrPilotDialogs().editText(
            context,
            'radarr.MoviePath'.tr(),
            prefill: path,
          );
          if (_values.item1)
            context.read<RadarrMoviesEditState>().path = _values.item2;
        },
      ),
    );
  }
}

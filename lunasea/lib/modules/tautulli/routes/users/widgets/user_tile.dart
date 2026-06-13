import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/datetime.dart';
import 'package:arrpilot/modules/tautulli.dart';
import 'package:arrpilot/router/routes/tautulli.dart';

class TautulliUserTile extends StatelessWidget {
  final TautulliTableUser user;

  const TautulliUserTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      title: user.friendlyName,
      posterUrl: user.userThumb,
      posterHeaders: context.read<TautulliState>().headers,
      posterPlaceholderIcon: ArrPilotIcons.USER,
      posterIsSquare: true,
      backgroundUrl: context.watch<TautulliState>().getImageURLFromPath(
            user.thumb,
            width: MediaQuery.of(context).size.width.truncate(),
          ),
      backgroundHeaders: context.read<TautulliState>().headers,
      body: [
        TextSpan(text: user.lastSeen?.asAge() ?? 'Never'),
        TextSpan(text: user.lastPlayed ?? 'Never'),
      ],
      bodyLeadingIcons: const [
        ArrPilotIcons.WATCHED,
        ArrPilotIcons.PLAY,
      ],
      onTap: () => TautulliRoutes.USER_DETAILS.go(params: {
        'user': user.userId!.toString(),
      }),
    );
  }
}

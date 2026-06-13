import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/string/string.dart';
import 'package:arrpilot/modules/tautulli.dart';
import 'package:arrpilot/router/routes/tautulli.dart';

class TautulliActivityTile extends StatelessWidget {
  final TautulliSession session;
  final bool disableOnTap;

  const TautulliActivityTile({
    Key? key,
    required this.session,
    this.disableOnTap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      title: session.lunaTitle,
      posterUrl: session.lunaArtworkPath(context),
      posterHeaders: context.read<TautulliState>().headers,
      posterPlaceholderIcon: ArrPilotIcons.VIDEO_CAM,
      backgroundUrl: context.watch<TautulliState>().getImageURLFromPath(
            session.art,
            width: MediaQuery.of(context).size.width.truncate(),
          ),
      body: [
        _subtitle1(),
        _subtitle2(),
        _subtitle3(),
      ],
      bottom: _bottomWidget(),
      bottomHeight: ArrPilotLinearPercentIndicator.height,
      trailing: ArrPilotIconButton(icon: session.lunaSessionStateIcon),
      onTap: disableOnTap ? null : () async => _enterDetails(context),
    );
  }

  TextSpan _subtitle1() {
    if (session.mediaType == TautulliMediaType.EPISODE) {
      return TextSpan(
        children: [
          TextSpan(text: session.parentTitle),
          TextSpan(text: ArrPilotUI.TEXT_BULLET.pad()),
          TextSpan(
              text: 'tautulli.Episode'.tr(args: [
            session.mediaIndex?.toString() ?? ArrPilotUI.TEXT_EMDASH
          ])),
          const TextSpan(text: ': '),
          TextSpan(
            style: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
            text: session.title ?? ArrPilotUI.TEXT_EMDASH,
          ),
        ],
      );
    }
    if (session.mediaType == TautulliMediaType.MOVIE) {
      return TextSpan(text: session.year.toString());
    }
    if (session.mediaType == TautulliMediaType.TRACK) {
      return TextSpan(
        children: [
          TextSpan(text: session.parentTitle),
          TextSpan(text: ArrPilotUI.TEXT_EMDASH.pad()),
          TextSpan(
            style: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
            text: session.title,
          ),
        ],
      );
    }
    if (session.mediaType == TautulliMediaType.LIVE) {
      return TextSpan(text: session.title);
    }
    return const TextSpan(text: ArrPilotUI.TEXT_EMDASH);
  }

  TextSpan _subtitle2() {
    return TextSpan(text: session.lunaFriendlyName);
  }

  TextSpan _subtitle3() {
    return TextSpan(
      text: session.formattedStream(),
      style: const TextStyle(
        fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
        color: ArrPilotColours.accent,
      ),
    );
  }

  Widget _bottomWidget() {
    return SizedBox(
      height: ArrPilotLinearPercentIndicator.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ArrPilotLinearPercentIndicator(
            percent: session.lunaTranscodeProgress,
            progressColor: ArrPilotColours.accent.withOpacity(
              ArrPilotUI.OPACITY_SPLASH,
            ),
            backgroundColor: Colors.transparent,
          ),
          ArrPilotLinearPercentIndicator(
            percent: session.lunaProgressPercent,
            progressColor: ArrPilotColours.accent,
            backgroundColor: ArrPilotColours.grey.withOpacity(
              ArrPilotUI.OPACITY_SPLASH,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _enterDetails(BuildContext context) async {
    TautulliRoutes.ACTIVITY_DETAILS.go(params: {
      'session': session.sessionKey.toString(),
    });
  }
}

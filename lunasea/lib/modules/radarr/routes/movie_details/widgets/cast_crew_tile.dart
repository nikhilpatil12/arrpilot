import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/string/links.dart';
import 'package:arrpilot/modules/radarr.dart';

class RadarrMovieDetailsCastCrewTile extends StatelessWidget {
  final RadarrMovieCredits credits;

  const RadarrMovieDetailsCastCrewTile({
    Key? key,
    required this.credits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      title: credits.personName,
      posterPlaceholderIcon: ArrPilotIcons.USER,
      posterUrl: credits.images!.isEmpty ? null : credits.images![0].url,
      body: [
        TextSpan(text: _position),
        TextSpan(
          text: credits.type!.readable,
          style: TextStyle(
            fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
            color: credits.type == RadarrCreditType.CAST
                ? ArrPilotColours.accent
                : ArrPilotColours.orange,
          ),
        ),
      ],
      onTap: credits.personTmdbId?.toString().openTmdbPerson,
    );
  }

  String? get _position {
    switch (credits.type) {
      case RadarrCreditType.CREW:
        return credits.job!.isEmpty ? ArrPilotUI.TEXT_EMDASH : credits.job;
      case RadarrCreditType.CAST:
        return credits.character!.isEmpty
            ? ArrPilotUI.TEXT_EMDASH
            : credits.character;
      default:
        return ArrPilotUI.TEXT_EMDASH;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:arrpilot/extensions/string/links.dart';
import 'package:arrpilot/modules/lidarr/core/api.dart';
import 'package:arrpilot/utils/links.dart';
import 'package:arrpilot/widgets/ui.dart';

class LinksSheet extends ArrPilotBottomModalSheet {
  LidarrCatalogueData artist;

  LinksSheet({
    required this.artist,
  });

  @override
  Widget builder(BuildContext context) {
    return ArrPilotListViewModal(
      children: [
        if (artist.bandsintownURI?.isNotEmpty ?? false)
          ArrPilotBlock(
            title: 'Bandsintown',
            leading: const ArrPilotIconButton(
              icon: ArrPilotIcons.BANDSINTOWN,
              iconSize: ArrPilotUI.ICON_SIZE - 4.0,
            ),
            onTap: artist.bandsintownURI!.openLink,
          ),
        if (artist.discogsURI?.isNotEmpty ?? false)
          ArrPilotBlock(
            title: 'Discogs',
            leading: const ArrPilotIconButton(
              icon: ArrPilotIcons.DISCOGS,
              iconSize: ArrPilotUI.ICON_SIZE - 2.0,
            ),
            onTap: artist.discogsURI!.openLink,
          ),
        if (artist.lastfmURI?.isNotEmpty ?? false)
          ArrPilotBlock(
            title: 'Last.fm',
            leading: const ArrPilotIconButton(icon: ArrPilotIcons.LASTFM),
            onTap: artist.lastfmURI!.openLink,
          ),
        ArrPilotBlock(
          title: 'MusicBrainz',
          leading: const ArrPilotIconButton(icon: ArrPilotIcons.MUSICBRAINZ),
          onTap:
              ArrPilotLinkedContent.musicBrainz(artist.foreignArtistID)!.openLink,
        ),
      ],
    );
  }
}

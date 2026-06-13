import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/lidarr.dart';

class LidarrDetailsOverview extends StatefulWidget {
  final LidarrCatalogueData data;

  const LidarrDetailsOverview({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<LidarrDetailsOverview> createState() => _State();
}

class _State extends State<LidarrDetailsOverview>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ArrPilotListView(
      controller: LidarrArtistNavigationBar.scrollControllers[0],
      children: <Widget>[
        LidarrDescriptionBlock(
          title: widget.data.title,
          description: widget.data.overview == ''
              ? 'No Summary Available'
              : widget.data.overview,
          uri: widget.data.posterURI(),
          squareImage: true,
          headers: ArrPilotProfile.current.lidarrHeaders,
        ),
        ArrPilotTableCard(
          content: [
            ArrPilotTableContent(
              title: 'Path',
              body: widget.data.path,
            ),
            ArrPilotTableContent(
              title: 'Quality',
              body: widget.data.quality,
            ),
            ArrPilotTableContent(
              title: 'Metadata',
              body: widget.data.metadata,
            ),
            ArrPilotTableContent(
              title: 'Albums',
              body: widget.data.albums,
            ),
            ArrPilotTableContent(
              title: 'Tracks',
              body: widget.data.tracks,
            ),
            ArrPilotTableContent(
              title: 'Genres',
              body: widget.data.genre,
            ),
          ],
        ),
      ],
    );
  }
}

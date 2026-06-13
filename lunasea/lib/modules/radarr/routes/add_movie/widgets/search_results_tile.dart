import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/string/string.dart';
import 'package:arrpilot/extensions/string/links.dart';
import 'package:arrpilot/modules/radarr.dart';
import 'package:arrpilot/router/routes/radarr.dart';

class RadarrAddMovieSearchResultTile extends StatefulWidget {
  final RadarrMovie movie;
  final bool onTapShowOverview;
  final bool exists;
  final bool isExcluded;

  const RadarrAddMovieSearchResultTile({
    Key? key,
    required this.movie,
    required this.exists,
    required this.isExcluded,
    this.onTapShowOverview = false,
  }) : super(key: key);

  @override
  State<RadarrAddMovieSearchResultTile> createState() => _State();
}

class _State extends State<RadarrAddMovieSearchResultTile> {
  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      backgroundUrl: widget.movie.remotePoster,
      posterUrl: widget.movie.remotePoster,
      posterHeaders: context.watch<RadarrState>().headers,
      posterPlaceholderIcon: ArrPilotIcons.VIDEO_CAM,
      title: widget.movie.title,
      titleColor: widget.isExcluded ? ArrPilotColours.red : Colors.white,
      disabled: widget.exists,
      body: [_subtitle1()],
      bottom: _subtitle2(),
      bottomHeight: ArrPilotBlock.SUBTITLE_HEIGHT * 2,
      onTap: _onTap,
      onLongPress: _onLongPress,
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(
      children: [
        TextSpan(text: widget.movie.lunaYear),
        TextSpan(text: ArrPilotUI.TEXT_BULLET.pad()),
        TextSpan(text: widget.movie.lunaRuntime),
        TextSpan(text: ArrPilotUI.TEXT_BULLET.pad()),
        TextSpan(text: widget.movie.lunaStudio),
      ],
    );
  }

  Widget _subtitle2() {
    String? summary;
    if (widget.movie.overview == null || widget.movie.overview!.isEmpty) {
      summary = 'radarr.NoSummaryIsAvailable'.tr();
    } else {
      summary = widget.movie.overview;
    }
    return SizedBox(
      height: ArrPilotBlock.SUBTITLE_HEIGHT * 2,
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: ArrPilotUI.FONT_SIZE_H3,
            color: ArrPilotColours.grey,
          ),
          children: [
            ArrPilotTextSpan.extended(text: summary),
          ],
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }

  Future<void> _onTap() async {
    if (widget.onTapShowOverview) {
      ArrPilotDialogs().textPreview(context, widget.movie.title,
          widget.movie.overview ?? 'radarr.NoSummaryIsAvailable'.tr());
    } else if (widget.exists) {
      RadarrRoutes.MOVIE.go(params: {
        'movie': widget.movie.id!.toString(),
      });
    } else {
      RadarrRoutes.ADD_MOVIE_DETAILS.go(extra: widget.movie, queryParams: {
        'isDiscovery': 'false',
      });
    }
  }

  Future<void>? _onLongPress() async =>
      widget.movie.tmdbId?.toString().openTmdbMovie();
}

import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/datetime.dart';
import 'package:arrpilot/extensions/string/string.dart';
import 'package:arrpilot/modules/sonarr.dart';
import 'package:arrpilot/router/routes/sonarr.dart';

class SonarrMissingTile extends StatefulWidget {
  static final itemExtent = ArrPilotBlock.calculateItemExtent(3);

  final SonarrMissingRecord record;
  final SonarrSeries? series;

  const SonarrMissingTile({
    Key? key,
    required this.record,
    this.series,
  }) : super(key: key);

  @override
  State<SonarrMissingTile> createState() => _State();
}

class _State extends State<SonarrMissingTile> {
  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      backgroundUrl:
          context.read<SonarrState>().getFanartURL(widget.record.seriesId),
      posterUrl:
          context.read<SonarrState>().getPosterURL(widget.record.seriesId),
      posterHeaders: context.read<SonarrState>().headers,
      posterPlaceholderIcon: ArrPilotIcons.VIDEO_CAM,
      title: widget.record.series?.title ??
          widget.series?.title ??
          ArrPilotUI.TEXT_EMDASH,
      body: [
        _subtitle1(),
        _subtitle2(),
        _subtitle3(),
      ],
      disabled: !widget.record.monitored!,
      onTap: _onTap,
      onLongPress: _onLongPress,
      trailing: _trailing(),
    );
  }

  Widget _trailing() {
    return ArrPilotIconButton(
      icon: Icons.search_rounded,
      onPressed: _trailingOnTap,
      onLongPress: _trailingOnLongPress,
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(
      children: [
        TextSpan(
            text: widget.record.seasonNumber == 0
                ? 'Specials'
                : 'Season ${widget.record.seasonNumber}'),
        TextSpan(text: ArrPilotUI.TEXT_BULLET.pad()),
        TextSpan(text: 'Episode ${widget.record.episodeNumber}'),
      ],
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      style: const TextStyle(
        fontStyle: FontStyle.italic,
      ),
      text: widget.record.title ?? 'lunasea.Unknown'.tr(),
    );
  }

  TextSpan _subtitle3() {
    return TextSpan(
      style: const TextStyle(
        fontSize: ArrPilotUI.FONT_SIZE_H3,
        color: ArrPilotColours.red,
        fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
      ),
      children: [
        TextSpan(
            text: widget.record.airDateUtc == null
                ? 'Aired'
                : 'Aired ${widget.record.airDateUtc!.toLocal().asAge()}'),
      ],
    );
  }

  Future<void> _onTap() async {
    SonarrRoutes.SERIES_SEASON.go(params: {
      'series': (widget.record.seriesId ?? -1).toString(),
      'season': (widget.record.seasonNumber ?? -1).toString(),
    });
  }

  Future<void> _onLongPress() async {
    SonarrRoutes.SERIES.go(params: {
      'series': widget.record.seriesId!.toString(),
    });
  }

  Future<void> _trailingOnTap() async {
    Provider.of<SonarrState>(context, listen: false)
        .api!
        .command
        .episodeSearch(episodeIds: [widget.record.id!])
        .then((_) => showLunaSuccessSnackBar(
              title: 'Searching for Episode...',
              message: widget.record.title,
            ))
        .catchError((error, stack) {
          ArrPilotLogger().error(
              'Failed to search for episode: ${widget.record.id}',
              error,
              stack);
          showLunaErrorSnackBar(
            title: 'Failed to Search',
            error: error,
          );
        });
  }

  Future<void> _trailingOnLongPress() async {
    return SonarrRoutes.RELEASES.go(queryParams: {
      'episode': widget.record.id!.toString(),
    });
  }
}

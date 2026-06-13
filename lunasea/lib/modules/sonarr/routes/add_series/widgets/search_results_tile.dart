import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/string/string.dart';
import 'package:arrpilot/extensions/string/links.dart';
import 'package:arrpilot/modules/sonarr.dart';
import 'package:arrpilot/router/routes/sonarr.dart';

class SonarrSeriesAddSearchResultTile extends StatefulWidget {
  static final double extent = ArrPilotBlock.calculateItemExtent(
    1,
    hasBottom: true,
    bottomHeight: ArrPilotBlock.SUBTITLE_HEIGHT * 2,
  );

  final SonarrSeries series;
  final bool onTapShowOverview;
  final bool exists;
  final bool isExcluded;

  const SonarrSeriesAddSearchResultTile({
    Key? key,
    required this.series,
    required this.exists,
    required this.isExcluded,
    this.onTapShowOverview = false,
  }) : super(key: key);

  @override
  State<SonarrSeriesAddSearchResultTile> createState() => _State();
}

class _State extends State<SonarrSeriesAddSearchResultTile> {
  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      backgroundUrl: widget.series.remotePoster,
      posterUrl: widget.series.remotePoster,
      posterHeaders: context.watch<SonarrState>().headers,
      posterPlaceholderIcon: ArrPilotIcons.VIDEO_CAM,
      title: widget.series.title,
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
    return TextSpan(children: [
      TextSpan(text: widget.series.lunaSeasonCount),
      TextSpan(text: ArrPilotUI.TEXT_BULLET.pad()),
      TextSpan(text: widget.series.lunaYear),
      TextSpan(text: ArrPilotUI.TEXT_BULLET.pad()),
      TextSpan(text: widget.series.lunaNetwork),
    ]);
  }

  Widget _subtitle2() {
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
            ArrPilotTextSpan.extended(text: widget.series.lunaOverview),
          ],
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }

  Future<void> _onTap() async {
    if (widget.onTapShowOverview) {
      ArrPilotDialogs().textPreview(
        context,
        widget.series.title,
        widget.series.overview ?? 'sonarr.NoSummaryAvailable'.tr(),
      );
    } else if (widget.exists) {
      SonarrRoutes.SERIES.go(params: {'series': widget.series.id!.toString()});
    } else {
      SonarrRoutes.ADD_SERIES_DETAILS.go(extra: widget.series);
    }
  }

  Future<void>? _onLongPress() async =>
      widget.series.tvdbId?.toString().openTvdbSeries();
}

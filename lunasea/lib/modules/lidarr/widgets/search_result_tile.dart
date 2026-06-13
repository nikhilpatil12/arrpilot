import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/double/time.dart';
import 'package:arrpilot/extensions/int/bytes.dart';
import 'package:arrpilot/extensions/string/links.dart';
import 'package:arrpilot/extensions/string/string.dart';
import 'package:arrpilot/modules/lidarr.dart';
import 'package:arrpilot/router/router.dart';

class LidarrReleasesTile extends StatefulWidget {
  final LidarrReleaseData release;

  const LidarrReleasesTile({
    Key? key,
    required this.release,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LidarrReleasesTile> {
  ArrPilotLoadingState _downloadState = ArrPilotLoadingState.INACTIVE;

  @override
  Widget build(BuildContext context) {
    return ArrPilotExpandableListTile(
      title: widget.release.title,
      collapsedSubtitles: [
        _subtitle1(),
        _subtitle2(),
      ],
      collapsedTrailing: _trailing(),
      expandedHighlightedNodes: _highlightedNodes(),
      expandedTableContent: _tableContent(),
      expandedTableButtons: _tableButtons(),
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(children: [
      TextSpan(
        style: TextStyle(
          color: lunaProtocolColor,
          fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
        ),
        text: widget.release.protocol.toTitleCase(),
      ),
      if (widget.release.isTorrent)
        TextSpan(
          text: ' (${widget.release.seeders}/${widget.release.leechers})',
          style: TextStyle(
            color: lunaProtocolColor,
            fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
          ),
        ),
      TextSpan(text: ArrPilotUI.TEXT_BULLET.pad()),
      TextSpan(text: widget.release.indexer),
      TextSpan(text: ArrPilotUI.TEXT_BULLET.pad()),
      TextSpan(text: widget.release.ageHours.asTimeAgo()),
    ]);
  }

  TextSpan _subtitle2() {
    return TextSpan(
      children: [
        TextSpan(text: widget.release.quality),
        TextSpan(text: ArrPilotUI.TEXT_BULLET.pad()),
        TextSpan(text: widget.release.size.asBytes()),
      ],
    );
  }

  Widget _trailing() {
    return ArrPilotIconButton(
      icon: widget.release.approved
          ? Icons.file_download_rounded
          : Icons.report_outlined,
      color: widget.release.approved ? Colors.white : ArrPilotColours.red,
      onPressed: () async =>
          widget.release.approved ? _startDownload() : _showWarnings(),
      onLongPress: _startDownload,
      loadingState: _downloadState,
    );
  }

  List<ArrPilotHighlightedNode> _highlightedNodes() {
    return [
      ArrPilotHighlightedNode(
        text: widget.release.protocol.toTitleCase(),
        backgroundColor: lunaProtocolColor,
      ),
    ];
  }

  List<ArrPilotTableContent> _tableContent() {
    return [
      ArrPilotTableContent(
          title: 'source', body: widget.release.protocol.toTitleCase()),
      ArrPilotTableContent(title: 'age', body: widget.release.ageHours.asTimeAgo()),
      ArrPilotTableContent(title: 'indexer', body: widget.release.indexer),
      ArrPilotTableContent(title: 'size', body: widget.release.size.asBytes()),
      ArrPilotTableContent(title: 'quality', body: widget.release.quality),
      if (widget.release.protocol == 'torrent' &&
          widget.release.seeders != null)
        ArrPilotTableContent(title: 'seeders', body: '${widget.release.seeders}'),
      if (widget.release.protocol == 'torrent' &&
          widget.release.leechers != null)
        ArrPilotTableContent(title: 'leechers', body: '${widget.release.leechers}'),
    ];
  }

  Color get lunaProtocolColor {
    if (!widget.release.isTorrent) return ArrPilotColours.accent;
    int seeders = widget.release.seeders ?? 0;
    if (seeders > 10) return ArrPilotColours.blue;
    if (seeders > 0) return ArrPilotColours.orange;
    return ArrPilotColours.red;
  }

  List<ArrPilotButton> _tableButtons() {
    return [
      ArrPilotButton(
        type: ArrPilotButtonType.TEXT,
        icon: Icons.download_rounded,
        text: 'Download',
        onTap: _startDownload,
        loadingState: _downloadState,
      ),
      if (widget.release.infoUrl.isNotEmpty)
        ArrPilotButton.text(
          text: 'Indexer',
          icon: Icons.info_outline_rounded,
          color: ArrPilotColours.blue,
          onTap: widget.release.infoUrl.openLink,
        ),
      if (!widget.release.approved)
        ArrPilotButton.text(
          text: 'Rejected',
          icon: Icons.report_outlined,
          color: ArrPilotColours.red,
          onTap: _showWarnings,
        ),
    ];
  }

  Future<void> _startDownload() async {
    setState(() => _downloadState = ArrPilotLoadingState.ACTIVE);
    LidarrAPI _api = LidarrAPI.from(ArrPilotProfile.current);
    await _api
        .downloadRelease(widget.release.guid, widget.release.indexerId)
        .then((_) {
      showLunaSuccessSnackBar(
        title: 'Downloading...',
        message: widget.release.title,
        showButton: true,
        buttonText: 'Back',
        buttonOnPressed: ArrPilotRouter().popToRootRoute,
      );
    }).catchError((error, stack) {
      showLunaErrorSnackBar(
        title: 'Failed to Start Downloading',
        error: error,
      );
    });
    setState(() => _downloadState = ArrPilotLoadingState.INACTIVE);
  }

  Future<void> _showWarnings() async => await ArrPilotDialogs().showRejections(
        context,
        widget.release.rejections.cast<String>(),
      );
}

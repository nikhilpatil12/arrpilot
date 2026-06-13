import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/string/links.dart';
import 'package:arrpilot/extensions/string/string.dart';
import 'package:arrpilot/modules/radarr.dart';

class RadarrReleasesTile extends StatefulWidget {
  final RadarrRelease release;

  const RadarrReleasesTile({
    required this.release,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrReleasesTile> {
  ArrPilotLoadingState _downloadState = ArrPilotLoadingState.INACTIVE;

  @override
  Widget build(BuildContext context) {
    return ArrPilotExpandableListTile(
      title: widget.release.title!,
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

  Widget _trailing() {
    return ArrPilotIconButton(
      icon: widget.release.lunaTrailingIcon,
      color: widget.release.lunaTrailingColor,
      onPressed: () async =>
          widget.release.rejected! ? _showWarnings() : _startDownload(),
      onLongPress: _startDownload,
      loadingState: _downloadState,
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(
      children: [
        TextSpan(
          text: widget.release.lunaProtocol,
          style: TextStyle(
            color: widget.release.lunaProtocolColor,
            fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
          ),
        ),
        TextSpan(text: ArrPilotUI.TEXT_BULLET.pad()),
        TextSpan(text: widget.release.lunaIndexer),
        TextSpan(text: ArrPilotUI.TEXT_BULLET.pad()),
        TextSpan(text: widget.release.lunaAge),
      ],
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      children: [
        TextSpan(text: widget.release.lunaQuality),
        TextSpan(text: ArrPilotUI.TEXT_BULLET.pad()),
        TextSpan(text: widget.release.lunaSize),
      ],
    );
  }

  List<ArrPilotHighlightedNode> _highlightedNodes() {
    return [
      ArrPilotHighlightedNode(
        text: widget.release.protocol!.readable!,
        backgroundColor: widget.release.lunaProtocolColor,
      ),
      if (widget.release.lunaCustomFormatScore(nullOnEmpty: true) != null)
        ArrPilotHighlightedNode(
          text: widget.release.lunaCustomFormatScore()!,
          backgroundColor: ArrPilotColours.purple,
        ),
      ...widget.release.customFormats!.map<ArrPilotHighlightedNode>((custom) =>
          ArrPilotHighlightedNode(
              text: custom.name!, backgroundColor: ArrPilotColours.blueGrey)),
    ];
  }

  List<ArrPilotTableContent> _tableContent() {
    return [
      ArrPilotTableContent(title: 'age', body: widget.release.lunaAge),
      ArrPilotTableContent(title: 'indexer', body: widget.release.lunaIndexer),
      ArrPilotTableContent(title: 'size', body: widget.release.lunaSize),
      ArrPilotTableContent(
          title: 'language',
          body: widget.release.languages
                  ?.map<String>(
                      (language) => language.name ?? ArrPilotUI.TEXT_EMDASH)
                  .join('\n') ??
              ArrPilotUI.TEXT_EMDASH),
      ArrPilotTableContent(title: 'quality', body: widget.release.lunaQuality),
      if (widget.release.seeders != null)
        ArrPilotTableContent(title: 'seeders', body: '${widget.release.seeders}'),
      if (widget.release.leechers != null)
        ArrPilotTableContent(title: 'leechers', body: '${widget.release.leechers}'),
    ];
  }

  List<ArrPilotButton> _tableButtons() {
    return [
      ArrPilotButton(
        type: ArrPilotButtonType.TEXT,
        text: 'Download',
        icon: Icons.download_rounded,
        onTap: _startDownload,
        loadingState: _downloadState,
      ),
      if (widget.release.infoUrl?.isNotEmpty ?? false)
        ArrPilotButton.text(
          text: 'Indexer',
          icon: Icons.info_outline_rounded,
          color: ArrPilotColours.blue,
          onTap: widget.release.infoUrl!.openLink,
        ),
      if (widget.release.rejected!)
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
    RadarrAPIHelper()
        .pushRelease(context: context, release: widget.release)
        .then((value) {
      if (mounted)
        setState(() => _downloadState =
            value ? ArrPilotLoadingState.INACTIVE : ArrPilotLoadingState.ERROR);
    });
  }

  Future<void> _showWarnings() async => await ArrPilotDialogs()
      .showRejections(context, widget.release.rejections ?? []);
}

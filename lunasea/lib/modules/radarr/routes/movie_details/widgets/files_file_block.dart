import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/string/string.dart';
import 'package:arrpilot/modules/radarr.dart';

class RadarrMovieDetailsFilesFileBlock extends StatefulWidget {
  final RadarrMovieFile file;

  const RadarrMovieDetailsFilesFileBlock({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMovieDetailsFilesFileBlock> {
  ArrPilotLoadingState _deleteFileState = ArrPilotLoadingState.INACTIVE;

  @override
  Widget build(BuildContext context) {
    return ArrPilotTableCard(
      content: [
        ArrPilotTableContent(
          title: 'relative path',
          body: widget.file.lunaRelativePath,
        ),
        ArrPilotTableContent(
          title: 'video',
          body: widget.file.mediaInfo?.lunaVideoCodec,
        ),
        ArrPilotTableContent(
          title: 'audio',
          body: [
            widget.file.mediaInfo?.lunaAudioCodec,
            if (widget.file.mediaInfo?.audioChannels != null)
              widget.file.mediaInfo?.audioChannels.toString(),
          ].join(ArrPilotUI.TEXT_BULLET.pad()),
        ),
        ArrPilotTableContent(
          title: 'size',
          body: widget.file.lunaSize,
        ),
        ArrPilotTableContent(
          title: 'languages',
          body: widget.file.lunaLanguage,
        ),
        ArrPilotTableContent(
          title: 'quality',
          body: widget.file.lunaQuality,
        ),
        ArrPilotTableContent(
          title: 'formats',
          body: widget.file.lunaCustomFormats,
        ),
        ArrPilotTableContent(
          title: 'added on',
          body: widget.file.lunaDateAdded,
        ),
      ],
      buttons: [
        if (widget.file.mediaInfo != null)
          ArrPilotButton.text(
            text: 'Media Info',
            icon: Icons.info_outline_rounded,
            onTap: () async => _viewMediaInfo(),
          ),
        ArrPilotButton(
          type: ArrPilotButtonType.TEXT,
          text: 'Delete',
          icon: Icons.delete_rounded,
          onTap: () async => _deleteFile(),
          color: ArrPilotColours.red,
          loadingState: _deleteFileState,
        ),
      ],
    );
  }

  Future<void> _deleteFile() async {
    setState(() => _deleteFileState = ArrPilotLoadingState.ACTIVE);
    bool result = await RadarrDialogs().deleteMovieFile(context);
    if (result) {
      bool execute = await RadarrAPIHelper()
          .deleteMovieFile(context: context, movieFile: widget.file);
      if (execute) context.read<RadarrMovieDetailsState>().fetchFiles(context);
    }
    setState(() => _deleteFileState = ArrPilotLoadingState.INACTIVE);
  }

  Future<void> _viewMediaInfo() async {
    ArrPilotBottomModalSheet().show(
      builder: (context) => ArrPilotListViewModal(
        children: [
          ArrPilotHeader(text: 'radarr.Video'.tr()),
          ArrPilotTableCard(
            content: [
              ArrPilotTableContent(
                title: 'radarr.BitDepth'.tr(),
                body: widget.file.mediaInfo?.lunaVideoBitDepth,
              ),
              ArrPilotTableContent(
                title: 'radarr.Codec'.tr(),
                body: widget.file.mediaInfo?.lunaVideoCodec,
              ),
              ArrPilotTableContent(
                title: 'radarr.DynamicRange'.tr(),
                body: widget.file.mediaInfo?.lunaVideoDynamicRange,
              ),
              ArrPilotTableContent(
                title: 'radarr.FPS'.tr(),
                body: widget.file.mediaInfo?.lunaVideoFps,
              ),
              ArrPilotTableContent(
                title: 'radarr.Resolution'.tr(),
                body: widget.file.mediaInfo?.lunaVideoResolution,
              ),
            ],
          ),
          ArrPilotHeader(text: 'radarr.Audio'.tr()),
          ArrPilotTableCard(
            content: [
              ArrPilotTableContent(
                title: 'radarr.Channels'.tr(),
                body: widget.file.mediaInfo?.lunaAudioChannels,
              ),
              ArrPilotTableContent(
                title: 'radarr.Codec'.tr(),
                body: widget.file.mediaInfo?.lunaAudioCodec,
              ),
              ArrPilotTableContent(
                title: 'radarr.Languages'.tr(),
                body: widget.file.mediaInfo?.lunaAudioLanguages,
              ),
              ArrPilotTableContent(
                title: 'radarr.Streams'.tr(),
                body: widget.file.mediaInfo?.lunaAudioStreamCount,
              ),
            ],
          ),
          ArrPilotHeader(text: 'radarr.Other'.tr()),
          ArrPilotTableCard(
            content: [
              ArrPilotTableContent(
                title: 'radarr.Runtime'.tr(),
                body: widget.file.mediaInfo?.lunaRunTime,
              ),
              ArrPilotTableContent(
                title: 'radarr.ScanType'.tr(),
                body: widget.file.mediaInfo?.lunaScanType,
              ),
              ArrPilotTableContent(
                title: 'radarr.Subtitles'.tr(),
                body: widget.file.mediaInfo?.lunaSubtitles,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

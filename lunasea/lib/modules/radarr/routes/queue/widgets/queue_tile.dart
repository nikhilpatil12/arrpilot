import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/int/bytes.dart';
import 'package:arrpilot/extensions/string/string.dart';
import 'package:arrpilot/modules/radarr.dart';
import 'package:arrpilot/router/routes/radarr.dart';

class RadarrQueueTile extends StatelessWidget {
  final RadarrQueueRecord record;
  final RadarrMovie? movie;

  const RadarrQueueTile({
    Key? key,
    required this.record,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<RadarrState>().movies,
      builder: (context, AsyncSnapshot<List<RadarrMovie>> snapshot) {
        RadarrMovie? movie;
        if (snapshot.hasData)
          movie = snapshot.data!.firstWhereOrNull(
            (element) => element.id == record.movieId,
          );
        return ArrPilotExpandableListTile(
          title: record.title!,
          collapsedSubtitles: [
            _subtitle1(),
            _subtitle2(),
          ],
          expandedHighlightedNodes: _highlightedNodes(),
          expandedTableContent: _tableContent(movie),
          expandedTableButtons: _tableButtons(context),
          collapsedTrailing: ArrPilotIconButton(
            icon: record.lunaStatusIcon,
            color: record.lunaStatusColor,
          ),
          onLongPress: () => RadarrRoutes.MOVIE.go(params: {
            'movie': record.movieId!.toString(),
          }),
        );
      },
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(text: record.lunaMovieTitle(movie!));
  }

  TextSpan _subtitle2() {
    return TextSpan(
      children: [
        TextSpan(
          text: record.lunaQuality,
          style: const TextStyle(
            color: ArrPilotColours.accent,
            fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
          ),
        ),
        TextSpan(text: ArrPilotUI.TEXT_BULLET.pad()),
        TextSpan(text: record.timeLeft ?? ArrPilotUI.TEXT_EMDASH),
      ],
    );
  }

  List<ArrPilotTableContent> _tableContent(RadarrMovie? movie) {
    if (movie == null) return [];
    return [
      ArrPilotTableContent(
          title: 'radarr.Movie'.tr(), body: record.lunaMovieTitle(movie)),
      ArrPilotTableContent(
          title: 'radarr.Languages'.tr(), body: record.lunaLanguage),
      ArrPilotTableContent(title: 'Client', body: record.lunaDownloadClient),
      ArrPilotTableContent(title: 'Indexer', body: record.lunaIndexer),
      ArrPilotTableContent(
          title: 'radarr.Size'.tr(), body: record.size!.toInt().asBytes()),
      ArrPilotTableContent(
          title: 'Time Left', body: record.timeLeft ?? ArrPilotUI.TEXT_EMDASH),
    ];
  }

  List<ArrPilotHighlightedNode> _highlightedNodes() {
    return [
      ArrPilotHighlightedNode(
        text: record.protocol?.readable ?? ArrPilotUI.TEXT_EMDASH,
        backgroundColor: ArrPilotColours.blue,
      ),
      ArrPilotHighlightedNode(
        text: record.lunaQuality,
        backgroundColor: ArrPilotColours.accent,
      ),
      if ((record.customFormats?.length ?? 0) != 0)
        for (int i = 0; i < record.customFormats!.length; i++)
          ArrPilotHighlightedNode(
            text: record.customFormats![i].name!,
            backgroundColor: ArrPilotColours.orange,
          ),
      ArrPilotHighlightedNode(
        text: '${record.lunaPercentageComplete}%',
        backgroundColor: ArrPilotColours.blueGrey,
      ),
      ArrPilotHighlightedNode(
        text: record.status?.readable ?? ArrPilotUI.TEXT_EMDASH,
        backgroundColor: ArrPilotColours.blueGrey,
      ),
    ];
  }

  List<ArrPilotButton> _tableButtons(BuildContext context) {
    return [
      if ((record.statusMessages ?? []).isNotEmpty)
        ArrPilotButton.text(
          icon: Icons.messenger_outline_rounded,
          color: ArrPilotColours.orange,
          text: 'Messages',
          onTap: () async {
            ArrPilotDialogs().showMessages(
              context,
              record.statusMessages!
                  .map<String>((status) => status.messages!.join('\n'))
                  .toList(),
            );
          },
        ),
      if (record.status == RadarrQueueRecordStatus.COMPLETED &&
          record.trackedDownloadStatus == RadarrTrackedDownloadStatus.WARNING &&
          (record.outputPath ?? '').isNotEmpty)
        ArrPilotButton.text(
          icon: Icons.download_done_rounded,
          text: 'radarr.Import'.tr(),
          onTap: () => RadarrRoutes.MANUAL_IMPORT_DETAILS.go(queryParams: {
            'path': record.outputPath!,
          }),
        ),
      ArrPilotButton.text(
        icon: Icons.delete_rounded,
        color: ArrPilotColours.red,
        text: 'Remove',
        onTap: () async {
          if (context.read<RadarrState>().enabled) {
            bool result = await RadarrDialogs().confirmDeleteQueue(context);
            if (result) {
              await context
                  .read<RadarrState>()
                  .api!
                  .queue
                  .delete(
                    id: record.id!,
                    blacklist: RadarrDatabase.QUEUE_BLACKLIST.read(),
                    removeFromClient:
                        RadarrDatabase.QUEUE_REMOVE_FROM_CLIENT.read(),
                  )
                  .then((_) {
                showLunaSuccessSnackBar(
                  title: 'Removed From Queue',
                  message: record.title,
                );
                context
                    .read<RadarrState>()
                    .api!
                    .command
                    .refreshMonitoredDownloads()
                    .then((_) => context.read<RadarrState>().fetchQueue());
              }).catchError((error, stack) {
                ArrPilotLogger().error(
                    'Failed to remove queue record: ${record.id}',
                    error,
                    stack);
                showLunaErrorSnackBar(
                  title: 'Failed to Remove',
                  error: error,
                );
              });
            }
          }
        },
      ),
    ];
  }
}

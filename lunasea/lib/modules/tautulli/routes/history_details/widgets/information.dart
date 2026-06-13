import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/datetime.dart';
import 'package:arrpilot/extensions/duration/timestamp.dart';
import 'package:arrpilot/modules/tautulli.dart';

class TautulliHistoryDetailsInformation extends StatelessWidget {
  final TautulliHistoryRecord history;
  final ScrollController scrollController;

  const TautulliHistoryDetailsInformation({
    Key? key,
    required this.history,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotListView(
      controller: scrollController,
      children: [
        const ArrPilotHeader(text: 'Metadata'),
        _metadataBlock(),
        const ArrPilotHeader(text: 'Session'),
        _sessionBlock(),
        const ArrPilotHeader(text: 'Player'),
        _playerBlock(),
      ],
    );
  }

  Widget _metadataBlock() {
    return ArrPilotTableCard(
      content: [
        ArrPilotTableContent(title: 'status', body: history.lsStatus),
        ArrPilotTableContent(title: 'title', body: history.lsFullTitle),
        if (history.year != null)
          ArrPilotTableContent(title: 'year', body: history.year.toString()),
        ArrPilotTableContent(title: 'user', body: history.friendlyName),
      ],
    );
  }

  Widget _sessionBlock() {
    return ArrPilotTableCard(
      content: [
        ArrPilotTableContent(title: 'state', body: history.lsState),
        ArrPilotTableContent(
            title: 'date',
            body: DateFormat('yyyy-MM-dd').format(history.date!)),
        ArrPilotTableContent(title: 'started', body: history.date!.asTimeOnly()),
        ArrPilotTableContent(
            title: 'stopped',
            body: history.state == null
                ? history.stopped!.asTimeOnly()
                : ArrPilotUI.TEXT_EMDASH),
        ArrPilotTableContent(
            title: 'paused', body: history.pausedCounter!.asWordsTimestamp()),
      ],
    );
  }

  Widget _playerBlock() {
    return ArrPilotTableCard(
      content: [
        ArrPilotTableContent(title: 'location', body: history.ipAddress),
        ArrPilotTableContent(title: 'platform', body: history.platform),
        ArrPilotTableContent(title: 'product', body: history.product),
        ArrPilotTableContent(title: 'player', body: history.player),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/database/models/indexer.dart';
import 'package:arrpilot/modules/search.dart';
import 'package:arrpilot/router/routes/search.dart';

class SearchIndexerTile extends StatelessWidget {
  final ArrPilotIndexer? indexer;

  const SearchIndexerTile({
    Key? key,
    required this.indexer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      title: indexer!.displayName,
      body: [TextSpan(text: indexer!.host)],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () async {
        context.read<SearchState>().indexer = indexer!;
        SearchRoutes.CATEGORIES.go();
      },
    );
  }
}

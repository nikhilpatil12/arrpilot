import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/tautulli.dart';

class SearchRoute extends StatefulWidget {
  const SearchRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchRoute> createState() => _State();
}

class _State extends State<SearchRoute> with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) => ArrPilotScaffold(
        scaffoldKey: _scaffoldKey,
        module: ArrPilotModule.TAUTULLI,
        appBar: TautulliSearchAppBar(scrollController: scrollController)
            as PreferredSizeWidget?,
        body: TautulliSearchSearchResults(scrollController: scrollController),
      );
}

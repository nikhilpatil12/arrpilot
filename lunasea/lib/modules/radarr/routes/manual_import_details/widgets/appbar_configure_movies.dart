import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/radarr.dart';

class RadarrManualImportDetailsConfigureMoviesSearchBar extends StatefulWidget
    implements PreferredSizeWidget {
  const RadarrManualImportDetailsConfigureMoviesSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize =>
      const Size.fromHeight(ArrPilotTextInputBar.defaultAppBarHeight);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrManualImportDetailsConfigureMoviesSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) =>
      Consumer<RadarrManualImportDetailsTileState>(
        builder: (context, state, _) => SizedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ArrPilotTextInputBar(
                  controller: _controller,
                  autofocus: false,
                  onChanged: (value) => context
                      .read<RadarrManualImportDetailsTileState>()
                      .configureMoviesSearchQuery = value,
                  margin: ArrPilotTextInputBar.appBarMargin,
                ),
              ),
            ],
          ),
          height: ArrPilotTextInputBar.defaultAppBarHeight,
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/lidarr.dart';

class LidarrReleasesSearchBar extends StatefulWidget
    implements PreferredSizeWidget {
  final ScrollController scrollController;

  const LidarrReleasesSearchBar({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  Size get preferredSize =>
      const Size.fromHeight(ArrPilotTextInputBar.defaultAppBarHeight);

  @override
  State<LidarrReleasesSearchBar> createState() => _State();
}

class _State extends State<LidarrReleasesSearchBar> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Consumer<LidarrState>(
              builder: (context, state, _) => ArrPilotTextInputBar(
                controller: _controller,
                scrollController: widget.scrollController,
                autofocus: false,
                onChanged: (value) =>
                    context.read<LidarrState>().searchReleasesFilter = value,
                margin: ArrPilotTextInputBar.appBarMargin,
              ),
            ),
          ),
          LidarrReleasesHideButton(controller: widget.scrollController),
          LidarrReleasesSortButton(controller: widget.scrollController),
        ],
      ),
      height: ArrPilotTextInputBar.defaultAppBarHeight,
    );
  }
}

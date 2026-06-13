import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/lidarr.dart';

class LidarrCatalogueSearchBar extends StatefulWidget
    implements PreferredSizeWidget {
  final ScrollController scrollController;

  const LidarrCatalogueSearchBar({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  Size get preferredSize =>
      const Size.fromHeight(ArrPilotTextInputBar.defaultAppBarHeight);

  @override
  State<LidarrCatalogueSearchBar> createState() => _State();
}

class _State extends State<LidarrCatalogueSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = context.read<LidarrState>().searchCatalogueFilter;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Expanded(
            child: Consumer<LidarrState>(
              builder: (context, state, _) => ArrPilotTextInputBar(
                controller: _controller,
                scrollController: widget.scrollController,
                autofocus: false,
                onChanged: (value) =>
                    context.read<LidarrState>().searchCatalogueFilter = value,
                margin: EdgeInsets.zero,
              ),
            ),
          ),
          LidarrCatalogueHideButton(controller: widget.scrollController),
          LidarrCatalogueSortButton(controller: widget.scrollController),
        ],
      ),
      height: ArrPilotTextInputBar.defaultAppBarHeight,
    );
  }
}

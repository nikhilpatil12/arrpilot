import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/tautulli.dart';

// ignore: non_constant_identifier_names
Widget TautulliSearchAppBar({
  required ScrollController scrollController,
}) =>
    ArrPilotAppBar(
      title: 'Search',
      scrollControllers: [scrollController],
      bottom: _SearchBar(scrollController: scrollController),
    );

class _SearchBar extends StatefulWidget implements PreferredSizeWidget {
  final ScrollController scrollController;

  const _SearchBar({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  Size get preferredSize =>
      const Size.fromHeight(ArrPilotTextInputBar.defaultAppBarHeight);

  @override
  State<_SearchBar> createState() => _State();
}

class _State extends State<_SearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = context.read<TautulliState>().searchQuery;
  }

  @override
  Widget build(BuildContext context) => Consumer<TautulliState>(
        builder: (context, state, _) => SizedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ArrPilotTextInputBar(
                  controller: _controller,
                  scrollController: widget.scrollController,
                  autofocus: state.searchQuery.isEmpty,
                  onChanged: (value) =>
                      context.read<TautulliState>().searchQuery = value,
                  onSubmitted: (value) {
                    if (value.isNotEmpty)
                      context.read<TautulliState>().fetchSearch();
                  },
                  margin: ArrPilotTextInputBar.appBarMargin,
                ),
              ),
            ],
          ),
          height: ArrPilotTextInputBar.defaultAppBarHeight,
        ),
      );
}

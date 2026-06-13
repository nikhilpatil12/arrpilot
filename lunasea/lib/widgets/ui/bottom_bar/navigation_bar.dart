import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arrpilot/core.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:arrpilot/extensions/page_controller.dart';
import 'package:arrpilot/extensions/scroll_controller.dart';

class ArrPilotBottomNavigationBar extends StatefulWidget {
  final PageController? pageController;
  final List<IconData> icons;
  final List<String> titles;
  final List<ScrollController>? scrollControllers;
  final List<Widget>? topActions;
  final ValueChanged<int>? onTabChange;
  final List<Widget?>? leadingOnTab;

  ArrPilotBottomNavigationBar({
    Key? key,
    required this.pageController,
    required this.icons,
    required this.titles,
    this.topActions,
    this.onTabChange,
    this.leadingOnTab,
    this.scrollControllers,
  }) : super(key: key) {
    assert(
      icons.length == titles.length,
      'An unequal amount of titles and icons were passed to ArrPilotNavigationBar.',
    );
    if (leadingOnTab != null) {
      assert(
        icons.length == leadingOnTab!.length,
        'An unequal amount of icons and leadingOnTab were passed to ArrPilotNavigationBar.',
      );
    }
    if (scrollControllers != null) {
      assert(
        icons.length == scrollControllers!.length,
        'An unequal amount of icons and scrollControllers were passed to ArrPilotNavigationBar.',
      );
    }
  }

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ArrPilotBottomNavigationBar> {
  late int _index;

  @override
  void initState() {
    _index = widget.pageController?.initialPage ?? 0;
    widget.pageController?.addListener(_pageControllerListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.pageController?.removeListener(_pageControllerListener);
    super.dispose();
  }

  void _pageControllerListener() {
    if ((widget.pageController!.page?.round() ?? _index) == _index) return;
    setState(() => _index = widget.pageController!.page!.round());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.topActions?.isNotEmpty ?? false) _actionBar,
        _navigationBar,
      ],
    );
  }

  Widget get _actionBar {
    return ArrPilotBottomActionBar(
      actions: widget.topActions,
      useSafeArea: false,
      padding: ArrPilotUI.MARGIN_HALF,
    );
  }

  Widget get _navigationBar {
    return Container(
      child: SafeArea(
        child: Padding(
          child: GNav(
            gap: ArrPilotUI.MARGIN_SIZE_HALF,
            duration: const Duration(milliseconds: ArrPilotUI.ANIMATION_SPEED),
            tabBackgroundColor: Theme.of(context).canvasColor.dimmed(),
            activeColor: ArrPilotColours.accent,
            tabs: List.generate(
                widget.icons.length,
                (index) => GButton(
                      icon: widget.icons[index],
                      text: widget.titles[index],
                      active: _index == index,
                      iconSize: ArrPilotUI.ICON_SIZE,
                      haptic: true,
                      padding: const EdgeInsets.all(10.0).add(EdgeInsets.only(
                        left: _index == index ? ArrPilotUI.MARGIN_SIZE_HALF : 0.0,
                      )),
                      iconColor: Colors.white,
                      textStyle: const TextStyle(
                        fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
                        fontSize: ArrPilotUI.FONT_SIZE_H3,
                        color: Colors.white,
                      ),
                      iconActiveColor: ArrPilotColours.accent,
                      leading: widget.leadingOnTab == null
                          ? null
                          : widget.leadingOnTab![index],
                    )).toList(),
            tabActiveBorder: ArrPilotUI.shouldUseBorder
                ? Border.all(color: ArrPilotColours.white10)
                : null,
            tabBorder: ArrPilotUI.shouldUseBorder
                ? Border.all(color: Colors.transparent)
                : null,
            selectedIndex: _index,
            onTabChange: _onDestinationSelected,
          ),
          padding: (widget.topActions?.isNotEmpty ?? false)
              ? ArrPilotUI.MARGIN_DEFAULT.copyWith(top: 0.0)
              : ArrPilotUI.MARGIN_DEFAULT,
        ),
        top: false,
      ),
      color: Theme.of(context).primaryColor,
    );
  }

  void _onDestinationSelected(int idx) {
    HapticFeedback.mediumImpact();
    if (idx == _index && widget.scrollControllers != null) {
      widget.scrollControllers![idx].animateToStart();
    } else if (widget.pageController != null) {
      widget.pageController!.protectedJumpToPage(idx);
    }
    if (widget.onTabChange != null) widget.onTabChange!(idx);
    setState(() => _index = idx);
  }
}

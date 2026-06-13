import 'package:flutter/material.dart';
import 'package:arrpilot/database/tables/lunasea.dart';
import 'package:arrpilot/modules.dart';
import 'package:arrpilot/system/platform.dart';

class ArrPilotScaffold extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ArrPilotModule? module;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool extendBody;
  final bool extendBodyBehindAppBar;

  /// Called when [ArrPilotDatabase.ENABLED_PROFILE] has changed. Triggered within the build function.
  final void Function(BuildContext)? onProfileChange;

  // ignore: use_key_in_widget_constructors
  const ArrPilotScaffold({
    required this.scaffoldKey,
    this.module,
    this.appBar,
    this.body,
    this.drawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.onProfileChange,
  });

  @override
  Widget build(BuildContext context) {
    if (ArrPilotPlatform.isAndroid) return android;
    return scaffold;
  }

  Widget get android {
    return WillPopScope(
      onWillPop: () async {
        if (!ArrPilotDatabase.ANDROID_BACK_OPENS_DRAWER.read()) return true;

        final state = scaffoldKey.currentState;
        if (state?.hasDrawer ?? false) {
          if (state!.isDrawerOpen) return true;
          state.openDrawer();
          return false;
        }
        return true;
      },
      child: scaffold,
    );
  }

  Widget get scaffold {
    return ArrPilotDatabase.ENABLED_PROFILE.listenableBuilder(
      builder: (context, _) {
        onProfileChange?.call(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: appBar,
          body: body,
          drawer: drawer,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          onDrawerChanged: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        );
      },
    );
  }
}

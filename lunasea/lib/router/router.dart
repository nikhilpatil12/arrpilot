import 'package:flutter/material.dart';

import 'package:arrpilot/system/logger.dart';
import 'package:arrpilot/widgets/pages/error_route.dart';
import 'package:arrpilot/router/routes.dart';
import 'package:arrpilot/vendor.dart';

class ArrPilotRouter {
  static late GoRouter router;
  static GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  void initialize() {
    router = GoRouter(
      navigatorKey: navigator,
      errorBuilder: (_, state) => ErrorRoutePage(exception: state.error),
      initialLocation: ArrPilotRoutes.initialLocation,
      routes: ArrPilotRoutes.values.map((r) => r.root.routes).toList(),
    );
  }

  void popSafely() {
    if (router.canPop()) router.pop();
  }

  void popToRootRoute() {
    if (navigator.currentState == null) {
      ArrPilotLogger().warning('Not observing any navigation navigators, skipping');
      return;
    }
    navigator.currentState!.popUntil((route) => route.isFirst);
  }
}

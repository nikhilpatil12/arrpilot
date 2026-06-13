import 'package:flutter/material.dart';
import 'package:arrpilot/modules.dart';
import 'package:arrpilot/modules/nzbget/routes/nzbget.dart';
import 'package:arrpilot/modules/nzbget/routes/statistics.dart';
import 'package:arrpilot/router/routes.dart';
import 'package:arrpilot/vendor.dart';

enum NZBGetRoutes with ArrPilotRoutesMixin {
  HOME('/nzbget'),
  STATISTICS('statistics');

  @override
  final String path;

  const NZBGetRoutes(this.path);

  @override
  ArrPilotModule get module => ArrPilotModule.NZBGET;

  @override
  bool isModuleEnabled(BuildContext context) => true;

  @override
  GoRoute get routes {
    switch (this) {
      case NZBGetRoutes.HOME:
        return route(widget: const NZBGetRoute());
      case NZBGetRoutes.STATISTICS:
        return route(widget: const StatisticsRoute());
    }
  }

  @override
  List<GoRoute> get subroutes {
    switch (this) {
      case NZBGetRoutes.HOME:
        return [
          NZBGetRoutes.STATISTICS.routes,
        ];
      default:
        return const [];
    }
  }
}

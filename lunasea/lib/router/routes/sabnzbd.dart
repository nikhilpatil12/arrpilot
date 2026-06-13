import 'package:flutter/material.dart';
import 'package:arrpilot/modules.dart';
import 'package:arrpilot/modules/sabnzbd/core/api/data/history.dart';
import 'package:arrpilot/modules/sabnzbd/routes/history_stages.dart';
import 'package:arrpilot/modules/sabnzbd/routes/sabnzbd.dart';
import 'package:arrpilot/modules/sabnzbd/routes/statistics.dart';
import 'package:arrpilot/router/routes.dart';
import 'package:arrpilot/vendor.dart';

enum SABnzbdRoutes with ArrPilotRoutesMixin {
  HOME('/sabnzbd'),
  STATISTICS('statistics'),
  HISTORY_STAGES('history/stages');

  @override
  final String path;

  const SABnzbdRoutes(this.path);

  @override
  ArrPilotModule get module => ArrPilotModule.SABNZBD;

  @override
  bool isModuleEnabled(BuildContext context) => true;

  @override
  GoRoute get routes {
    switch (this) {
      case SABnzbdRoutes.HOME:
        return route(widget: const SABnzbdRoute());
      case SABnzbdRoutes.STATISTICS:
        return route(widget: const StatisticsRoute());
      case SABnzbdRoutes.HISTORY_STAGES:
        return route(builder: (_, state) {
          final history = state.extra as SABnzbdHistoryData?;
          return HistoryStagesRoute(history: history);
        });
    }
  }

  @override
  List<GoRoute> get subroutes {
    switch (this) {
      case SABnzbdRoutes.HOME:
        return [
          SABnzbdRoutes.STATISTICS.routes,
          SABnzbdRoutes.HISTORY_STAGES.routes,
        ];
      default:
        return const [];
    }
  }
}

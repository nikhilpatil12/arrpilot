import 'package:flutter/material.dart';
import 'package:arrpilot/modules.dart';
import 'package:arrpilot/modules/external_modules/routes/external_modules/route.dart';
import 'package:arrpilot/router/routes.dart';
import 'package:arrpilot/vendor.dart';

enum ExternalModulesRoutes with ArrPilotRoutesMixin {
  HOME('/external_modules');

  @override
  final String path;

  const ExternalModulesRoutes(this.path);

  @override
  ArrPilotModule get module => ArrPilotModule.EXTERNAL_MODULES;

  @override
  bool isModuleEnabled(BuildContext context) => true;

  @override
  GoRoute get routes {
    switch (this) {
      case ExternalModulesRoutes.HOME:
        return route(widget: const ExternalModulesRoute());
    }
  }
}

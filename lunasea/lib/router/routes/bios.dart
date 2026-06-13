import 'package:flutter/material.dart';
import 'package:arrpilot/database/tables/bios.dart';
import 'package:arrpilot/modules.dart';
import 'package:arrpilot/router/routes.dart';
import 'package:arrpilot/router/routes/dashboard.dart';
import 'package:arrpilot/system/bios.dart';
import 'package:arrpilot/vendor.dart';

enum BIOSRoutes with LunaRoutesMixin {
  HOME('/');

  @override
  final String path;

  const BIOSRoutes(this.path);

  @override
  LunaModule? get module => null;

  @override
  bool isModuleEnabled(BuildContext context) => true;

  @override
  GoRoute get routes {
    switch (this) {
      case BIOSRoutes.HOME:
        return redirect(redirect: (context, _) {
          LunaOS().boot(context);

          final fallback = DashboardRoutes.HOME.path;
          return BIOSDatabase.BOOT_MODULE.read().homeRoute ?? fallback;
        });
    }
  }
}

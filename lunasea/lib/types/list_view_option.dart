import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';

part 'list_view_option.g.dart';

const _BLOCK_VIEW = 'BLOCK_VIEW';
const _GRID_VIEW = 'GRID_VIEW';

@HiveType(typeId: 29, adapterName: 'ArrPilotListViewOptionAdapter')
enum ArrPilotListViewOption {
  @HiveField(0)
  BLOCK_VIEW(_BLOCK_VIEW),
  @HiveField(1)
  GRID_VIEW(_GRID_VIEW);

  final String key;
  const ArrPilotListViewOption(this.key);

  static ArrPilotListViewOption? fromKey(String? key) {
    switch (key) {
      case _BLOCK_VIEW:
        return ArrPilotListViewOption.BLOCK_VIEW;
      case _GRID_VIEW:
        return ArrPilotListViewOption.GRID_VIEW;
    }
    return null;
  }
}

extension ArrPilotListViewOptionExtension on ArrPilotListViewOption {
  String get readable {
    switch (this) {
      case ArrPilotListViewOption.BLOCK_VIEW:
        return 'lunasea.BlockView'.tr();
      case ArrPilotListViewOption.GRID_VIEW:
        return 'lunasea.GridView'.tr();
    }
  }

  IconData get icon {
    switch (this) {
      case ArrPilotListViewOption.BLOCK_VIEW:
        return Icons.view_list_rounded;
      case ArrPilotListViewOption.GRID_VIEW:
        return Icons.grid_view_rounded;
    }
  }
}

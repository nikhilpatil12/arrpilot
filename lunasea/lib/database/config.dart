import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/database/database.dart';
import 'package:arrpilot/database/models/external_module.dart';
import 'package:arrpilot/database/models/indexer.dart';
import 'package:arrpilot/database/table.dart';

class ArrPilotConfig {
  Future<void> import(BuildContext context, String data) async {
    await ArrPilotDatabaseService().clear();

    try {
      Map<String, dynamic> config = json.decode(data);

      _setProfiles(config[ArrPilotBox.profiles.key]);
      _setIndexers(config[ArrPilotBox.indexers.key]);
      _setExternalModules(config[ArrPilotBox.externalModules.key]);
      for (final table in ArrPilotTable.values) table.import(config[table.key]);

      if (!ArrPilotProfile.list
          .contains(ArrPilotDatabase.ENABLED_PROFILE.read())) {
        ArrPilotDatabase.ENABLED_PROFILE.update(ArrPilotProfile.list[0]);
      }
    } catch (error, stack) {
      await ArrPilotDatabaseService().bootstrap();
      ArrPilotLogger().error(
        'Failed to import configuration, resetting to default',
        error,
        stack,
      );
    }

    ArrPilotState.reset(context);
  }

  String export() {
    Map<String, dynamic> config = {};
    config[ArrPilotBox.externalModules.key] =
        ArrPilotBox.externalModules.export();
    config[ArrPilotBox.indexers.key] = ArrPilotBox.indexers.export();
    config[ArrPilotBox.profiles.key] = ArrPilotBox.profiles.export();
    for (final table in ArrPilotTable.values)
      config[table.key] = table.export();

    return json.encode(config);
  }

  void _setProfiles(List? data) {
    if (data == null) return;

    for (final item in data) {
      final content = (item as Map).cast<String, dynamic>();
      final key = content['key'] ?? 'default';
      final obj = ArrPilotProfile.fromJson(content);
      ArrPilotBox.profiles.update(key, obj);
    }
  }

  void _setIndexers(List? data) {
    if (data == null) return;

    for (final indexer in data) {
      final obj = ArrPilotIndexer.fromJson(indexer);
      ArrPilotBox.indexers.create(obj);
    }
  }

  void _setExternalModules(List? data) {
    if (data == null) return;

    for (final module in data) {
      final obj = ArrPilotExternalModule.fromJson(module);
      ArrPilotBox.externalModules.create(obj);
    }
  }
}

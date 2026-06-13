import 'package:arrpilot/database/table.dart';
import 'package:arrpilot/modules.dart';

enum BIOSDatabase<T> with ArrPilotTableMixin<T> {
  BOOT_MODULE<ArrPilotModule>(ArrPilotModule.DASHBOARD),
  FIRST_BOOT<bool>(true);

  @override
  ArrPilotTable get table => ArrPilotTable.bios;

  @override
  final T fallback;

  const BIOSDatabase(this.fallback);

  @override
  dynamic export() {
    BIOSDatabase db = this;
    switch (db) {
      case BIOSDatabase.BOOT_MODULE:
        return BIOSDatabase.BOOT_MODULE.read().key;
      default:
        return super.export();
    }
  }

  @override
  void import(dynamic value) {
    BIOSDatabase db = this;
    dynamic result;

    switch (db) {
      case BIOSDatabase.BOOT_MODULE:
        result = ArrPilotModule.fromKey(value.toString());
        break;
      default:
        result = value;
        break;
    }

    return super.import(result);
  }
}

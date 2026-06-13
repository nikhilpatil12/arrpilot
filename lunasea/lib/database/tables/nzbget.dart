import 'package:arrpilot/database/table.dart';

enum NZBGetDatabase<T> with ArrPilotTableMixin<T> {
  NAVIGATION_INDEX<int>(0);

  @override
  ArrPilotTable get table => ArrPilotTable.nzbget;

  @override
  final T fallback;

  const NZBGetDatabase(this.fallback);
}

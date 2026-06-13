import 'package:arrpilot/database/table.dart';

enum SABnzbdDatabase<T> with ArrPilotTableMixin<T> {
  NAVIGATION_INDEX<int>(0);

  @override
  ArrPilotTable get table => ArrPilotTable.sabnzbd;

  @override
  final T fallback;

  const SABnzbdDatabase(this.fallback);
}

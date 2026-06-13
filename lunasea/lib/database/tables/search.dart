import 'package:arrpilot/database/table.dart';

enum SearchDatabase<T> with ArrPilotTableMixin<T> {
  HIDE_XXX<bool>(false),
  SHOW_LINKS<bool>(true);

  @override
  ArrPilotTable get table => ArrPilotTable.search;

  @override
  final T fallback;

  const SearchDatabase(this.fallback);
}

import 'package:arrpilot/types/log_type.dart';

abstract class ArrPilotException implements Exception {
  ArrPilotLogType get type;
}

mixin WarningExceptionMixin implements ArrPilotException {
  @override
  ArrPilotLogType get type => ArrPilotLogType.WARNING;
}

mixin ErrorExceptionMixin implements ArrPilotException {
  @override
  ArrPilotLogType get type => ArrPilotLogType.ERROR;
}

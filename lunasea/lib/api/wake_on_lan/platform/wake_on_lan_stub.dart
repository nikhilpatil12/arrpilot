import 'package:arrpilot/api/wake_on_lan/wake_on_lan.dart';

bool isPlatformSupported() => false;
ArrPilotWakeOnLAN getWakeOnLAN() =>
    throw UnsupportedError('ArrPilotWakeOnLAN unsupported');

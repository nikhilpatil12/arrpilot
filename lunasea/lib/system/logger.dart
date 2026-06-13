import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:arrpilot/core.dart';
import 'package:arrpilot/database/models/log.dart';
import 'package:arrpilot/types/exception.dart';
import 'package:arrpilot/types/log_type.dart';

class ArrPilotLogger {
  static String get checkLogsMessage => 'arrpilot.CheckLogsMessage'.tr();

  void initialize() {
    FlutterError.onError = (details) async {
      if (kDebugMode) FlutterError.dumpErrorToConsole(details);
      Zone.current.handleUncaughtError(
        details.exception,
        details.stack ?? StackTrace.current,
      );
    };
    _compact();
  }

  Future<void> _compact([int count = 50]) async {
    if (ArrPilotBox.logs.data.length <= count) return;
    List<ArrPilotLog> logs = ArrPilotBox.logs.data.toList();
    logs.sort((a, b) => (b.timestamp).compareTo(a.timestamp));
    logs.skip(count).forEach((log) => log.delete());
  }

  Future<String> export() async {
    final logs = ArrPilotBox.logs.data.map((log) => log.toJson()).toList();
    final encoder = JsonEncoder.withIndent(' '.repeat(4));
    return encoder.convert(logs);
  }

  Future<void> clear() async => ArrPilotBox.logs.clear();

  void debug(String message) {
    ArrPilotLog log = ArrPilotLog.withMessage(
      type: ArrPilotLogType.DEBUG,
      message: message,
    );
    ArrPilotBox.logs.create(log);
  }

  void warning(String message, [String? className, String? methodName]) {
    ArrPilotLog log = ArrPilotLog.withMessage(
      type: ArrPilotLogType.WARNING,
      message: message,
      className: className,
      methodName: methodName,
    );
    ArrPilotBox.logs.create(log);
  }

  void error(String message, dynamic error, StackTrace? stackTrace) {
    if (kDebugMode) {
      print(message);
      print(error);
      print(stackTrace);
    }

    if (error is! NetworkImageLoadException) {
      ArrPilotLog log = ArrPilotLog.withError(
        type: ArrPilotLogType.ERROR,
        message: message,
        error: error,
        stackTrace: stackTrace,
      );
      ArrPilotBox.logs.create(log);
    }
  }

  void critical(dynamic error, StackTrace stackTrace) {
    if (kDebugMode) {
      print(error);
      print(stackTrace);
    }

    if (error is! NetworkImageLoadException) {
      ArrPilotLog log = ArrPilotLog.withError(
        type: ArrPilotLogType.CRITICAL,
        message: error?.toString() ?? ArrPilotUI.TEXT_EMDASH,
        error: error,
        stackTrace: stackTrace,
      );
      ArrPilotBox.logs.create(log);
    }
  }

  void exception(ArrPilotException exception, [StackTrace? trace]) {
    switch (exception.type) {
      case ArrPilotLogType.WARNING:
        warning(exception.toString(), exception.runtimeType.toString());
        break;
      case ArrPilotLogType.ERROR:
        error(exception.toString(), exception, trace);
        break;
      default:
        break;
    }
  }
}

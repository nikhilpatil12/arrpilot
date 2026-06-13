import 'package:flutter/material.dart';
import 'package:arrpilot/system/filesystem/file.dart';

// ignore: always_use_package_imports
import 'platform/filesystem_stub.dart'
    if (dart.library.io) 'platform/filesystem_io.dart'
    if (dart.library.html) 'platform/filesystem_html.dart';

abstract class ArrPilotFileSystem {
  static bool get isSupported => isPlatformSupported();
  factory ArrPilotFileSystem() => getFileSystem();

  static bool isValidExtension(List<String> extensions, String? extension) {
    String _ext = extension ?? '';
    return extensions.contains(_ext);
  }

  Future<bool> save(BuildContext context, String name, List<int> data);
  Future<ArrPilotFile?> read(BuildContext context, List<String> extensions);
  Future<void> nuke();
}

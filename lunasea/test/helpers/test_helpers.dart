import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:arrpilot/database/table.dart';

/// Initialize Hive for testing
Future<void> initializeTestHive() async {
  final tempDir = await Directory.systemTemp.createTemp('hive_test_');
  Hive.init(tempDir.path);
  ArrPilotTable.register();
}

/// Clean up Hive after testing
Future<void> cleanupTestHive() async {
  await Hive.close();
  await Hive.deleteFromDisk();
}

/// Wrap a widget in MaterialApp for testing
Widget wrapInMaterialApp(Widget child) {
  return MaterialApp(
    home: Scaffold(
      body: child,
    ),
  );
}

/// Common test constants
class TestConstants {
  static const testApiKey = 'test-api-key-12345';
  static const testHost = 'http://localhost:8989';
  static const testProfileName = 'Test Profile';
}

/// Mock profile data
class MockData {
  static const profileJson = {
    'key': 'test-profile',
    'sonarr': {},
    'radarr': {},
    'lidarr': {},
    'nzbget': {},
    'sabnzbd': {},
    'tautulli': {},
  };
}

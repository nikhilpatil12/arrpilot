import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:arrpilot/database/database.dart';
import 'package:arrpilot/database/box.dart';
import 'package:arrpilot/database/table.dart';
import 'package:arrpilot/database/models/profile.dart';

void main() {
  late Directory tempDir;

  setUpAll(() async {
    // One-time setup: Initialize Hive and register adapters
    tempDir = await Directory.systemTemp.createTemp('hive_test_');
    Hive.init(tempDir.path);
    ArrPilotTable.register();
  });

  tearDownAll(() async {
    // One-time cleanup: Close Hive and delete temp directory
    await Hive.close();
    await tempDir.delete(recursive: true);
  });

  group('ArrPilotDatabaseService', () {
    setUp(() async {
      // Per-test setup: Open boxes and bootstrap for each test
      await ArrPilotBox.open();
      if (ArrPilotBox.profiles.isEmpty) {
        await ArrPilotDatabaseService().bootstrap();
      }
    });

    tearDown(() async {
      // Per-test cleanup: Close all boxes
      await Hive.close();
    });

    test('open creates default profile if none exists', () async {
      // Verify default profile was created during setup
      expect(ArrPilotBox.profiles.isEmpty, isFalse);
      expect(
        ArrPilotBox.profiles.contains(ArrPilotProfile.DEFAULT_PROFILE),
        isTrue,
      );

      // Verify boxes are open
      expect(Hive.isBoxOpen(ArrPilotBox.profiles.key), isTrue);
      expect(Hive.isBoxOpen(ArrPilotBox.arrpilot.key), isTrue);
    });

    test('bootstrap creates default profile', () async {
      final db = ArrPilotDatabaseService();
      await db.clear();

      // Verify all boxes are empty
      expect(ArrPilotBox.profiles.isEmpty, isTrue);

      // Bootstrap should create default profile
      await db.bootstrap();

      expect(ArrPilotBox.profiles.isEmpty, isFalse);
      expect(
        ArrPilotBox.profiles.contains(ArrPilotProfile.DEFAULT_PROFILE),
        isTrue,
      );
    });

    test('clear removes all data from boxes', () async {
      final db = ArrPilotDatabaseService();

      // Add some test data
      await ArrPilotBox.profiles.update('test', ArrPilotProfile());

      expect(ArrPilotBox.profiles.size, greaterThan(1));

      // Clear should remove all data
      await db.clear();

      expect(ArrPilotBox.profiles.isEmpty, isTrue);
    });

    test('deinitialize closes all boxes', () async {
      final db = ArrPilotDatabaseService();

      expect(Hive.isBoxOpen(ArrPilotBox.profiles.key), isTrue);

      // Deinitialize should close all boxes
      await db.deinitialize();

      expect(Hive.isBoxOpen(ArrPilotBox.profiles.key), isFalse);
    });
  });
}

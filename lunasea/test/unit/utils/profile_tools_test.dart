import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:arrpilot/database/models/profile.dart';
import 'package:arrpilot/database/box.dart';
import 'package:arrpilot/database/table.dart';

void main() {
  group('ArrPilotProfile', () {
    test('DEFAULT_PROFILE constant is "default"', () {
      expect(ArrPilotProfile.DEFAULT_PROFILE, equals('default'));
    });

    test('fromJson creates valid profile', () {
      final json = {
        'sonarr': {},
        'radarr': {},
        'lidarr': {},
        'nzbget': {},
        'sabnzbd': {},
        'tautulli': {},
      };

      final profile = ArrPilotProfile.fromJson(json);

      expect(profile, isNotNull);
      expect(profile, isA<ArrPilotProfile>());
    });

    test('toJson returns valid JSON', () {
      final profile = ArrPilotProfile();
      final json = profile.toJson();

      expect(json, isNotNull);
      expect(json, isA<Map<String, dynamic>>());
      expect(json.containsKey('sonarrEnabled'), isTrue);
      expect(json.containsKey('radarrEnabled'), isTrue);
    });
  });

  // Note: ArrPilotProfile.list is tested in database tests
  // since it requires Hive to be initialized and boxes to be open
}

# Testing Guide for ArrPilot

This document describes how to run and write tests for ArrPilot.

---

## Quick Start

### Run All Tests
```bash
flutter test
```

### Run Integration Tests
```bash
flutter test integration_test/
```

### Run Specific Test File
```bash
flutter test test/unit/database/database_test.dart
```

### Run Tests with Coverage
```bash
flutter test --coverage
```

View coverage report (macOS/Linux):
```bash
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

## Test Structure

```
lunasea/
├── test/
│   ├── unit/              # Unit tests
│   │   ├── database/      # Database operation tests
│   │   └── utils/         # Utility function tests
│   ├── widget/            # Widget tests (future)
│   └── helpers/           # Test utilities and mocks
│       └── test_helpers.dart
└── integration_test/      # Integration tests
    └── app_test.dart      # App launch and flow tests
```

---

## Current Test Coverage

### Unit Tests
- **Database Operations** (`test/unit/database/database_test.dart`)
  - Database initialization
  - Bootstrap (creates default profile)
  - Clear (removes all data)
  - Nuke (deletes boxes from disk)

- **Profile Utilities** (`test/unit/utils/profile_tools_test.dart`)
  - Profile creation from JSON
  - Profile serialization to JSON
  - Profile list retrieval

### Integration Tests
- **App Launch** (`integration_test/app_test.dart`)
  - App launches without crashing
  - Database initializes successfully

### Test Helpers
- **Common Utilities** (`test/helpers/test_helpers.dart`)
  - Hive initialization for testing
  - Widget wrappers for widget tests
  - Mock data constants

---

## Writing New Tests

### Unit Test Template

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:arrpilot/path/to/your/code.dart';

void main() {
  group('YourClassName', () {
    setUp(() {
      // Optional: Code to run before each test
    });

    tearDown(() {
      // Optional: Code to run after each test
    });

    test('describes what is being tested', () {
      // Arrange: Set up test data
      final input = 'test';

      // Act: Execute the code being tested
      final result = yourFunction(input);

      // Assert: Verify the result
      expect(result, equals('expected output'));
    });
  });
}
```

### Integration Test Template

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Feature Name', () {
    testWidgets('user can perform action', (tester) async {
      // Launch app or navigate to screen
      // ...

      // Wait for UI to settle
      await tester.pumpAndSettle();

      // Perform user actions
      await tester.tap(find.text('Button'));
      await tester.pumpAndSettle();

      // Verify results
      expect(find.text('Expected Result'), findsOneWidget);
    });
  });
}
```

---

## Testing Best Practices

### DO:
- ✅ Write tests for critical paths (database, API, state management)
- ✅ Use descriptive test names that explain what is being tested
- ✅ Follow Arrange-Act-Assert pattern
- ✅ Clean up resources in `tearDown()`
- ✅ Use test helpers to reduce duplication
- ✅ Mock external dependencies (HTTP, Firebase, etc.)

### DON'T:
- ❌ Test Flutter framework code (it's already tested)
- ❌ Write tests that depend on external services
- ❌ Write flaky tests that sometimes pass/fail
- ❌ Test implementation details (test behavior, not internals)
- ❌ Commit tests that are failing

---

## Mocking Dependencies

### Using Mockito

1. Add annotations to your test file:
```dart
import 'package:mockito/annotations.dart';
import 'package:arrpilot/api/sonarr/sonarr.dart';

@GenerateMocks([SonarrAPI])
void main() {
  // Your tests
}
```

2. Generate mocks:
```bash
flutter pub run build_runner build
```

3. Use mocks in tests:
```dart
test('fetches series from API', () async {
  final mockApi = MockSonarrAPI();
  when(mockApi.getSeries()).thenAnswer((_) async => []);

  final result = await mockApi.getSeries();
  expect(result, isEmpty);
});
```

---

## Debugging Tests

### Run Single Test
```bash
flutter test test/unit/database/database_test.dart --plain-name="initialize opens all boxes"
```

### Print Debug Information
```dart
test('my test', () {
  print('Debug info: $someVariable');
  debugPrint('More debug info');
  // ...
});
```

### Run with Verbose Output
```bash
flutter test --verbose
```

---

## CI/CD Integration

Tests run automatically in GitHub Actions on:
- Push to any branch
- Pull requests

Tests must pass before merging to main.

---

## Test Coverage Goals

**Current Coverage:** ~5-10% (initial setup)

**Short-term Goal:** 30% (critical paths)
**Long-term Goal:** 70% (production-ready)

### Priority Areas for Coverage:
1. Database operations (CRITICAL)
2. API clients (HIGH)
3. State management (HIGH)
4. Utilities (MEDIUM)
5. UI widgets (MEDIUM)
6. Integration flows (MEDIUM)

---

## Troubleshooting

### "Hive is already initialized"
Clean up Hive in `tearDown()`:
```dart
tearDown() async {
  await Hive.close();
  await Hive.deleteFromDisk();
}
```

### "Box is already open"
Close boxes before opening:
```dart
if (Hive.isBoxOpen('boxName')) {
  await Hive.box('boxName').close();
}
```

### Integration tests fail with timeout
Increase timeout:
```dart
testWidgets('my test', (tester) async {
  // ...
}, timeout: const Timeout(Duration(minutes: 2)));
```

---

## Resources

- [Flutter Testing Docs](https://docs.flutter.dev/testing)
- [Mockito Package](https://pub.dev/packages/mockito)
- [Integration Testing](https://docs.flutter.dev/testing/integration-tests)
- [Test Coverage](https://docs.flutter.dev/testing/overview#coverage)

---

**Last Updated:** 2026-06-14
**Test Framework:** Flutter Test (built-in)
**Mocking:** Mockito 5.4.4

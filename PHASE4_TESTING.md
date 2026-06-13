# Phase 4: Testing Infrastructure - Action Plan

**Status:** 🔴 **Not Started** (0% test coverage currently)
**Estimated Time:** 1-2 weeks (40-80 hours full implementation)
**Date Created:** 2026-06-14

---

## Current State

**Test Coverage:** 0%
- No `test/` directory exists
- No test files (0 `*_test.dart` files)
- No testing dependencies in pubspec.yaml
- No test infrastructure in backend services

**Analysis:**
- **1,346 Dart files** in codebase (~87k LOC)
- Achieving 70% coverage would require **500-800 tests**
- Critical for production readiness
- Currently blocks Phase 6 (Production Launch)

---

## Strategy: Pragmatic Testing Approach

### Full Implementation (40-80 hours)
Write comprehensive tests for all critical paths to achieve >70% coverage.

### **Recommended: Incremental Approach** (8-16 hours initial, ongoing)
Focus on **critical, high-value areas** first, expand coverage over time.

---

## Phase 4 Breakdown

### **Phase 4A: Test Infrastructure Setup** (2-4 hours)
**Priority:** HIGH
**Status:** 🔴 Not started

#### Tasks:
1. Add test dependencies to `pubspec.yaml`
2. Create `test/` directory structure
3. Create sample tests to establish patterns
4. Configure test running
5. Document testing guidelines

#### Deliverables:
- ✅ Test dependencies installed
- ✅ Directory structure created
- ✅ 3-5 example tests written
- ✅ `TESTING.md` documentation

---

### **Phase 4B: Critical Path Unit Tests** (6-12 hours)
**Priority:** HIGH
**Status:** 🔴 Not started

#### Focus Areas:

**1. Database Operations (Critical)**
- `lib/database/database.dart` - Database initialization/bootstrap
- `lib/database/config.dart` - Config import/export
- `lib/database/models/profile.dart` - Profile management
- **Why:** Data loss would be catastrophic for users

**2. API Controllers (High Value)**
- `lib/api/sonarr/` - Sonarr API client
- `lib/api/radarr/` - Radarr API client
- **Why:** Core functionality, user-facing errors

**3. Core Utilities (High Impact)**
- `lib/utils/profile_tools.dart` - Profile operations
- `lib/system/logger.dart` - Logging (if it breaks, debugging is impossible)
- **Why:** Used throughout the app

#### Example Tests to Write:
```dart
// test/unit/database/database_test.dart
test('bootstrap creates default profile')
test('nuke clears all data')
test('initialize opens all boxes')

// test/unit/database/config_test.dart
test('export generates valid JSON')
test('import restores configuration')
test('import handles invalid data gracefully')

// test/unit/api/sonarr/series_test.dart
test('getAll returns list of series')
test('getById returns single series')
test('add creates new series')
test('handles 404 errors')
test('handles network timeouts')
```

#### Estimated Tests: 30-50 tests

---

### **Phase 4C: Widget Tests** (4-8 hours)
**Priority:** MEDIUM
**Status:** 🔴 Not started

#### Focus Areas:

**1. Core UI Components**
- `lib/widgets/ui/scaffold.dart` - ArrPilotScaffold
- `lib/widgets/ui/appbar.dart` - ArrPilotAppBar
- `lib/widgets/ui/card.dart` - ArrPilotCard
- **Why:** Used everywhere, breakage affects all screens

**2. Critical Forms**
- Settings configuration forms
- Profile creation/editing
- **Why:** User data entry must work correctly

#### Example Tests:
```dart
// test/widget/ui/scaffold_test.dart
testWidgets('renders with appbar and body', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: ArrPilotScaffold(
        appBar: ArrPilotAppBar(title: 'Test'),
        body: Text('Body'),
      ),
    ),
  );

  expect(find.text('Test'), findsOneWidget);
  expect(find.text('Body'), findsOneWidget);
});
```

#### Estimated Tests: 15-25 tests

---

### **Phase 4D: Integration Tests** (2-4 hours)
**Priority:** MEDIUM
**Status:** 🔴 Not started

#### Critical User Flows:
1. App launches without crashing
2. User can create a new profile
3. User can add a module configuration
4. User can navigate between screens
5. User can import/export configuration

#### Example:
```dart
// integration_test/app_test.dart
testWidgets('user can create profile', (tester) async {
  app.main();
  await tester.pumpAndSettle();

  // Navigate to profiles
  await tester.tap(find.byIcon(Icons.settings));
  await tester.pumpAndSettle();

  // Create profile
  await tester.tap(find.text('Add Profile'));
  await tester.pumpAndSettle();

  await tester.enterText(find.byType(TextField), 'Test Profile');
  await tester.tap(find.text('Save'));
  await tester.pumpAndSettle();

  expect(find.text('Test Profile'), findsOneWidget);
});
```

#### Estimated Tests: 5-10 tests

---

### **Phase 4E: Backend Tests** (4-8 hours)
**Priority:** LOW (Can defer)
**Status:** 🔴 Not started

#### Cloud Functions:
```typescript
// lunasea-cloud-functions/functions/test/controllers/delete_user.test.ts
describe('deleteUserController', () => {
  it('deletes user data from Firestore', async () => {
    // Mock Firebase admin
    // Test delete logic
  });
});
```

#### Notification Service:
```typescript
// lunasea-notification-service/test/routes/sonarr.test.ts
describe('POST /v1/sonarr/:deviceId/:token', () => {
  it('sends FCM notification for Download event', async () => {
    // Mock FCM
    // Test webhook processing
  });
});
```

#### Estimated Tests: 10-20 tests

---

### **Phase 4F: CI/CD Integration** (2-4 hours)
**Priority:** LOW (Can defer)
**Status:** 🔴 Not started

#### Tasks:
1. Create `.github/workflows/test.yml`
2. Add test steps to existing build workflows
3. Set up code coverage reporting (Codecov)
4. Configure coverage thresholds

#### Example Workflow:
```yaml
name: Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test --coverage
      - run: flutter test integration_test/
      - uses: codecov/codecov-action@v3
        with:
          file: ./coverage/lcov.info
```

---

## Recommended Execution Plan

### **Minimal Viable Testing** (8 hours)
**Goal:** Basic safety net, unblock production launch

1. **Phase 4A:** Set up infrastructure (2 hours)
2. **Phase 4B (Partial):** Database + API tests (4 hours, ~20 tests)
3. **Phase 4D (Partial):** Smoke test integration (2 hours, 2-3 tests)

**Result:**
- Basic test structure in place
- Critical data operations tested
- App launch verified
- ~25-30 tests, ~20-30% coverage

---

### **Solid Foundation** (16 hours)
**Goal:** Good coverage of critical paths

1. **Phase 4A:** Set up infrastructure (2 hours)
2. **Phase 4B:** Full critical path testing (8 hours, 40-50 tests)
3. **Phase 4C (Partial):** Core widget tests (4 hours, 10-15 tests)
4. **Phase 4D:** Integration tests (2 hours, 5 tests)

**Result:**
- Comprehensive critical path coverage
- Key UI components tested
- User flows verified
- ~60-70 tests, ~40-50% coverage

---

### **Production-Ready** (40-80 hours)
**Goal:** Full Phase 4 implementation

1. **Phase 4A:** Infrastructure (4 hours)
2. **Phase 4B:** All unit tests (12 hours, 100+ tests)
3. **Phase 4C:** All widget tests (8 hours, 30+ tests)
4. **Phase 4D:** All integration tests (4 hours, 10 tests)
5. **Phase 4E:** Backend tests (8 hours, 20 tests)
6. **Phase 4F:** CI/CD integration (4 hours)

**Result:**
- >70% code coverage
- All critical paths tested
- Backend fully tested
- Automated testing in CI/CD
- ~200+ tests

---

## Directory Structure

```
lunasea/
├── test/
│   ├── unit/
│   │   ├── api/
│   │   │   ├── sonarr/
│   │   │   │   ├── series_test.dart
│   │   │   │   ├── episodes_test.dart
│   │   │   │   └── history_test.dart
│   │   │   └── radarr/
│   │   │       ├── movies_test.dart
│   │   │       └── history_test.dart
│   │   ├── database/
│   │   │   ├── database_test.dart
│   │   │   ├── config_test.dart
│   │   │   └── models/
│   │   │       ├── profile_test.dart
│   │   │       └── indexer_test.dart
│   │   └── utils/
│   │       ├── profile_tools_test.dart
│   │       └── validators_test.dart
│   ├── widget/
│   │   ├── ui/
│   │   │   ├── scaffold_test.dart
│   │   │   ├── appbar_test.dart
│   │   │   └── card_test.dart
│   │   └── modules/
│   │       └── dashboard_test.dart
│   └── helpers/
│       ├── mock_data.dart
│       └── test_helpers.dart
├── integration_test/
│   ├── app_test.dart
│   ├── profile_management_test.dart
│   └── module_configuration_test.dart
└── TESTING.md

lunasea-cloud-functions/functions/
├── test/
│   ├── controllers/
│   │   └── delete_user.test.ts
│   └── services/
│       ├── firestore.test.ts
│       └── storage.test.ts

lunasea-notification-service/
├── test/
│   ├── routes/
│   │   ├── sonarr.test.ts
│   │   └── radarr.test.ts
│   └── utils/
│       └── fcm.test.ts
```

---

## Testing Dependencies

### Flutter (pubspec.yaml)
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
  mockito: ^5.4.0
  build_runner: ^2.4.6  # Already installed
  test: ^1.24.0
```

### Backend (package.json)
```json
{
  "devDependencies": {
    "@types/jest": "^29.5.0",
    "jest": "^29.5.0",
    "supertest": "^6.3.3",
    "ts-jest": "^29.1.0"
  }
}
```

---

## Success Metrics

### Minimal (Phase 4A + Partial 4B)
- ✅ Test infrastructure exists
- ✅ Database operations tested
- ✅ At least 1 integration test passes
- ✅ `flutter test` runs without errors
- 📊 ~20-30% coverage

### Solid (Phase 4A + 4B + Partial 4C + 4D)
- ✅ All critical paths have tests
- ✅ Core widgets tested
- ✅ 5+ integration tests pass
- ✅ Documentation exists
- 📊 ~40-50% coverage

### Production-Ready (Full Phase 4)
- ✅ >70% code coverage
- ✅ All modules have tests
- ✅ Backend fully tested
- ✅ CI/CD automated testing
- ✅ Coverage enforced in PRs
- 📊 >70% coverage

---

## Immediate Next Steps

### **Option 1: Minimal Viable Testing** (Recommended)
**Time:** 8 hours
**Benefit:** Unblock production, basic safety net

1. Add test dependencies (30 min)
2. Create directory structure (30 min)
3. Write database tests (2 hours)
4. Write API mock tests (2 hours)
5. Write smoke integration test (1 hour)
6. Document testing approach (1 hour)
7. Run tests and fix issues (1 hour)

### **Option 2: Solid Foundation**
**Time:** 16 hours
**Benefit:** Production confidence, good coverage

Execute full Phase 4A + 4B + partial 4C + 4D

### **Option 3: Defer Testing**
**Time:** 0 hours (defer until later)
**Benefit:** Maintain momentum, ship faster

- Keep Phase 4 documented but not implemented
- Proceed to Phase 5 (Deployment Prep)
- Add tests incrementally post-launch

---

## Risks & Considerations

**If We Skip Testing:**
- ❌ Higher risk of production bugs
- ❌ Harder to refactor confidently
- ❌ Regression issues more likely
- ⚠️ Not following best practices

**If We Do Minimal Testing:**
- ✅ Basic safety net in place
- ✅ Critical data operations protected
- ⚠️ UI bugs still possible
- ⚠️ Edge cases not covered

**If We Do Full Testing:**
- ✅ Production-ready quality
- ✅ Confident refactoring
- ✅ Regression prevention
- ⏰ Significant time investment (40-80 hours)

---

## Recommendation

**Implement Phase 4A + Partial 4B** (Minimal Viable Testing)

**Reasoning:**
1. Provides basic safety net without huge time investment
2. Protects critical data operations (user profiles, configs)
3. Establishes testing patterns for future expansion
4. Unblocks production launch
5. Can expand coverage incrementally post-launch

**Next Steps:**
1. Add test dependencies to pubspec.yaml
2. Create test directory structure
3. Write 5-10 database operation tests
4. Write 5-10 API client tests
5. Write 2-3 integration smoke tests
6. Create TESTING.md guide
7. Run all tests and verify they pass

**Time:** ~8 hours
**Tests:** ~20-30 tests
**Coverage:** ~20-30%

Then proceed to Phase 5 (Deployment Preparation) or Phase 6 (Production Launch).

---

**Last Updated:** 2026-06-14
**Status:** Documented - Awaiting decision on approach

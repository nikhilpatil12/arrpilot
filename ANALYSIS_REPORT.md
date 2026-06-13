# LunaSea → ArrPilot: Comprehensive Analysis & Migration Plan

**Generated:** 2026-06-13
**Repository:** `/Users/nikhil/Developer/arrpilot`
**Current Version:** 11.0.0
**Analyst:** Production-Grade Fork Assessment

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Repository Map](#repository-map)
3. [Architecture Analysis](#architecture-analysis)
4. [Technical Debt Assessment](#technical-debt-assessment)
5. [Dependencies & External Services](#dependencies--external-services)
6. [Rebranding Impact Assessment](#rebranding-impact-assessment)
7. [Phased Migration Plan](#phased-migration-plan)
8. [Risk Management](#risk-management)
9. [Testing Strategy](#testing-strategy)
10. [Rollback Procedures](#rollback-procedures)

---

## Executive Summary

### Project Overview

LunaSea is a mature, production-ready Flutter-based media server controller supporting **6 platforms** (iOS, Android, macOS, Windows, Linux, Web) with **1,346 Dart files** (~87k LOC), comprehensive CI/CD infrastructure, and supporting cloud services. The transformation to ArrPilot requires systematic rebranding across **1,000+ files** while maintaining full GPL-3.0 compliance.

### Critical Statistics

| Metric | Count | Impact |
|--------|-------|--------|
| Total Files Affected | 1,000+ | Critical |
| "lunasea" Occurrences | 5,899 | Critical |
| Import Statements | 2,092 | Critical |
| Localization Files | 228 (19 languages) | High |
| Class/Enum Definitions | 130+ | High |
| Platform Configurations | 50+ | High |
| CI/CD Workflows | 7+ | High |
| External Service Integrations | 8+ | High |

### Critical Findings

#### 🚨 Blockers (Must Fix Before Launch)

1. **Node.js 14 EOL in Cloud Functions** - Security risk, blocks all backend updates
2. **29 Security Vulnerabilities** in notification service and cloud functions
3. **Zero Test Coverage** - No automated testing infrastructure
4. **Breaking Change for Users** - No automatic update path from LunaSea

#### ⚠️ High Priority Issues

1. **Firebase Project Migration** - New project required for ArrPilot
2. **App Store Resubmission** - Bundle ID changes require new listings
3. **Domain Migration** - lunasea.app → arrpilot.app (assumed)
4. **User Data Migration** - Tools needed for user transition
5. **Material 2 → Material 3** - Flutter framework migration needed

#### ✅ Strengths to Preserve

1. **Well-Architected Codebase** - Clear module separation, consistent patterns
2. **Comprehensive Platform Support** - Battle-tested across 6 platforms
3. **Professional CI/CD** - Automated builds, code signing, store deployment
4. **Privacy-First Design** - No analytics/tracking by default
5. **GPL-3.0 Compliant** - Proper attribution already in place

---

## Repository Map

### Directory Structure

```
arrpilot/
├── lunasea/                          # Flutter application (1,346 Dart files)
│   ├── android/                      # Android build configs
│   │   ├── app/
│   │   │   └── src/main/kotlin/app/lunasea/lunasea/
│   │   └── fastlane/
│   ├── ios/                          # iOS build configs
│   │   ├── Runner/
│   │   └── fastlane/
│   ├── macos/                        # macOS build configs
│   │   ├── Runner/
│   │   └── fastlane/
│   ├── windows/                      # Windows build configs
│   ├── linux/                        # Linux build configs
│   ├── web/                          # Web build configs
│   ├── lib/                          # Dart source code
│   │   ├── api/                      # API clients (Sonarr, Radarr, etc.)
│   │   ├── database/                 # Hive database layer
│   │   ├── modules/                  # Feature modules (10 total)
│   │   ├── router/                   # go_router navigation
│   │   ├── system/                   # Platform abstractions
│   │   └── widgets/                  # Reusable UI components
│   ├── assets/                       # Images, icons, fonts, localization
│   │   ├── images/branding_logo.png
│   │   ├── icon/ (5+ variants)
│   │   ├── localization/ (228 JSON files)
│   │   └── LunaBrandIcons.ttf
│   ├── localization/                 # Source localization files
│   ├── scripts/                      # Build automation scripts
│   ├── .github/workflows/            # CI/CD (7+ workflows)
│   └── pubspec.yaml                  # Flutter dependencies
│
├── lunasea-cloud-functions/          # Firebase Cloud Functions
│   ├── functions/                    # TypeScript cloud functions
│   │   ├── src/
│   │   │   ├── controllers/
│   │   │   └── services/
│   │   └── package.json              # Node 14 (EOL) ⚠️
│   └── firebase.json
│
├── lunasea-notification-service/     # Notification relay service
│   ├── src/                          # TypeScript Express app
│   │   ├── api/                      # TMDb, Fanart.tv clients
│   │   ├── modules/                  # Webhook handlers
│   │   ├── server/                   # Express server
│   │   └── services/                 # Firebase, Redis
│   ├── Dockerfile                    # Node 18 container
│   ├── package.json
│   └── .github/workflows/build.yaml
│
└── lunasea-docs/                     # GitBook documentation
    ├── .gitbook/assets/              # Screenshots (13 files, needs rebranding)
    ├── getting-started/
    ├── lunasea/
    ├── modules/
    ├── releases/
    └── SUMMARY.md
```

### Component Breakdown

| Component | Language | Files | Lines | Purpose |
|-----------|----------|-------|-------|---------|
| Flutter App | Dart | 1,346 | ~87,122 | Multi-platform UI & logic |
| Cloud Functions | TypeScript | 8 | ~85 | User deletion cleanup |
| Notification Service | TypeScript | 43 | ~3,281 | Webhook → Push notification relay |
| Documentation | Markdown | 27 | ~1,578 | User/developer docs |

---

## Architecture Analysis

### Flutter Application Architecture

#### Architectural Pattern
**Modified Provider Pattern with Module-Based Organization**

- **State Management:** Provider + ChangeNotifier (per-module state classes)
- **Navigation:** go_router 14.8.1 (type-safe routing with enums)
- **Persistence:** Hive 2.2.3 (NoSQL local database)
- **API Layer:** Mixed (Dio + custom controllers for *arr, Retrofit for downloaders)
- **Platform Abstraction:** Conditional imports with stub pattern

#### Module Structure

10 Modules:
1. **Dashboard** - Home screen with module tiles
2. **Sonarr** - TV series management (v3 API)
3. **Radarr** - Movie management (v3 API)
4. **Lidarr** - Music management (v1 API)
5. **SABnzbd** - Usenet downloader
6. **NZBGet** - Usenet downloader
7. **Tautulli** - Plex monitoring (v2 API)
8. **Search** - Newznab indexer search
9. **Settings** - App configuration
10. **External Modules** - Custom module links

Each module follows:
```
modules/{name}/
├── core/
│   ├── state.dart              # ChangeNotifier state
│   ├── api_controller.dart     # Business logic
│   ├── dialogs.dart            # User dialogs
│   └── types/                  # Module-specific enums
└── routes/
    └── {feature}/route.dart    # Screen implementations
```

#### Key Technologies

| Layer | Technology | Version | Status |
|-------|-----------|---------|--------|
| Framework | Flutter | 3.41.9 | ✅ Current |
| Language | Dart | 3.11.5 | ✅ Current |
| HTTP Client | Dio | 5.8.0 | ✅ Current |
| REST Generator | Retrofit | 4.4.2 | ✅ Current |
| Navigation | go_router | 14.8.1 | ✅ Current |
| State Mgmt | Provider | (via vendor) | ✅ Stable |
| Database | Hive | 2.2.3 | ✅ Current |
| Localization | easy_localization | 3.0.7 | ✅ Current |
| UI Theme | Material 2 | N/A | ⚠️ Migrate to M3 |

#### Platform Support Matrix

| Platform | Status | Min Version | Package/Bundle ID |
|----------|--------|-------------|-------------------|
| Android | ✅ Active | SDK 24 (Android 7.0) | app.lunasea.lunasea |
| iOS | ✅ Active | iOS 12.0 | app.lunasea.lunasea |
| macOS | ✅ Active | 10.15 (Catalina) | app.lunasea.lunasea |
| Windows | ✅ Active | Windows 10+ | app.lunasea.lunasea |
| Linux | ✅ Active | Ubuntu 20.04+ | app.lunasea.lunasea |
| Web | ✅ Active | Modern browsers | N/A |

### Backend Architecture

#### Cloud Functions (Firebase)
- **Runtime:** Node.js 14 ⚠️ **EOL since April 2023**
- **Functions:** 1 (deleteUserController - auth trigger)
- **Purpose:** Cleanup Firestore + Cloud Storage on user deletion
- **Dependencies:** firebase-admin 10.0.0 (4 versions behind)

#### Notification Service (Express.js)
- **Runtime:** Node.js 18 (Docker: node:18-alpine)
- **Architecture:** Express.js + TypeScript
- **Endpoints:** 7 modules × 2 routes (user/device) = 14 endpoints
- **External APIs:**
  - Firebase Cloud Messaging (push notifications)
  - TheMovieDB API (movie/TV metadata)
  - Fanart.tv API (music artwork)
- **Caching:** Redis (30s device cache, 7d image cache)
- **Pattern:** Response-first (return 200, process async)

#### Service Integration Flow
```
Media Server (Sonarr/Radarr/etc.)
    ↓ Webhook
Notification Service
    ↓ Process → Enrich (TMDb/Fanart)
Firebase Cloud Messaging
    ↓ Push Notification
Mobile/Desktop App
```

### Build & Deployment Architecture

#### CI/CD Pipeline (GitHub Actions)

**Workflow:** Prepare → Build (6 platforms in parallel) → Deploy

1. **Prepare Job**
   - Calculate build number: `1000000000 + git commit count`
   - Run code generators (localization, build_runner, environment)
   - Create build artifacts for all platforms

2. **Platform Builds** (Parallel)
   - **Android:** AAB (Play Store) + APK (direct)
   - **iOS:** IPA (App Store/TestFlight)
   - **macOS:** PKG (App Store) + ZIP + DMG (direct)
   - **Windows:** ZIP + MSIX (Store)
   - **Linux:** DEB + TAR.GZ + SNAP
   - **Web:** Hosted + ZIP + Docker

3. **Deployment**
   - **Mobile:** Fastlane → TestFlight/Play Store
   - **Desktop:** Build bucket (builds.lunasea.app)
   - **Web:** Netlify + GitHub Container Registry
   - **Snap:** Snapcraft Store

#### Code Signing

| Platform | Method | Storage |
|----------|--------|---------|
| iOS | Fastlane Match | Private Git repo |
| macOS | Fastlane Match + Notarization | Private Git repo |
| Android | Keystore (JKS) | GitHub Secrets (base64) |
| Windows | PFX Certificate | GitHub Secrets |

---

## Technical Debt Assessment

### Critical Issues (P0 - Immediate Action)

#### 1. Node.js 14 End of Life ⚠️
**Location:** `lunasea-cloud-functions/functions/package.json`
```json
"engines": { "node": "14" }
```
- **Risk:** Security vulnerabilities, no patches since April 2023
- **Impact:** Blocks all dependency updates, compliance risk
- **Effort:** 4-8 hours
- **Action:**
  ```bash
  # Update to Node 18 or 20
  cd lunasea-cloud-functions/functions
  # Update package.json engines to "18"
  npm install firebase-admin@14.0.0 firebase-functions@7.2.5
  npm audit fix
  # Test, then redeploy
  ```

#### 2. Security Vulnerabilities (29 total)
**Affected:** Notification service + Cloud functions
- **Critical:** 1 (minimist prototype pollution)
- **High:** 11 (jsonwebtoken bypass, @grpc/grpc-js crashes, etc.)
- **Moderate:** 14
- **Fix:** Upgrade firebase-admin to 14.0.0, run npm audit fix

#### 3. Zero Test Coverage
**Affected:** Entire codebase
- **Flutter App:** 0% coverage (no test/ directory)
- **Cloud Functions:** 0% (firebase-functions-test installed but unused)
- **Notification Service:** 0%
- **Risk:** Regression during rebranding, undetected breaking changes
- **Action:** Add test infrastructure before major refactoring

### High Priority (P1)

#### 4. Material 2 → Material 3 Migration
**Location:** `lunasea/lib/widgets/ui/theme.dart`
```dart
ThemeData(useMaterial3: false, ...)
```
- **Impact:** Material 2 will be deprecated, visual inconsistencies
- **Effort:** 20-40 hours
- **Timing:** After initial rebrand

#### 5. Deprecated Patterns
- **Barrel File:** `core.dart` marked deprecated but still in use
- **Tuple Package:** Should migrate to Dart 3 Records
- **Provider:** Consider Riverpod (Provider 2.0) for better performance

#### 6. Large Files
- `api/tautulli/models/activity/session.dart`: 1,369 LOC
- `modules/settings/core/dialogs.dart`: 1,328 LOC
- `modules/sonarr/core/dialogs.dart`: 879 LOC
- **Action:** Refactor into smaller components

### Code Quality Strengths

✅ **Well-Organized Architecture** - Clear separation of concerns
✅ **Consistent Patterns** - Uniform module structure
✅ **Type-Safe Routing** - Enum-based route definitions
✅ **Platform Abstractions** - Conditional imports with stub pattern
✅ **Comprehensive Logging** - LunaLogger throughout
✅ **Multi-Profile Support** - Production-ready configuration system

---

## Dependencies & External Services

### Flutter Dependencies (48 total)

**Critical Dependencies:**
- ✅ All up-to-date or within acceptable ranges
- ⚠️ `modal_bottom_sheet` on pre-release (3.0.0-pre)
- ℹ️ No analytics or crash reporting (privacy-first)

### Backend Dependencies

#### Notification Service (Node 18)
**Outdated packages requiring updates:**
- firebase-admin: 11.11.0 → 14.0.0 (4 major versions)
- express: 4.18.2 → 5.2.1 (major update)
- pino: 8.15.4 → 10.3.1 (major update)
- typescript: 5.2.2 → 6.0.3 (major update)

#### Cloud Functions (Node 14 ⚠️)
**Critical updates required:**
- Node.js: 14 → 18 or 20
- firebase-admin: 10.0.0 → 14.0.0
- firebase-functions: 3.16.0 → 7.2.5
- typescript: 4.5.2 → 6.0.3

### External Service Dependencies

#### High Lock-in (Difficult to Replace)
1. **Firebase (FCM + Cloud Functions)**
   - Push notifications via Firebase Cloud Messaging
   - Cloud Functions for serverless backend
   - Firestore for device token storage
   - **Effort to replace:** 2-3 weeks

#### Medium Lock-in
2. **Redis** - Caching layer (well-abstracted, 2-3 days to swap)
3. **TheMovieDB API** - Movie metadata (1-2 days to swap)

#### Low Lock-in
4. **Google Fonts** - Font loading (1-2 hours to swap)
5. **Fanart.tv API** - Music artwork (4-8 hours to swap)

#### No Lock-in
6. **Self-Hosted Services** - All *arr applications (Sonarr, Radarr, Lidarr, SABnzbd, NZBGet, Tautulli)

---

## Rebranding Impact Assessment

### Scope of Changes

| Category | Files | Occurrences | Complexity | Hours |
|----------|-------|-------------|------------|-------|
| **Code Identifiers** | 758 | 2,092 imports | High | 40-60 |
| **Localization** | 228 | 1,000+ strings | Medium | 20-30 |
| **Build Configs** | 50+ | 500+ | High | 30-40 |
| **Assets/Branding** | 15+ | All visual | Medium | 20-30 |
| **Documentation** | 100+ | 700+ refs | Low | 10-15 |
| **CI/CD** | 10+ | 100+ | Medium | 10-15 |
| **Cloud Services** | 5+ | N/A | High | 15-20 |
| **Testing** | All | N/A | High | 40-60 |
| **TOTAL** | **1,000+** | **5,899** | **Very High** | **185-270** |

### Critical Rebranding Changes

#### 1. Package Identifiers (Breaking Change)
**Current:** `app.lunasea.lunasea`
**Target:** `app.arrpilot.arrpilot` (or similar)

**Impact:**
- ❌ **No automatic update path** - Users must install fresh
- ❌ **New app store listings** required (iOS, Android)
- ❌ **User data inaccessible** without migration tool
- ❌ **All push notification subscribers lost**

**Files Affected:**
- `android/app/build.gradle`: applicationId, namespace
- `ios/Runner/Info.plist`: CFBundleIdentifier
- `macos/Runner/Configs/AppInfo.xcconfig`: PRODUCT_BUNDLE_IDENTIFIER
- `windows/runner/Runner.rc`: ProductName
- `linux/CMakeLists.txt`: APPLICATION_ID
- `pubspec.yaml`: msix_config.identity_name

#### 2. Import Statements
**Count:** 2,092 across 758 Dart files

**Current:**
```dart
import 'package:lunasea/core.dart';
import 'package:lunasea/database/database.dart';
```

**Action:** Global search/replace after pubspec.yaml name change

#### 3. Class Names (~130 classes)
**Pattern:** `Luna*` prefix

**Examples:**
- `LunaSeaDatabase` → `ArrPilotDatabase`
- `LunaModule` → `ArrPilotModule`
- `LunaProfile` → `ArrPilotProfile`
- `LunaLogger` → `ArrPilotLogger`
- `LunaTheme` → `ArrPilotTheme`

**Action:** Systematic rename with IDE refactoring tools

#### 4. Localization (228 files × 19 languages)
**Current namespace:** `"lunasea.KeyName"`
**Target namespace:** `"arrpilot.KeyName"`

**Example:**
```json
// Before
{
  "lunasea.Ascending": "Ascending",
  "lunasea.Dashboard": "Dashboard"
}

// After
{
  "arrpilot.Ascending": "Ascending",
  "arrpilot.Dashboard": "Dashboard"
}
```

**Action:** Automated script + manual translation review

#### 5. Assets Requiring Redesign
- `assets/images/branding_logo.png` - Logo
- `assets/images/branding_full.png` - Splash screen
- `assets/icon/*.png` - All app icons (5+ variants)
- `assets/LunaBrandIcons.ttf` - Custom icon font
- `.gitbook/assets/*.png` - Documentation screenshots (13 files)

#### 6. Cloud Infrastructure
**Firebase Project:** `comettools-lunasea`

**Options:**
1. Create new Firebase project (`arrpilot-prod`)
2. Rename existing project (may have limitations)

**Required Changes:**
- `.firebaserc` files (2)
- Cloud function deployments
- Cloud Storage buckets (`backup.lunasea.app` → `backup.arrpilot.app`)
- All mobile app Firebase configurations

#### 7. Domains & URLs
**Current:**
- `lunasea.app` - Main site
- `docs.lunasea.app` - Documentation
- `builds.lunasea.app` - Build bucket
- `web.lunasea.app` - Web app
- `notify.lunasea.app` - Notification service

**Target (assumed):**
- `arrpilot.app`
- `docs.arrpilot.app`
- `builds.arrpilot.app`
- `web.arrpilot.app`
- `notify.arrpilot.app`

**Action:** Domain purchase, DNS setup, SSL certificates, redirects

---

## Phased Migration Plan

### Overview

The migration is divided into **7 phases** over **8-12 weeks**, prioritizing security fixes, then systematic rebranding, followed by quality improvements and deployment.

```
Phase 0: Critical Security Fixes (Week 1)
    ↓
Phase 1: Codebase Preparation (Week 2-3)
    ↓
Phase 2: Assets & Branding (Week 3-4)
    ↓
Phase 3: Configuration & Infrastructure (Week 4-6)
    ↓
Phase 4: Testing Infrastructure (Week 6-8)
    ↓
Phase 5: Deployment Preparation (Week 8-10)
    ↓
Phase 6: Production Launch (Week 10-12)
    ↓
Phase 7: Post-Launch Optimization (Ongoing)
```

---

### Phase 0: Critical Security Fixes
**Duration:** Week 1 (3-5 days)
**Risk:** Low (isolated changes)
**Blocking:** No

#### Objectives
1. Eliminate all critical security vulnerabilities
2. Upgrade EOL runtime environments
3. Establish baseline security posture

#### Tasks

**Task 0.1: Upgrade Cloud Functions Runtime** (P0)
- **File:** `lunasea-cloud-functions/functions/package.json`
- **Changes:**
  ```json
  {
    "engines": { "node": "18" },
    "dependencies": {
      "firebase-admin": "^14.0.0",
      "firebase-functions": "^7.2.5"
    },
    "devDependencies": {
      "typescript": "^6.0.3"
    }
  }
  ```
- **Steps:**
  1. Update package.json
  2. Run `npm install`
  3. Run `npm audit fix`
  4. Update tsconfig.json if needed
  5. Test function locally with Firebase emulator
  6. Deploy to Firebase: `firebase deploy --only functions`
  7. Monitor logs for errors
- **Testing:** Trigger user deletion, verify Firestore/Storage cleanup
- **Rollback:** Keep old deployment, redeploy if issues

**Task 0.2: Fix Notification Service Vulnerabilities** (P0)
- **File:** `lunasea-notification-service/package.json`
- **Changes:**
  ```json
  {
    "dependencies": {
      "firebase-admin": "^14.0.0",
      "axios": "^1.17.0",
      "ioredis": "^5.11.1"
    }
  }
  ```
- **Steps:**
  1. Update package.json
  2. Run `npm install`
  3. Run `npm audit`
  4. Fix remaining vulnerabilities
  5. Run `npm run build`
  6. Test locally: `npm run start:dev`
  7. Build Docker image
  8. Deploy to production
- **Testing:** Send test webhook, verify notification delivery
- **Rollback:** Revert Docker image tag

**Task 0.3: Security Audit Documentation**
- Document all vulnerabilities found
- Document fixes applied
- Create security baseline for future audits
- Set up automated security scanning (Dependabot/Snyk)

#### Deliverables
- [ ] Cloud functions running Node 18 with firebase-admin 14.0.0
- [ ] Notification service with 0 critical/high vulnerabilities
- [ ] Security audit report
- [ ] Automated security scanning enabled

#### Files Changed
- `lunasea-cloud-functions/functions/package.json`
- `lunasea-cloud-functions/functions/package-lock.json`
- `lunasea-notification-service/package.json`
- `lunasea-notification-service/package-lock.json`

#### Risks
- ⚠️ Breaking changes in Firebase SDK (mitigated by thorough testing)
- ⚠️ Cloud function cold start times may change
- ℹ️ Notification service downtime during deployment

---

### Phase 1: Codebase Preparation
**Duration:** Week 2-3 (10-15 days)
**Risk:** Medium (widespread code changes)
**Blocking:** Blocks all subsequent phases

#### Objectives
1. Rename all code identifiers (classes, imports, packages)
2. Update localization strings across all languages
3. Establish new package identity

#### Tasks

**Task 1.1: Create Migration Branch**
```bash
git checkout -b feat/rebrand-to-arrpilot
git push -u origin feat/rebrand-to-arrpilot
```

**Task 1.2: Update Package Identity** (Critical)
- **File:** `lunasea/pubspec.yaml`
- **Changes:**
  ```yaml
  name: arrpilot  # Changed from lunasea
  description: Self-Hosted Media Server Controller  # Updated

  fonts:
    - family: ArrPilotBrandIcons  # Changed from LunaBrandIcons
      fonts:
        - asset: assets/ArrPilotBrandIcons.ttf

  msix_config:
    display_name: ArrPilot
    identity_name: app.arrpilot.arrpilot
    execution_alias: arrpilot
    output_name: arrpilot-windows-amd64
  ```
- **Impact:** Breaks all 2,092 import statements (fixed in next task)

**Task 1.3: Update All Import Statements** (Critical)
- **Scope:** 758 Dart files
- **Pattern:**
  ```dart
  // Before
  import 'package:lunasea/...';

  // After
  import 'package:arrpilot/...';
  ```
- **Method:**
  ```bash
  # Global search/replace using sed or IDE
  find lib -type f -name "*.dart" -exec sed -i '' 's/package:lunasea/package:arrpilot/g' {} +
  ```
- **Verification:** `flutter pub get` should succeed

**Task 1.4: Rename Core Classes & Enums**
- **Count:** ~130 classes
- **Strategy:** Use IDE refactoring (VS Code/IntelliJ "Rename Symbol")
- **Critical Classes:**
  - `LunaSeaDatabase` → `ArrPilotDatabase`
  - `LunaModule` → `ArrPilotModule`
  - `LunaProfile` → `ArrPilotProfile`
  - `LunaLogger` → `ArrPilotLogger`
  - `LunaTheme` → `ArrPilotTheme`
  - `LunaException` → `ArrPilotException`
  - `LunaLinkedContent` → `ArrPilotLinkedContent`
  - All `Luna*` UI widgets → `ArrPilot*`
- **Testing:** Compile after each batch, ensure no broken references

**Task 1.5: Update Localization Namespace**
- **Files:** 228 JSON files in `lunasea/assets/localization/`
- **Script:** Create `scripts/rebrand_localization.dart`
  ```dart
  // Pseudocode
  for each JSON file:
    load JSON
    for each key starting with "lunasea.":
      rename to "arrpilot." + rest of key
    for each value containing "LunaSea":
      replace with "ArrPilot"
    save JSON
  ```
- **Manual Review:** Check translations for context-specific terms
- **Languages:** en, es, fr, de, it, pt, ru, zh, ja, ko, ar, tr, nl, pl, sv, no, da, fi, cs

**Task 1.6: Update Database Table References**
- **File:** `lunasea/lib/database/tables/lunasea.dart`
- **Changes:**
  - Rename file to `arrpilot.dart`
  - Update class name and all references
  - Update Hive box names (may require migration)

**Task 1.7: Update Custom Font References**
- **File:** Rename `assets/LunaBrandIcons.ttf` → `assets/ArrPilotBrandIcons.ttf`
- **Update:** `pubspec.yaml` fonts section
- **Update:** All Dart code referencing `LunaBrandIcons` font family

**Task 1.8: Run Code Generators**
```bash
cd lunasea
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
npm run generate:localization
npm run generate:environment
```

**Task 1.9: Verify Compilation**
```bash
# Test compilation for all platforms
flutter build apk --debug
flutter build ios --debug --no-codesign
flutter build macos --debug
flutter build windows --debug
flutter build linux --debug
flutter build web --debug
```

#### Deliverables
- [ ] All Dart code compiles without errors
- [ ] Package name changed to `arrpilot`
- [ ] 130+ classes renamed with `ArrPilot` prefix
- [ ] 2,092 import statements updated
- [ ] 228 localization files updated
- [ ] Custom font renamed and referenced correctly
- [ ] All code generators run successfully

#### Files Changed (~800 files)
- `lunasea/pubspec.yaml`
- `lunasea/lib/**/*.dart` (758 files)
- `lunasea/assets/localization/*.json` (228 files)
- `lunasea/assets/ArrPilotBrandIcons.ttf` (renamed)

#### Risks
- ⚠️ Breaking references in generated code (mitigated by regeneration)
- ⚠️ Translation context loss (mitigated by manual review)
- ⚠️ Database migration issues (test thoroughly)

#### Testing Strategy
- Unit tests (once added) must all pass
- Manual smoke test of all 10 modules
- Verify localization displays correctly in 3+ languages
- Test database operations (profile switching, settings)

---

### Phase 2: Assets & Branding
**Duration:** Week 3-4 (7-10 days)
**Risk:** Low (visual only)
**Blocking:** No (can run parallel to Phase 1)

#### Objectives
1. Design new ArrPilot brand identity
2. Create all app icons and splash screens
3. Update documentation screenshots

#### Tasks

**Task 2.1: Brand Identity Design**
- **Deliverables:**
  - Primary logo (SVG + high-res PNG)
  - App icon (1024×1024 source)
  - Color palette
  - Typography guidelines
- **Considerations:**
  - Distinct from LunaSea (avoid brand confusion)
  - Works at all sizes (16×16 to 1024×1024)
  - Follows platform design guidelines (iOS HIG, Material Design, Windows Fluent)

**Task 2.2: Generate App Icons**
- **Tool:** flutter_launcher_icons
- **Source:** `assets/icon/icon.png` (1024×1024)
- **Config:** `pubspec.yaml`
  ```yaml
  flutter_icons:
    android: true
    ios: true
    image_path: assets/icon/icon.png
    adaptive_icon_background: "#1A1A2E"  # New brand color
    adaptive_icon_foreground: assets/icon/icon_adaptive.png
  ```
- **Platform-specific:**
  - Linux: `assets/icon/icon_linux.png`
  - Windows: `assets/icon/icon_windows.png`
  - Web: `assets/icon/icon_web.png`
- **Generate:** `flutter pub run flutter_launcher_icons:main`

**Task 2.3: Create Splash Screens**
- **Source:** `assets/images/branding_full.png`
- **Config:** `pubspec.yaml`
  ```yaml
  flutter_native_splash:
    image: assets/images/branding_full.png
    color: "#1A1A2E"  # New background color
  ```
- **Generate:** `flutter pub run flutter_native_splash:create`

**Task 2.4: Update Branding Images**
- Replace `assets/images/branding_logo.png`
- Replace `assets/images/branding_full.png`
- Keep aspect ratios and dimensions similar for layout consistency

**Task 2.5: Recreate Custom Icon Font** (Optional)
- **Current:** `assets/LunaBrandIcons.ttf` (custom icons for modules)
- **Options:**
  1. Keep font, rename to ArrPilotBrandIcons.ttf (already done in Phase 1)
  2. Redesign icons with new brand style
- **If redesigning:** Use IcoMoon or similar to generate new TTF

**Task 2.6: Update Documentation Screenshots**
- **Location:** `lunasea-docs/.gitbook/assets/`
- **Count:** 13 PNG/JPG files (3.8 MB total)
- **Action:**
  - Take new screenshots from rebranded app
  - Replace all notification examples
  - Update background/branding images
- **Files:**
  - `background.png`
  - `lidarr_notification_example.png`
  - `overseerr_notification_example.png`
  - `radarr_notification_example.png`
  - `sonarr_notification_example.png`
  - Others as needed

**Task 2.7: Asset Verification**
```bash
# Verify all assets exist
ls assets/icon/icon*.png
ls assets/images/branding*.png
ls assets/ArrPilotBrandIcons.ttf

# Check asset generation
flutter pub run flutter_launcher_icons:main
flutter pub run flutter_native_splash:create
```

#### Deliverables
- [ ] New ArrPilot brand identity designed
- [ ] All app icons generated (5+ variants)
- [ ] Splash screens generated for all platforms
- [ ] Branding images replaced
- [ ] Documentation screenshots updated (13 files)
- [ ] Asset generation verified on all platforms

#### Files Changed (~25 files)
- `lunasea/assets/icon/*.png` (5 files)
- `lunasea/assets/images/branding_*.png` (2 files)
- `lunasea/assets/ArrPilotBrandIcons.ttf` (if redesigned)
- `lunasea-docs/.gitbook/assets/*.png` (13 files)
- Platform-specific generated assets (iOS, Android, etc.)

#### Risks
- ℹ️ Design revisions may delay timeline
- ℹ️ Platform-specific icon requirements may need adjustments
- ℹ️ No technical risk

---

### Phase 3: Configuration & Infrastructure
**Duration:** Week 4-6 (14-20 days)
**Risk:** High (breaks existing builds, requires new accounts)
**Blocking:** Blocks deployment

#### Objectives
1. Update all platform build configurations
2. Migrate Firebase project
3. Set up new domains and cloud infrastructure
4. Update CI/CD pipelines

#### Tasks

**Task 3.1: Update Android Configuration**
- **File:** `lunasea/android/app/build.gradle`
  ```gradle
  namespace = "app.arrpilot.arrpilot"
  defaultConfig {
      applicationId "app.arrpilot.arrpilot"
  }
  buildTypes {
      debug {
          applicationIdSuffix ".debug"
      }
  }
  ```
- **File:** Rename directory structure
  ```bash
  mv android/app/src/main/kotlin/app/lunasea/lunasea \
     android/app/src/main/kotlin/app/arrpilot/arrpilot
  ```
- **File:** `android/app/src/main/kotlin/app/arrpilot/arrpilot/MainActivity.kt`
  ```kotlin
  package app.arrpilot.arrpilot
  ```
- **File:** `android/app/src/main/AndroidManifest.xml`
  - Update package references
- **File:** `android/fastlane/Appfile`
  ```ruby
  package_name("app.arrpilot.arrpilot")
  ```
- **Testing:** `flutter build apk --debug`

**Task 3.2: Generate New Android Signing Key**
```bash
keytool -genkey -v -keystore ~/arrpilot-release-key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias arrpilot
```
- Create `android/key.properties`:
  ```properties
  storePassword=<password>
  keyPassword=<password>
  keyAlias=arrpilot
  storeFile=<path-to-key>
  ```
- **Security:** Store in GitHub Secrets as base64

**Task 3.3: Update iOS Configuration**
- **File:** `ios/Runner/Info.plist`
  ```xml
  <key>CFBundleIdentifier</key>
  <string>app.arrpilot.arrpilot</string>
  <key>CFBundleName</key>
  <string>ArrPilot</string>
  <key>CFBundleDisplayName</key>
  <string>ArrPilot</string>
  ```
- **File:** `ios/Runner.xcodeproj/project.pbxproj`
  - Update PRODUCT_BUNDLE_IDENTIFIER (multiple locations)
- **File:** `ios/fastlane/Appfile`
  ```ruby
  app_identifier("app.arrpilot.arrpilot")
  ```
- **File:** `ios/fastlane/Matchfile` - Update git URL for new certificates repo
- **Testing:** `flutter build ios --debug --no-codesign`

**Task 3.4: Set Up iOS Code Signing**
1. Create new private Git repo: `arrpilot-fastlane-match-storage`
2. Initialize Match:
   ```bash
   cd ios
   fastlane match init
   # Select git storage, enter repo URL
   ```
3. Generate certificates:
   ```bash
   fastlane match development
   fastlane match appstore
   ```
4. Update GitHub Secrets with Match SSH key

**Task 3.5: Update macOS Configuration**
- **File:** `macos/Runner/Configs/AppInfo.xcconfig`
  ```
  PRODUCT_NAME = ArrPilot
  PRODUCT_BUNDLE_IDENTIFIER = app.arrpilot.arrpilot
  PRODUCT_COPYRIGHT = Copyright © 2024 ArrPilot
  ```
- **File:** `macos/Runner/Info.plist`
  - Update CFBundleIdentifier, CFBundleName
- **File:** `macos/Runner.xcodeproj/project.pbxproj`
  - Update PRODUCT_BUNDLE_IDENTIFIER
- **File:** `macos/fastlane/Appfile`
  ```ruby
  app_identifier("app.arrpilot.arrpilot")
  ```
- **Testing:** `flutter build macos --debug`

**Task 3.6: Update Windows Configuration**
- **File:** `windows/runner/Runner.rc`
  ```c
  COMPANY_NAME "ArrPilot"
  PRODUCT_NAME "ArrPilot"
  FILE_DESCRIPTION "ArrPilot - Media Server Controller"
  ```
- **File:** `windows/CMakeLists.txt`
  ```cmake
  set(BINARY_NAME "arrpilot")
  ```
- **File:** `pubspec.yaml` (msix_config - already done in Phase 1)
- **Testing:** `flutter build windows --debug`

**Task 3.7: Update Linux Configuration**
- **File:** `linux/CMakeLists.txt`
  ```cmake
  set(BINARY_NAME "arrpilot")
  set(APPLICATION_ID "app.arrpilot.arrpilot")
  ```
- **File:** `debian/DEBIAN/control`
  ```
  Package: arrpilot
  Description: ArrPilot - Media Server Controller
  ```
- **File:** `debian/usr/share/applications/arrpilot.desktop` (rename from lunasea.desktop)
  ```desktop
  [Desktop Entry]
  Name=ArrPilot
  Exec=/usr/bin/arrpilot
  Icon=arrpilot
  ```
- **File:** `snap/snapcraft.yaml`
  ```yaml
  name: arrpilot
  apps:
    arrpilot:
      command: arrpilot
      desktop: usr/share/applications/arrpilot.desktop
  ```
- **Testing:** `flutter build linux --debug`

**Task 3.8: Update Web Configuration**
- **File:** `web/index.html`
  ```html
  <title>ArrPilot</title>
  <meta name="description" content="ArrPilot - Media Server Controller">
  ```
- **File:** `web/manifest.json`
  ```json
  {
    "name": "ArrPilot",
    "short_name": "ArrPilot",
    "description": "Media Server Controller"
  }
  ```
- **Testing:** `flutter build web --debug`

**Task 3.9: Create New Firebase Project**
1. Go to Firebase Console
2. Create project: `arrpilot-prod`
3. Enable services:
   - Authentication
   - Firestore
   - Cloud Storage
   - Cloud Functions
   - Cloud Messaging
4. Download service account key
5. Update `.firebaserc` files:
   ```json
   {
     "projects": {
       "default": "arrpilot-prod"
     }
   }
   ```
6. Update Firebase config in Flutter apps (iOS, Android, Web)

**Task 3.10: Migrate Cloud Functions**
```bash
cd lunasea-cloud-functions
firebase use arrpilot-prod
firebase deploy --only functions
```

**Task 3.11: Update Notification Service Configuration**
- **File:** `lunasea-notification-service/.env`
  ```env
  FIREBASE_PROJECT_ID=arrpilot-prod
  FIREBASE_CLIENT_EMAIL=...
  FIREBASE_DATABASE_URL=...
  FIREBASE_PRIVATE_KEY=...
  ```
- **Update:** Cloud Storage bucket name in code
  ```typescript
  const getBackupBucket = () =>
    admin.storage().bucket(process.env.BACKUP_BUCKET || 'backup.arrpilot.app');
  ```

**Task 3.12: Domain Setup**
1. **Purchase domains:**
   - `arrpilot.app`
   - `arrpilot.com` (redirect)
2. **Set up DNS:**
   - `arrpilot.app` → Main site
   - `docs.arrpilot.app` → Documentation (GitBook)
   - `builds.arrpilot.app` → Build bucket
   - `web.arrpilot.app` → Web app (Netlify)
   - `notify.arrpilot.app` → Notification service
3. **SSL certificates:**
   - Let's Encrypt for all subdomains
   - Netlify handles web.arrpilot.app
4. **Redirects from old domains:**
   - `lunasea.app/*` → `arrpilot.app/*` (301 permanent)

**Task 3.13: Update GitHub Repository**
1. Create new repo: `github.com/your-username/arrpilot`
2. Update all `.git/config` references
3. Update CI/CD secrets:
   - Android: KEY_JKS, KEY_PROPERTIES
   - iOS: MATCH_GIT_SSH_KEY, APPLE_ID, etc.
   - macOS: Same as iOS
   - Firebase: Service account keys
   - Notification service: API keys
4. Update repository references in:
   - `package.json` files (3)
   - Documentation
   - License/README

**Task 3.14: Update CI/CD Workflows**
- **Files:** `.github/workflows/*.yml` (7+ files)
- **Changes:**
  - Update repository references
  - Update Docker image names: `ghcr.io/your-username/arrpilot`
  - Update build artifact names
  - Update notification service image: `ghcr.io/your-username/arrpilot-notification-service`
- **Test:** Trigger workflow runs for all platforms

**Task 3.15: Update NPM Package Names**
- **File:** `lunasea/package.json`
  ```json
  {
    "name": "arrpilot",
    "repository": "https://github.com/your-username/arrpilot"
  }
  ```
- **File:** `lunasea-notification-service/package.json`
  ```json
  {
    "name": "arrpilot-notification-service",
    "repository": "https://github.com/your-username/arrpilot-notification-service"
  }
  ```
- **File:** `lunasea-cloud-functions/functions/package.json`
  ```json
  {
    "name": "arrpilot-cloud-functions"
  }
  ```

#### Deliverables
- [ ] All platform build configurations updated
- [ ] Android builds with new package ID
- [ ] iOS/macOS build with new bundle ID and code signing
- [ ] Windows/Linux build with new identifiers
- [ ] New Firebase project created and configured
- [ ] Cloud functions deployed to new project
- [ ] Notification service configured for new Firebase
- [ ] Domains purchased and DNS configured
- [ ] SSL certificates obtained
- [ ] GitHub repository migrated
- [ ] CI/CD pipelines updated and tested
- [ ] All NPM packages renamed

#### Files Changed (~70 files)
- All platform build configs (Android, iOS, macOS, Windows, Linux, Web)
- All Fastlane configurations
- `.firebaserc` files (2)
- `.github/workflows/*.yml` (7+ files)
- `package.json` files (3)
- Environment files (.env, etc.)

#### Risks
- 🔴 **Bundle ID change breaks App Store listings** (new apps required)
- 🔴 **Users lose data without migration** (provide export tool)
- 🔴 **Push notifications stop working** (users must re-register)
- ⚠️ **DNS propagation delays** (24-48 hours)
- ⚠️ **Code signing issues** (test thoroughly)
- ⚠️ **Firebase quota limits on free tier**

#### Testing Strategy
- Build all platforms in debug mode
- Test code signing for iOS/macOS/Windows
- Deploy cloud functions to staging Firebase project first
- Test notification service with new Firebase config
- Verify DNS resolution for all subdomains
- Test CI/CD pipeline end-to-end

---

### Phase 4: Testing Infrastructure
**Duration:** Week 6-8 (14-20 days)
**Risk:** Medium (new infrastructure)
**Blocking:** Should be done before production launch

#### Objectives
1. Add comprehensive test coverage
2. Set up automated testing in CI/CD
3. Create integration test suite
4. Establish testing standards

#### Tasks

**Task 4.1: Set Up Flutter Test Infrastructure**
- **Create:** `lunasea/test/` directory structure
  ```
  test/
  ├── unit/
  │   ├── api/
  │   ├── database/
  │   └── utils/
  ├── widget/
  │   └── widgets/
  └── integration/
      └── app_test.dart
  ```
- **Add to pubspec.yaml:**
  ```yaml
  dev_dependencies:
    flutter_test:
      sdk: flutter
    mockito: ^5.4.0
    build_runner: ^2.4.6
    integration_test:
      sdk: flutter
  ```

**Task 4.2: Write Unit Tests (High-Priority Areas)**
1. **API Controllers** (lunasea/lib/api/)
   - Test all Sonarr API endpoints
   - Test all Radarr API endpoints
   - Mock HTTP responses with Mockito
   - Test error handling

2. **Database Operations** (lunasea/lib/database/)
   - Test Hive box operations
   - Test profile switching
   - Test data persistence
   - Test migration logic

3. **State Management** (lunasea/lib/modules/*/core/state.dart)
   - Test state mutations
   - Test notifyListeners calls
   - Test data fetching

4. **Utilities** (lunasea/lib/utils/)
   - Test link generation
   - Test formatting functions
   - Test validators

**Example Test:**
```dart
// test/unit/api/sonarr_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:arrpilot/api/sonarr/sonarr.dart';

void main() {
  group('SonarrAPI', () {
    test('fetches series list', () async {
      final api = SonarrAPI(
        host: 'http://localhost:8989',
        apiKey: 'test-key',
      );

      // Mock response
      final series = await api.series.getAll();

      expect(series, isNotNull);
      expect(series, isA<List>());
    });
  });
}
```

**Task 4.3: Write Widget Tests**
- Test critical UI components:
  - ArrPilotScaffold
  - ArrPilotAppBar
  - ArrPilotCard
  - Module tiles
- Test navigation flows
- Test form validation

**Task 4.4: Write Integration Tests**
- **File:** `integration_test/app_test.dart`
- **Scenarios:**
  1. App launches successfully
  2. User can create profile
  3. User can add Sonarr instance
  4. User can view series list
  5. User can search for series
- **Run:** `flutter test integration_test/app_test.dart`

**Task 4.5: Add Backend Tests**

**Cloud Functions:**
```typescript
// lunasea-cloud-functions/functions/test/delete_user.test.ts
import { deleteUserController } from '../src/controllers/delete_user';
import * as admin from 'firebase-admin';

describe('deleteUserController', () => {
  it('deletes user from Firestore', async () => {
    // Test implementation
  });

  it('deletes user files from Storage', async () => {
    // Test implementation
  });
});
```

**Notification Service:**
```typescript
// lunasea-notification-service/test/sonarr.test.ts
import request from 'supertest';
import app from '../src/server/server';

describe('Sonarr Webhook', () => {
  it('processes Download event', async () => {
    const response = await request(app)
      .post('/v1/sonarr/device/test-token')
      .send({ eventType: 'Download', ... });

    expect(response.status).toBe(200);
  });
});
```

**Task 4.6: Set Up Test Coverage Reporting**
- **Tool:** `flutter test --coverage`
- **Goal:** >70% coverage for critical paths
- **CI Integration:** Fail build if coverage drops below threshold

**Task 4.7: Update CI/CD with Automated Testing**
- **File:** `.github/workflows/test.yml`
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
  ```
- **Add to all platform build workflows:** Run tests before building

**Task 4.8: Create Testing Documentation**
- **File:** `TESTING.md`
- **Content:**
  - How to run tests
  - How to write new tests
  - Testing standards
  - Coverage requirements

#### Deliverables
- [ ] Unit tests for API controllers (>50 tests)
- [ ] Unit tests for database operations (>20 tests)
- [ ] Widget tests for UI components (>30 tests)
- [ ] Integration tests for user flows (>5 tests)
- [ ] Backend tests (cloud functions + notification service)
- [ ] Test coverage >70% for critical paths
- [ ] Automated testing in CI/CD
- [ ] Testing documentation

#### Files Created (~100 test files)
- `lunasea/test/**/*.dart`
- `lunasea-cloud-functions/functions/test/**/*.ts`
- `lunasea-notification-service/test/**/*.ts`
- `.github/workflows/test.yml`
- `TESTING.md`

#### Risks
- ⚠️ Writing tests is time-consuming (may extend timeline)
- ℹ️ Mocking Firebase services can be complex
- ℹ️ Integration tests may be flaky

---

### Phase 5: Deployment Preparation
**Duration:** Week 8-10 (14-20 days)
**Risk:** High (app store submissions)
**Blocking:** Blocks production launch

#### Objectives
1. Create new app store listings
2. Prepare store metadata and screenshots
3. Set up beta testing channels
4. Create user migration tools

#### Tasks

**Task 5.1: Create App Store Listings**

**Apple App Store (iOS):**
1. Log in to App Store Connect
2. Create new app: "ArrPilot"
   - Bundle ID: `app.arrpilot.arrpilot`
   - SKU: `arrpilot-ios`
   - Primary Language: English
3. Fill out App Information:
   - Name: ArrPilot
   - Subtitle: Media Server Controller
   - Category: Utilities
   - Content Rights: Include third-party content
4. Prepare screenshots (required sizes):
   - 6.5" iPhone (1284×2778)
   - 5.5" iPhone (1242×2208)
   - 12.9" iPad Pro (2048×2732)
5. App description (4,000 char max)
6. Keywords: media server, sonarr, radarr, plex, automation
7. Support URL: `https://docs.arrpilot.app`
8. Privacy Policy URL: Create privacy policy

**Apple App Store (macOS):**
1. Create new app: "ArrPilot for macOS"
2. Same metadata as iOS
3. macOS-specific screenshots

**Google Play Store (Android):**
1. Create new app in Play Console
2. App details:
   - App name: ArrPilot
   - Package name: `app.arrpilot.arrpilot`
   - Category: Tools
3. Store listing:
   - Short description (80 chars)
   - Full description (4,000 chars)
   - Screenshots (multiple device types)
   - Feature graphic (1024×500)
   - App icon (512×512)
4. Content rating questionnaire
5. Pricing: Free
6. Target audience and content

**Task 5.2: Create Store Screenshots**
- Use rebranded app to capture:
  - Dashboard view
  - Module list (Sonarr, Radarr, etc.)
  - Series/movie details
  - Settings screen
  - Notification examples
- **Tools:**
  - iOS: Xcode Simulator + Screenshot tool
  - Android: Android Studio Emulator
  - Desktop: Native apps
- **Localization:** English required, consider additional languages

**Task 5.3: Write Privacy Policy**
- **File:** Create on website: `arrpilot.app/privacy`
- **Required sections:**
  - Data collection (minimal - only Firebase auth)
  - Data usage
  - Data sharing (none)
  - User rights
  - Contact information
- **Reference:** LunaSea privacy policy as template

**Task 5.4: Set Up TestFlight (iOS/macOS)**
1. Configure TestFlight in App Store Connect
2. Create beta groups:
   - Internal testers (development team)
   - External testers (public beta)
3. Set up Fastlane for automated TestFlight upload:
   ```ruby
   lane :deploy_testflight do
     build_appstore
     upload_to_testflight(
       groups: ["Public Beta"],
       changelog: "Initial ArrPilot beta release"
     )
   end
   ```
4. Invite testers via email

**Task 5.5: Set Up Play Store Beta Track**
1. Create beta track in Play Console
2. Configure testing group:
   - Closed testing (invite-only)
   - Open testing (public)
3. Set up Fastlane for Play Store upload:
   ```ruby
   lane :deploy_beta do
     build_aab
     upload_to_play_store(
       track: 'beta',
       aab: '../build/app/outputs/bundle/release/app-release.aab'
     )
   end
   ```

**Task 5.6: Create User Migration Tool**
- **Purpose:** Export data from LunaSea, import to ArrPilot
- **Location:** `lunasea/lib/modules/settings/routes/migration/`
- **Features:**
  1. Export all profiles to JSON
  2. Export settings to JSON
  3. Export logs/history
  4. Generate migration file
  5. Import functionality in ArrPilot
- **UI:** Settings → Advanced → Export Data
- **Format:** JSON file (encrypted if contains credentials)

**Example:**
```dart
class MigrationExporter {
  Future<File> exportData() async {
    final data = {
      'version': '11.0.0',
      'export_date': DateTime.now().toIso8601String(),
      'profiles': LunaProfile.profiles.toJson(),
      'settings': LunaSeaDatabase.export(),
      'external_modules': LunaExternalModule.all().toJson(),
    };

    final json = jsonEncode(data);
    final file = await File('arrpilot_migration.json').writeAsString(json);
    return file;
  }
}
```

**Task 5.7: Create Migration Documentation**
- **File:** `lunasea-docs/getting-started/migration-from-lunasea.md`
- **Content:**
  1. Why fresh install is required (bundle ID change)
  2. How to export data from LunaSea
  3. How to install ArrPilot
  4. How to import data to ArrPilot
  5. How to set up notifications again
  6. FAQ and troubleshooting

**Task 5.8: Prepare Release Notes**
- **For stores:**
  ```
  ArrPilot is the successor to LunaSea, providing a powerful interface
  to manage your media server ecosystem. Control Sonarr, Radarr, Lidarr,
  SABnzbd, NZBGet, and Tautulli from one beautiful app.

  Features:
  - Multi-profile support
  - Push notifications
  - Dark/AMOLED themes
  - 6 platform support (iOS, Android, macOS, Windows, Linux, Web)
  - 19 language translations
  - Wake-on-LAN
  - And much more!

  This is a fork of LunaSea, licensed under GPL-3.0.
  ```

**Task 5.9: Set Up Build Bucket**
- **Domain:** `builds.arrpilot.app`
- **Storage:**
  - Option 1: AWS S3 + CloudFront
  - Option 2: DigitalOcean Spaces
  - Option 3: GitHub Releases
- **Structure:**
  ```
  /edge/
    /android/
    /ios/
    /macos/
    /windows/
    /linux/
    /web/
  /beta/
    ...
  /stable/
    ...
  ```
- **CI Integration:** Upload builds after successful workflow runs

**Task 5.10: Update Documentation Site**
- **Rewrite all docs in `lunasea-docs/`:**
  - Replace "LunaSea" with "ArrPilot" (700+ occurrences)
  - Update all URLs (lunasea.app → arrpilot.app)
  - Update screenshots
  - Add migration guide
  - Update download links
- **Deploy to GitBook:** Publish to `docs.arrpilot.app`

#### Deliverables
- [ ] iOS App Store listing created and approved
- [ ] macOS App Store listing created and approved
- [ ] Google Play Store listing created and approved
- [ ] Store screenshots created (20+ images)
- [ ] Privacy policy published
- [ ] TestFlight configured and tested
- [ ] Play Store beta track configured
- [ ] User migration tool implemented
- [ ] Migration documentation written
- [ ] Build bucket set up and tested
- [ ] Documentation site updated and deployed

#### Files Changed (~150 files)
- `lunasea-docs/**/*.md` (all documentation)
- Migration tool code
- Fastlane deployment configurations
- CI/CD upload scripts

#### Risks
- 🔴 **App Store review rejection** (mitigate with clear metadata)
- 🔴 **Trademark issues** (ensure "ArrPilot" is available)
- ⚠️ **Review delays** (Apple: 1-3 days, Google: hours to days)
- ⚠️ **Migration tool bugs** (test thoroughly)

---

### Phase 6: Production Launch
**Duration:** Week 10-12 (14-20 days)
**Risk:** Critical (user-facing)
**Blocking:** Final phase

#### Objectives
1. Submit apps to stores
2. Deploy all cloud services
3. Launch website and documentation
4. Communicate to users

#### Tasks

**Task 6.1: Pre-Launch Checklist**
- [ ] All tests passing (unit, widget, integration)
- [ ] All platforms build successfully
- [ ] Code signing works for all platforms
- [ ] Privacy policy live
- [ ] Documentation complete
- [ ] Migration tool tested
- [ ] Beta testing completed (at least 10 testers)
- [ ] No critical bugs in backlog
- [ ] Rollback plan documented

**Task 6.2: Deploy Cloud Infrastructure**

**Cloud Functions:**
```bash
cd lunasea-cloud-functions
firebase use arrpilot-prod
firebase deploy --only functions
# Test function trigger
```

**Notification Service:**
1. Build Docker image:
   ```bash
   cd lunasea-notification-service
   docker build -t ghcr.io/your-username/arrpilot-notification-service:1.0.0 .
   docker push ghcr.io/your-username/arrpilot-notification-service:1.0.0
   ```
2. Deploy to hosting (e.g., DigitalOcean, AWS ECS, etc.)
3. Configure environment variables
4. Point `notify.arrpilot.app` to deployment
5. Test webhook endpoints

**Cloud Storage:**
- Create backup bucket: `backup.arrpilot.app`
- Set CORS policy
- Test upload/download

**Task 6.3: Deploy Website**
- **Main site (`arrpilot.app`):**
  - Create landing page
  - Feature overview
  - Download links
  - Link to documentation
  - Support/contact info
- **Documentation (`docs.arrpilot.app`):**
  - Deploy updated GitBook
  - Verify all links work
  - Test on mobile/desktop
- **Web app (`web.arrpilot.app`):**
  - Deploy to Netlify/Vercel
  - Configure edge/beta/stable subdomains
  - Test functionality
- **Build bucket (`builds.arrpilot.app`):**
  - Upload initial builds
  - Test download links

**Task 6.4: Submit to App Stores**

**iOS (App Store):**
1. Build release IPA:
   ```bash
   cd lunasea
   fastlane ios build_appstore
   ```
2. Upload to App Store Connect:
   ```bash
   fastlane ios deploy_appstore
   ```
3. Submit for review
4. Answer review questions promptly
5. **Wait:** 1-3 days for approval

**macOS (App Store):**
1. Build release PKG:
   ```bash
   fastlane macos build_app_store
   ```
2. Upload to App Store Connect:
   ```bash
   fastlane macos deploy_appstore
   ```
3. Submit for review

**Android (Play Store):**
1. Build release AAB:
   ```bash
   cd lunasea/android
   fastlane build_aab
   ```
2. Upload to Play Console:
   ```bash
   fastlane deploy_playstore
   ```
3. Submit for review (usually hours)

**Task 6.5: Publish Direct Downloads**
- **Windows:**
  - Build MSIX and ZIP
  - Upload to builds.arrpilot.app
  - Create download page
- **Linux:**
  - Build DEB, TAR.GZ, SNAP
  - Upload to builds.arrpilot.app
  - Submit SNAP to Snapcraft Store
- **macOS (DMG):**
  - Build signed DMG
  - Notarize with Apple
  - Upload to builds.arrpilot.app

**Task 6.6: Set Up Domain Redirects**
- Configure `lunasea.app` → `arrpilot.app` (301 permanent)
- Add banner on old site: "LunaSea is now ArrPilot"
- Redirect subdomains:
  - `docs.lunasea.app` → `docs.arrpilot.app`
  - `web.lunasea.app` → `web.arrpilot.app`
  - etc.

**Task 6.7: Prepare Announcement**
- **Channels:**
  - Discord server
  - Reddit post
  - GitHub release
  - Twitter/social media (if applicable)
- **Content:**
  ```
  📢 Announcing ArrPilot - The Evolution of LunaSea

  LunaSea has been forked and rebranded as ArrPilot, continuing
  development under GPL-3.0.

  ✨ What's New:
  - Modern security updates
  - Enhanced stability
  - Continued active development

  ⚠️ Important: This is a fresh install. You'll need to:
  1. Export your data from LunaSea (Settings → Export)
  2. Install ArrPilot
  3. Import your data

  📱 Download: https://arrpilot.app
  📚 Migration Guide: https://docs.arrpilot.app/migration

  Thank you to @JagandeepBrar for the original LunaSea project!
  ```

**Task 6.8: Create GitHub Release**
1. Tag release: `v11.0.0`
2. Generate release notes:
   ```
   # ArrPilot v11.0.0 - Initial Release

   ArrPilot is a fork of LunaSea, providing a powerful interface to
   manage your *arr media server stack.

   ## Downloads
   - [iOS/macOS - App Store](...)
   - [Android - Play Store](...)
   - [Windows - MSIX](...)
   - [Linux - DEB/SNAP/TAR](...)
   - [Web - Hosted](...)

   ## Changes from LunaSea
   - Rebranded to ArrPilot
   - Updated all dependencies
   - Fixed security vulnerabilities
   - Improved stability

   ## Migration from LunaSea
   See [Migration Guide](https://docs.arrpilot.app/migration)

   ## Attribution
   ArrPilot is derived from [LunaSea](https://github.com/jagandeepbrar/lunasea)
   by Jagandeep Brar, licensed under GPL-3.0.
   ```
3. Attach build artifacts (optional - already on build bucket)

**Task 6.9: Monitor Initial Adoption**
- Set up monitoring:
  - Firebase Analytics (optional, privacy-conscious)
  - Server logs (notification service)
  - App Store/Play Store reviews
  - GitHub Issues
  - Discord support channel
- Watch for:
  - Crash reports
  - Migration issues
  - User feedback
  - Store review problems

**Task 6.10: Post-Launch Support**
- Respond to reviews promptly
- Fix critical bugs immediately
- Answer support questions
- Monitor social media mentions
- Track migration success rate

#### Deliverables
- [ ] All cloud services deployed and operational
- [ ] Website launched (arrpilot.app)
- [ ] Documentation published (docs.arrpilot.app)
- [ ] Web app deployed (web.arrpilot.app)
- [ ] iOS app approved and live on App Store
- [ ] macOS app approved and live on App Store
- [ ] Android app approved and live on Play Store
- [ ] Direct downloads available (Windows, Linux)
- [ ] SNAP published to Snapcraft Store
- [ ] Domain redirects configured
- [ ] Announcement published
- [ ] GitHub release created
- [ ] Monitoring in place

#### Files Changed
- Deployment configurations
- GitHub release artifacts

#### Risks
- 🔴 **App Store rejection** (respond quickly, appeal if needed)
- 🔴 **Critical bugs discovered** (have rollback plan ready)
- 🔴 **DNS/infrastructure issues** (test thoroughly beforehand)
- ⚠️ **User backlash** (communicate clearly and empathetically)
- ⚠️ **Migration tool failures** (provide manual migration steps)

---

### Phase 7: Post-Launch Optimization
**Duration:** Ongoing
**Risk:** Low
**Blocking:** No

#### Objectives
1. Fix bugs discovered in production
2. Migrate to Material 3
3. Improve test coverage to 90%
4. Add new features

#### Tasks

**Task 7.1: Bug Triage & Fixes**
- Monitor GitHub Issues
- Prioritize: Critical → High → Medium → Low
- Release patch versions as needed
- Maintain changelog

**Task 7.2: Material 3 Migration**
- **File:** `lunasea/lib/widgets/ui/theme.dart`
  ```dart
  ThemeData(
    useMaterial3: true,  // Enable Material 3
    colorScheme: ColorScheme.dark(...),
  )
  ```
- Update all UI components to Material 3 widgets
- Test on all platforms
- Gradual rollout via feature flag

**Task 7.3: Expand Test Coverage**
- Goal: 90% coverage for all modules
- Add missing widget tests
- Add end-to-end tests
- Performance tests

**Task 7.4: Code Quality Improvements**
- Refactor large files (>500 LOC)
- Remove deprecated patterns (core.dart)
- Migrate tuple → Records
- Consider Provider → Riverpod

**Task 7.5: Feature Development**
- Implement Overseerr API client
- Add support for new *arr applications
- Improve notification customization
- Enhanced search capabilities
- Multi-server support improvements

**Task 7.6: Performance Optimization**
- Profile app startup time
- Optimize database queries
- Reduce bundle size
- Improve notification latency

**Task 7.7: Community Building**
- Set up Discord server
- Create contribution guidelines
- Encourage community modules
- Regular release cadence (monthly?)

#### Deliverables
- Ongoing improvements and releases
- Growing user base
- Active community
- Stable, performant application

---

## Risk Management

### Critical Risks

| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| **App Store Rejection** | Medium | Critical | Clear metadata, follow guidelines, fast response |
| **User Data Loss** | Medium | Critical | Migration tool, clear documentation, testing |
| **Security Breach** | Low | Critical | Fix all CVEs, regular audits, responsible disclosure |
| **Bundle ID Conflict** | Low | Critical | Verify uniqueness before submission |
| **DNS Outage** | Low | High | Use reliable DNS provider, monitoring |
| **Firebase Quota Exceeded** | Low | High | Monitor usage, upgrade plan if needed |
| **Code Signing Failure** | Medium | High | Test thoroughly, backup certificates |
| **Migration Tool Bugs** | High | High | Extensive testing, provide manual fallback |

### Mitigation Strategies

**For App Store Rejection:**
1. Review guidelines thoroughly before submission
2. Ensure metadata is accurate and complete
3. Include clear privacy policy
4. Be prepared to respond to review team within 24 hours
5. Have backup plan to distribute via direct download

**For User Data Loss:**
1. Test migration tool with real LunaSea data
2. Provide step-by-step video tutorial
3. Offer manual migration instructions
4. Keep LunaSea installed until migration confirmed
5. Provide support channel for migration issues

**For Security Issues:**
1. Keep all dependencies up-to-date
2. Run automated security scans in CI/CD
3. Have incident response plan
4. Disclosure policy in SECURITY.md
5. Bug bounty program (optional)

---

## Testing Strategy

### Test Levels

**Unit Tests** (Target: 70% coverage)
- All API controllers
- All database operations
- All utility functions
- All state management classes

**Widget Tests** (Target: 50% coverage)
- All custom widgets
- Navigation flows
- Form validation
- Theme switching

**Integration Tests** (Target: 5+ critical flows)
- App launch
- Profile creation
- Module addition
- Series search
- Settings modification

**Manual Testing** (Before each release)
- All platforms
- All modules
- All notification types
- Migration tool
- Edge cases

### Test Environments

**Local Development**
- Developer machines
- All platforms in debug mode
- Firebase emulators for backend

**CI/CD**
- Automated test runs on every commit
- All platforms in release mode
- Fail build on test failures

**Beta Testing**
- TestFlight (iOS/macOS)
- Play Store beta track (Android)
- Direct downloads (Windows/Linux)
- 10+ beta testers minimum
- 1-2 weeks beta period before stable

**Production**
- Monitor crash reports
- User feedback
- Performance metrics

---

## Rollback Procedures

### If Critical Bug Found During Launch

**Immediate Actions:**
1. **Halt all deployments** - Stop CI/CD workflows
2. **Assess severity** - Is it data-loss? Crash? UI bug?
3. **Communicate** - Post status update to users
4. **Fix or rollback** - Decide based on severity

**Rollback Steps by Platform:**

**Mobile (iOS/Android):**
- Cannot rollback after App Store approval
- Submit hotfix update immediately
- Use "Pause Rollout" in Play Console if <20% rollout
- Communicate via store listing update notes

**Web:**
- Revert to previous Docker image tag
- Update Netlify deployment
- DNS change if needed (rollback domain)

**Cloud Services:**
- Firebase: Redeploy previous function version
- Notification Service: Revert Docker image
- Cloud Storage: No rollback needed (data-only)

**Desktop (Windows/Linux/macOS):**
- Remove broken build from builds.arrpilot.app
- Promote previous version to "latest"
- Update download page

### Data Corruption Scenarios

**If migration tool corrupts data:**
1. User should NOT uninstall LunaSea yet
2. Provide fixed migration tool version
3. User re-exports from LunaSea
4. User re-imports to ArrPilot
5. Verify data integrity before deleting LunaSea

**If database schema change breaks app:**
1. Include database migration rollback
2. Detect old schema version
3. Auto-migrate or prompt user
4. Worst case: User re-imports from export

### Communication Plan

**During Incident:**
- Update status page (if available)
- Post to Discord/Reddit
- Update GitHub Issues
- Pin notice in app (if possible)

**After Resolution:**
- Post-mortem report
- What happened
- Root cause
- Preventive measures
- Apology if appropriate

---

## Success Criteria

### Phase Completion Criteria

Each phase is considered complete when:
- [ ] All tasks in phase deliverables are checked
- [ ] All files changed are committed and merged
- [ ] All tests pass (if testing implemented)
- [ ] All builds succeed
- [ ] Code review approved (if team)
- [ ] Documentation updated

### Overall Project Success

The ArrPilot transformation is successful when:
- [ ] All 6 platforms build and run without errors
- [ ] Apps approved and live on iOS/Android/macOS stores
- [ ] Direct downloads available for Windows/Linux
- [ ] Website and documentation live
- [ ] User migration tool functional
- [ ] 0 critical or high security vulnerabilities
- [ ] Test coverage >70% for critical paths
- [ ] 10+ users successfully migrated from LunaSea
- [ ] No trademark/legal issues
- [ ] GPL-3.0 compliance maintained
- [ ] Active community forming

---

## Maintenance Plan

### Post-Launch Maintenance

**Weekly:**
- Review GitHub Issues
- Monitor crash reports
- Check dependency updates
- Review user feedback

**Monthly:**
- Security patch releases
- Dependency updates
- Bug fix releases
- Performance reviews

**Quarterly:**
- Feature releases
- Major dependency updates
- Comprehensive testing
- Documentation updates

**Annually:**
- Platform SDK updates
- Architecture reviews
- Security audits
- Dependency overhaul

---

## Conclusion

This migration plan provides a systematic, production-grade approach to transforming LunaSea into ArrPilot. The **7-phase plan spanning 8-12 weeks** addresses all critical aspects:

1. ✅ **Security first** - Fix all vulnerabilities before proceeding
2. ✅ **Systematic rebranding** - 1,000+ files updated methodically
3. ✅ **User-centric** - Migration tools and clear communication
4. ✅ **Quality-focused** - Comprehensive testing before launch
5. ✅ **GPL-compliant** - Proper attribution maintained
6. ✅ **Production-ready** - Full CI/CD, monitoring, support

**Estimated Total Effort:** 185-270 hours (4-7 weeks full-time)

**Key Success Factors:**
- Thorough testing at every phase
- Clear communication with users
- Proper attribution to original LunaSea project
- Gradual rollout with beta testing
- Strong rollback procedures

**Next Steps:**
1. Review and approve this plan
2. Set up development environment
3. Begin Phase 0 (Security Fixes)
4. Execute phases sequentially
5. Celebrate successful launch! 🎉

---

**Document Version:** 1.0
**Last Updated:** 2026-06-13
**Maintainer:** Production Architecture Team

# Phase 3: Configuration & Infrastructure - Action Plan

**Status:** 🟡 **In Progress** (Platform configs mostly done, infrastructure pending)
**Estimated Time:** 2-3 weeks (16-24 hours remaining)
**Date Created:** 2026-06-14

---

## Overview

Phase 3 focuses on updating platform-specific build configurations, migrating backend infrastructure, and updating CI/CD pipelines for the ArrPilot rebrand.

---

## Progress Summary

### ✅ **Completed in Phase 1**
- Android package ID and namespace
- iOS bundle identifier and Fastlane config
- macOS bundle identifier and Fastlane config
- Windows MSIX config (display name, execution alias)
- Package name in pubspec.yaml

### 🟡 **Partially Complete**
- Linux configuration (needs CMakeLists.txt, .desktop files)

### ❌ **Not Started**
- Android signing key generation
- iOS code signing setup (Fastlane Match)
- Firebase project migration
- Domain setup
- CI/CD workflow updates
- NPM package renames

---

## Task Breakdown

### **Task 3.1-3.6: Platform Configurations** ✅ **DONE**

**Completed:**
- ✅ Android: `com.gemridge.arrpilot` (build.gradle, AndroidManifest.xml, MainActivity.kt)
- ✅ iOS: `com.gemridge.arrpilot` (Info.plist, project.pbxproj, Fastlane Appfile)
- ✅ macOS: `com.gemridge.arrpilot` (project.pbxproj, Fastlane Appfile)
- ✅ Windows: MSIX config (display_name: ArrPilot, execution_alias: arrpilot)

**Verified:**
```bash
# iOS build successful
✓ Built build/ios/iphoneos/Runner.app (27.7MB)
```

---

### **Task 3.7: Update Linux Configuration** 🟡 **NEEDS COMPLETION**

**Files to Update:**

#### 1. `lunasea/linux/CMakeLists.txt`
```cmake
# Change:
set(BINARY_NAME "lunasea")
set(APPLICATION_ID "app.lunasea.lunasea")

# To:
set(BINARY_NAME "arrpilot")
set(APPLICATION_ID "com.gemridge.arrpilot")
```

#### 2. `lunasea/debian/DEBIAN/control`
```
# Change:
Package: lunasea
Description: LunaSea - Self-Hosted Controller

# To:
Package: arrpilot
Description: ArrPilot - Self-Hosted Media Server Controller
```

#### 3. `lunasea/debian/usr/share/applications/lunasea.desktop`
**Rename to:** `arrpilot.desktop`
```desktop
[Desktop Entry]
Name=ArrPilot
Comment=Self-Hosted Media Server Controller
Exec=/usr/bin/arrpilot
Icon=arrpilot
Terminal=false
Type=Application
Categories=Utility;
```

#### 4. `lunasea/snap/gui/lunasea.desktop`
**Rename to:** `arrpilot.desktop`
```desktop
[Desktop Entry]
Name=ArrPilot
Comment=Self-Hosted Media Server Controller
Exec=arrpilot
Icon=${SNAP}/meta/gui/arrpilot.png
Terminal=false
Type=Application
Categories=Utility;
```

#### 5. `lunasea/snap/snapcraft.yaml`
```yaml
name: arrpilot
version: '11.0.0'
summary: Self-Hosted Media Server Controller
description: ArrPilot is a self-hosted media server controller...

apps:
  arrpilot:
    command: arrpilot
    desktop: usr/share/applications/arrpilot.desktop
    extensions: [flutter-stable]
```

**Testing:**
```bash
flutter build linux --release
```

---

### **Task 3.2: Generate New Android Signing Key** ❌ **NOT STARTED**

**Action:** Create new release signing key for Play Store

**Steps:**
```bash
# Generate new keystore
keytool -genkey -v -keystore ~/arrpilot-release-key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias arrpilot

# Create key.properties (DO NOT COMMIT)
cat > android/key.properties <<EOF
storePassword=<your-password>
keyPassword=<your-password>
keyAlias=arrpilot
storeFile=/path/to/arrpilot-release-key.jks
EOF

# Add to .gitignore
echo "android/key.properties" >> .gitignore
```

**Security:**
- Store keystore file securely (1Password, encrypted backup)
- Never commit keystore or key.properties to Git
- Store in GitHub Secrets as base64 for CI/CD:
  ```bash
  base64 ~/arrpilot-release-key.jks > keystore.b64
  # Add to GitHub Secrets: KEY_JKS (contents of keystore.b64)
  # Add to GitHub Secrets: KEY_PROPERTIES (contents of key.properties)
  ```

**Status:** ⏸️ **Deferred** (not needed until Play Store deployment)

---

### **Task 3.4: Set Up iOS Code Signing** ❌ **NOT STARTED**

**Action:** Configure Fastlane Match for iOS/macOS code signing

**Prerequisites:**
- Apple Developer Account ($99/year)
- Access to Mac for code signing

**Steps:**
1. Create private Git repo: `arrpilot-fastlane-match-storage`
2. Initialize Match:
   ```bash
   cd ios
   fastlane match init
   # Select git storage
   # Enter repo URL: git@github.com:your-username/arrpilot-fastlane-match-storage.git
   ```
3. Generate certificates:
   ```bash
   fastlane match development --app_identifier com.gemridge.arrpilot
   fastlane match appstore --app_identifier com.gemridge.arrpilot
   ```
4. Update `ios/fastlane/Matchfile` and `macos/fastlane/Matchfile`
5. Store Match passphrase in GitHub Secrets

**Status:** ⏸️ **Deferred** (not needed until App Store deployment)

---

### **Task 3.8-3.11: Firebase Migration** ❌ **NOT STARTED**

**Current Firebase Project:** `comettools-lunasea` (existing)

**Action:** Create new Firebase project for ArrPilot

#### Step 1: Create New Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Project name: `arrpilot-prod`
4. Enable Google Analytics (optional)
5. Create project

#### Step 2: Enable Services
```
✅ Authentication (Email/Password, Google)
✅ Firestore Database
✅ Cloud Storage
✅ Cloud Functions
✅ Cloud Messaging (FCM)
```

#### Step 3: Add Apps
1. **Android app:**
   - Package name: `com.gemridge.arrpilot`
   - Download `google-services.json`
   - Place in `android/app/google-services.json`

2. **iOS app:**
   - Bundle ID: `com.gemridge.arrpilot`
   - Download `GoogleService-Info.plist`
   - Place in `ios/Runner/GoogleService-Info.plist`

3. **macOS app:**
   - Bundle ID: `com.gemridge.arrpilot`
   - Download `GoogleService-Info.plist`
   - Place in `macos/Runner/GoogleService-Info.plist`

4. **Web app:**
   - Download Firebase config
   - Update `web/index.html` with new config

#### Step 4: Update .firebaserc
```json
{
  "projects": {
    "default": "arrpilot-prod"
  }
}
```

Files to update:
- `lunasea/.firebaserc`
- `lunasea-cloud-functions/.firebaserc`
- `lunasea-notification-service/.firebaserc` (if exists)

#### Step 5: Deploy Cloud Functions
```bash
cd lunasea-cloud-functions
firebase use arrpilot-prod
firebase deploy --only functions
```

#### Step 6: Update Notification Service
Update `.env` file:
```env
FIREBASE_PROJECT_ID=arrpilot-prod
FIREBASE_CLIENT_EMAIL=firebase-adminsdk-xxxxx@arrpilot-prod.iam.gserviceaccount.com
FIREBASE_DATABASE_URL=https://arrpilot-prod.firebaseio.com
FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
```

#### Step 7: Migrate Data (Optional)
If migrating user data from LunaSea:
```bash
# Export from old project
firebase firestore:export gs://comettools-lunasea.appspot.com/backup

# Import to new project
firebase firestore:import gs://arrpilot-prod.appspot.com/backup
```

**Status:** ⏸️ **Deferred** (can continue development with existing Firebase project)

**Blocker:** Requires Firebase project creation (free tier available)

---

### **Task 3.12: Domain Setup** ❌ **NOT STARTED**

**Domains to Purchase:**
- `arrpilot.app` (primary) - $15-20/year
- `arrpilot.com` (redirect) - $10-15/year
- `arrpilot.io` (optional) - $30-40/year

**DNS Configuration:**
```
arrpilot.app              → Main site (landing page)
docs.arrpilot.app         → Documentation (GitBook/Netlify)
builds.arrpilot.app       → Build artifacts (S3/R2)
web.arrpilot.app          → Web app (Netlify/Vercel)
notify.arrpilot.app       → Notification service (Cloud Run/Fly.io)
api.arrpilot.app          → API/Cloud Functions (Firebase)
```

**SSL Certificates:**
- Managed by hosting providers (Netlify, Cloudflare, etc.)
- Let's Encrypt for self-hosted services

**Status:** ⏸️ **Deferred** (not needed until production deployment)

**Estimated Cost:** $50-100/year

---

### **Task 3.13: GitHub Repository Migration** ❌ **NOT STARTED**

**Current Repo:** Private fork of `JagandeepBrar/LunaSea`

**Options:**

#### Option A: Rename Current Repo
```bash
# On GitHub: Settings → Repository name → arrpilot
git remote set-url origin git@github.com:your-username/arrpilot.git
```

#### Option B: Create New Repo
```bash
# Create new repo on GitHub: your-username/arrpilot
git remote set-url origin git@github.com:your-username/arrpilot.git
git push -u origin main
```

**Files to Update:**
- `lunasea/package.json` → `repository` field
- `lunasea-notification-service/package.json` → `repository` field
- `lunasea-cloud-functions/functions/package.json` → `repository` field
- `LICENSE` → Copyright holder (if changing)
- `README.md` → Repository links
- Documentation → All GitHub links

**Status:** ⏸️ **Can be done anytime** (low priority)

---

### **Task 3.14: Update CI/CD Workflows** ❌ **NOT STARTED**

**Files:** `.github/workflows/*.yml` (7+ workflows)

**Current Workflows:**
```bash
ls -1 .github/workflows/
```

**Changes Needed:**
1. Update repository references
2. Update Docker image names:
   - `ghcr.io/jagandeepbrar/lunasea` → `ghcr.io/your-username/arrpilot`
   - `ghcr.io/.../lunasea-notification-service` → `.../arrpilot-notification-service`
3. Update build artifact names
4. Update secrets references (if changing)
5. Update deployment targets (if changing)

**Testing:**
```bash
# Test each workflow manually via GitHub Actions UI
# Or: Push to branch and monitor workflow runs
```

**Status:** ⏸️ **Deferred** (wait until ready to deploy via CI/CD)

**Blocker:** None (can update incrementally)

---

### **Task 3.15: Update NPM Package Names** 🟡 **PARTIALLY DONE**

**Files:**

#### 1. `lunasea/package.json` ✅ **DONE** (already says "arrpilot")
**Check:** Already updated in Phase 1

#### 2. `lunasea-notification-service/package.json`
```json
{
  "name": "arrpilot-notification-service",
  "description": "Notification service for ArrPilot",
  "repository": "https://github.com/your-username/arrpilot-notification-service"
}
```

#### 3. `lunasea-cloud-functions/functions/package.json`
```json
{
  "name": "arrpilot-cloud-functions"
}
```

**Status:** ⏭️ **Ready to complete**

---

## Recommended Execution Order

### **Phase 3A: Essential Platform Configs** (1-2 hours)
**Priority:** HIGH (needed for builds)

1. ✅ Update Linux CMakeLists.txt
2. ✅ Update Debian .desktop and control files
3. ✅ Update Snap configuration
4. ✅ Update NPM package names
5. ✅ Test Linux build
6. ✅ Commit changes

### **Phase 3B: Code Signing** (2-4 hours)
**Priority:** MEDIUM (needed for distribution)
**Status:** ⏸️ Defer until ready for app store deployment

1. Generate Android signing key
2. Set up Fastlane Match for iOS/macOS
3. Store keys in secure location
4. Add to GitHub Secrets

### **Phase 3C: Infrastructure Migration** (1-2 weeks)
**Priority:** LOW (can use existing infrastructure)
**Status:** ⏸️ Defer until production deployment

1. Create Firebase project
2. Deploy cloud functions
3. Configure notification service
4. Purchase domains
5. Configure DNS
6. Update CI/CD workflows

---

## Immediate Next Steps

### **Option 1: Complete Essential Configs (Recommended)**
Focus on finishing platform configurations:
- Update Linux configs
- Update NPM package names
- Test all platform builds
- Commit and proceed to Phase 4 (Testing)

**Time:** 1-2 hours
**Benefit:** All platforms fully configured, ready for testing

### **Option 2: Set Up Infrastructure**
Create Firebase project and configure backend:
- Create new Firebase project
- Deploy cloud functions
- Update app configurations
- Test authentication and cloud services

**Time:** 4-8 hours
**Benefit:** Own Firebase project, independent from LunaSea

### **Option 3: Skip to Phase 4**
Defer remaining Phase 3 tasks and start testing:
- Keep existing Firebase project temporarily
- Focus on adding tests
- Return to infrastructure later

**Time:** 0 hours (deferred)
**Benefit:** Maintain momentum, infrastructure can be done later

---

## Dependencies & Blockers

**No Blockers:**
- Can complete Linux configs immediately ✅
- Can update NPM packages immediately ✅

**Optional (Can Defer):**
- Android signing key - only needed for Play Store
- iOS code signing - only needed for App Store
- Firebase migration - can use existing project
- Domain setup - only needed for production
- CI/CD updates - only needed for automated deployments

---

## Recommendation

**Complete Phase 3A (Essential Platform Configs) now:**

1. Update Linux configuration files (30 min)
2. Update NPM package names (15 min)
3. Test Linux build (15 min)
4. Commit changes (10 min)
5. **Proceed to Phase 4** (Testing Infrastructure)

**Defer Phase 3B & 3C until:**
- Ready for app store submission (3B)
- Ready for production deployment (3C)

**Reasoning:**
- Phase 3A completes platform configuration
- Unblocks comprehensive testing (Phase 4)
- Infrastructure can be set up incrementally
- Code signing only needed when distributing
- Maintains development momentum

---

**Last Updated:** 2026-06-14
**Status:** Ready to execute Phase 3A (1-2 hours)

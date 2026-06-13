# Phase 3B: CI/CD Pipeline Updates

**Status:** ✅ **COMPLETE**
**Date Completed:** 2026-06-14
**Time Taken:** ~2 hours

---

## Overview

Updated all GitHub Actions workflows and configurations to use local actions and ArrPilot branding, removing dependencies on the original LunaSea repository.

---

## Changes Made

### 1. Workflow References Updated

**Main Build Workflow (`build.yml`):**
- ✅ Changed workflow calls from `JagandeepBrar/lunasea/.github/workflows/*` to `./.github/workflows/*`
- ✅ All 6 platform builds now use local workflows:
  - `build_android.yml`
  - `build_ios.yml`
  - `build_linux.yml`
  - `build_macos.yml`
  - `build_web.yml`
  - `build_windows.yml`
  - `prepare.yml`

### 2. Action References Updated

**All Build Workflows:**
- ✅ Changed action calls from `JagandeepBrar/lunasea/.github/actions/prepare_for_build@master` to `./.github/actions/prepare_for_build`
- ✅ Updated in 13 locations across 7 workflow files

### 3. Artifact Names Updated

**Platform-Specific Artifacts:**
- ✅ Linux tarball: `lunasea-linux-amd64.tar.gz` → `arrpilot-linux-amd64.tar.gz`
- ✅ Linux snap: `lunasea-linux-amd64.snap` → `arrpilot-linux-amd64.snap`
- ✅ Windows archive: `lunasea-windows-amd64.zip` → `arrpilot-windows-amd64.zip`
- ✅ Web archive: `lunasea-web-canvaskit.zip` → `arrpilot-web-canvaskit.zip`

### 4. Build Step Names Updated

- ✅ All "Build LunaSea" steps renamed to "Build ArrPilot" (13 occurrences)
- ✅ "Build & Push LunaSea" Docker step renamed to "Build & Push ArrPilot"

### 5. Docker Image Tags Updated

**Container Registry:**
- ✅ Old: `ghcr.io/jagandeepbrar/lunasea:${tag}`
- ✅ New: `ghcr.io/${github.repository_owner}/arrpilot:${tag}`
- ✅ Uses dynamic repository owner for flexibility

**Tags Generated:**
- `edge` - Development builds (push to master)
- `beta` - Beta releases
- `stable` - Production releases
- `latest` - Alias for stable
- Build-specific tags: `v{version}-{flavor}-{build}-{hash}`

### 6. Funding Configuration

**FUNDING.yml:**
- ✅ Removed original author funding links
- ✅ Added comment referencing original LunaSea project
- ✅ Prevents confusion about project maintainership

---

## Files Modified

**Total: 9 files**

1. `.github/workflows/build.yml`
2. `.github/workflows/prepare.yml`
3. `.github/workflows/build_android.yml`
4. `.github/workflows/build_ios.yml`
5. `.github/workflows/build_linux.yml`
6. `.github/workflows/build_macos.yml`
7. `.github/workflows/build_web.yml`
8. `.github/workflows/build_windows.yml`
9. `.github/FUNDING.yml`

---

## Validation

**YAML Syntax Validation:**
```bash
✓ build_android.yml
✓ build_ios.yml
✓ build_linux.yml
✓ build_macos.yml
✓ build_web.yml
✓ build_windows.yml
✓ build.yml
✓ prepare.yml
```

**All workflows validated successfully.**

---

## CI/CD Pipeline Flow

### Build Trigger
```
push to master OR manual workflow_dispatch
  ↓
prepare (Generate build metadata + core files)
  ↓
├─ build-android (APK + AAB)
├─ build-ios (IPA)
├─ build-linux (DEB + TAR.GZ + SNAP)
├─ build-macos (PKG + DMG + ZIP)
├─ build-web (Hosted + Archive + Docker)
└─ build-windows (MSIX + ZIP)
```

### Prepare Job Outputs
- `build-flavor`: `edge`, `beta`, or `stable`
- `build-number`: `1000000000 + commit_count`
- `build-version`: From `package.json`
- `build-title`: `v{version}-{flavor}-{build}-{hash}`
- `build-motd`: Release announcement message

### Artifacts Generated

**Android:**
- `android-playstore-package` - AAB for Google Play
- `android-app-package` - APK for sideloading

**iOS:**
- `ios-package` - IPA file

**Linux:**
- `linux-debian` - .deb package
- `linux-tarball` - .tar.gz archive
- `linux-snapcraft` - .snap package

**macOS:**
- `macos-app-store-package` - PKG for App Store
- `macos-direct-package` - DMG + ZIP for direct distribution

**Web:**
- `web-hosted` - Unarchived web build
- `web-archive` - arrpilot-web-canvaskit.zip
- Docker images pushed to `ghcr.io/${owner}/arrpilot:${tag}`

**Windows:**
- `windows-msix-package` - MSIX for Microsoft Store
- `windows-portable-package` - ZIP for portable use

---

## Security Secrets Required

**Still Required (unchanged):**

### Android
- `KEY_JKS` - Android signing key
- `KEY_PROPERTIES` - Signing key properties

### iOS/macOS
- `APPLE_ID` - Apple Developer ID
- `APPLE_ITC_TEAM_ID` - App Store Connect Team ID
- `APPLE_TEAM_ID` - Apple Developer Team ID
- `APPLE_STORE_CONNECT_ISSUER_ID` - API issuer ID
- `APPLE_STORE_CONNECT_KEY` - API key
- `APPLE_STORE_CONNECT_KEY_ID` - API key ID
- `IOS_CODESIGNING_IDENTITY` - Code signing identity
- `MACOS_INSTALLER_CERT_APP_STORE` - macOS App Store cert
- `MACOS_INSTALLER_CERT_DIRECT` - macOS direct distribution cert
- `MATCH_KEYCHAIN_NAME` - Fastlane Match keychain
- `MATCH_KEYCHAIN_PASSWORD` - Keychain password
- `MATCH_PASSWORD` - Match password
- `MATCH_SSH_PRIVATE_KEY` - SSH key for Match

### Windows
- `CODE_SIGNING_CERTIFICATE` - Windows code signing cert
- `CODE_SIGNING_PASSWORD` - Certificate password

---

## Breaking Changes

### For Fork Maintainers

1. **Docker Images:**
   - Old location: `ghcr.io/jagandeepbrar/lunasea`
   - New location: `ghcr.io/${your-username}/arrpilot`
   - Must enable GitHub Container Registry in repository settings

2. **Workflow Permissions:**
   - Workflows now use local actions (no external dependencies)
   - Requires `contents: read` and `packages: write` permissions

3. **Artifact Downloads:**
   - All artifact names changed (see section 3 above)
   - Update any downstream systems expecting old names

---

## Next Steps

**Remaining Phase 3 Tasks:**

- **Phase 3C: GitHub Repository Settings**
  - Update repository description
  - Update repository topics
  - Update website URL
  - Configure GitHub Pages (if needed)
  - Update branch protection rules

**Future Enhancements:**

- Add automated testing to CI/CD (Phase 4 tests)
- Add code coverage reporting
- Add automatic changelog generation
- Add release draft creation
- Consider adding workflow caching optimizations

---

## Testing Recommendations

**Before Production Use:**

1. **Test Workflow Locally:**
   ```bash
   # Install act (GitHub Actions local runner)
   brew install act

   # Test prepare workflow
   act workflow_dispatch -j prepare
   ```

2. **Test on Feature Branch:**
   - Create a test branch
   - Trigger manual workflow
   - Verify all jobs complete successfully
   - Check artifact names and contents

3. **Verify Docker Image Build:**
   - Check GitHub Container Registry after web build
   - Verify image tags are correct
   - Test pulling and running image

---

## Known Limitations

1. **Requires Secrets Configuration:**
   - Workflows will fail without proper secrets
   - Each platform requires specific certificates/keys
   - Test builds recommended before production

2. **GitHub Container Registry:**
   - Must be enabled in repository settings
   - Requires `packages: write` permission
   - Public visibility recommended for distribution

3. **Fastlane Match:**
   - iOS/macOS builds require Fastlane Match setup
   - Requires separate git repository for certificates
   - SSH key must be configured in secrets

---

**Status:** All CI/CD pipeline updates complete and validated ✅

# Phase 2: Assets & Branding - Action Plan

**Status:** 🟡 **Requires Design Work**
**Estimated Time:** 3-5 days (24-40 hours)
**Date Created:** 2026-06-14

---

## Current State Analysis

### Existing LunaSea Branding

**Visual Identity:**
- **Logo:** Crescent moon design in teal/turquoise gradient
- **Color Palette:**
  - Primary: Teal/Turquoise (#4ECDC4 approximate)
  - Secondary: Darker teal/green (#2E8B8B approximate)
  - Background: Dark slate gray (#32323E)
- **Theme:** Lunar/Moon concept

**Asset Files:**
```
assets/
├── icon/
│   ├── icon.png                 (1024x1024) - Main app icon
│   ├── icon_adaptive.png        (1024x1024) - Android adaptive foreground
│   ├── icon_windows.png         (256x256) - Windows icon
│   ├── icon_web.png            (512x512) - Web/PWA icon
│   └── icon_linux.png          (512x512) - Linux icon
├── images/
│   ├── branding_full.png       (3072x3072) - Splash screen logo
│   ├── branding_logo.png       (5120x1440) - Full logo with mark
│   └── brands/                 - Third-party service logos (keep)
└── ArrPilotBrandIcons.ttf      - Custom icon font (updated)
```

---

## Required: New ArrPilot Brand Identity

### Design Objectives

1. **Distinct from LunaSea:** Must not infringe on original branding
2. **Arr Ecosystem Integration:** Should complement Radarr, Sonarr, Lidarr visual language
3. **Professional & Modern:** Clean, recognizable, scalable
4. **Multi-platform:** Works at all sizes (16px to 1024px)
5. **Dark/Light Mode:** Looks good on both backgrounds

### Concept Suggestions

**Option 1: "Arr Pilot" Navigation Theme**
- Concept: Pilot/navigation/control theme
- Visual: Stylized aircraft/navigation symbol, compass rose, or control panel
- Colors: Blue/Navy (aviation), Orange/Red (radar), White accents
- Rationale: "Pilot" suggests control and navigation of media

**Option 2: "Arr" Letter Mark**
- Concept: Stylized "AP" or "arr" lettermark
- Visual: Modern, geometric letterforms with tech aesthetic
- Colors: Purple/Blue gradient (tech), or Orange/Red (alert/active)
- Rationale: Simple, clean, aligns with *arr naming convention

**Option 3: Hub/Central Control Theme**
- Concept: Central hub connecting to multiple services
- Visual: Hub/spoke diagram, network node, or control center
- Colors: Blue/Cyan (tech), Green (active), Dark UI
- Rationale: Emphasizes the "unified control" aspect

---

## Asset Replacement Checklist

### 🎨 Design Phase

- [ ] **Finalize brand concept** (navigation, lettermark, or hub theme)
- [ ] **Choose color palette** (primary, secondary, accent, backgrounds)
- [ ] **Design logo mark** (square format for icons)
- [ ] **Design full logo** (logo mark + wordmark "ArrPilot")
- [ ] **Create icon variations** (with/without padding, adaptive layers)

### 📱 Icon Generation

**Required Sizes & Formats:**

- [ ] **iOS Icons** (via flutter_launcher_icons)
  - Source: 1024x1024 PNG (icon.png)
  - Auto-generated: 20x20 to 1024x1024 (@1x, @2x, @3x)

- [ ] **Android Icons** (via flutter_launcher_icons)
  - Foreground: 1024x1024 PNG with transparency (icon_adaptive.png)
  - Background: Solid color #32323E or new brand color
  - Legacy: 512x512 PNG (icon.png)

- [ ] **macOS Icon** (via flutter_launcher_icons)
  - Source: 1024x1024 PNG (icon.png)
  - Auto-generated: .icns with multiple sizes

- [ ] **Windows Icon**
  - 256x256 PNG (icon_windows.png)
  - Consider .ico format with multiple sizes

- [ ] **Linux Icon**
  - 512x512 PNG (icon_linux.png)

- [ ] **Web/PWA Icon**
  - 512x512 PNG (icon_web.png)
  - Also: 192x192, 512x512 for manifest.json

### 🚀 Splash Screen Assets

- [ ] **Flutter Native Splash**
  - branding_full.png (3072x3072 recommended)
  - Must work on light background (if changing from #32323E)
  - Centered logo mark, no text preferred

- [ ] **Full Logo Image**
  - branding_logo.png (high resolution, e.g., 5120x1440)
  - Logo mark + "ArrPilot" wordmark
  - Used for documentation/promotional materials

### 🎨 Color Theme Updates

**Current:**
```yaml
adaptive_icon_background: "#32323E"  # Dark slate gray
flutter_native_splash.color: "#32323E"
```

**Action Items:**
- [ ] Decide if keeping #32323E or changing to new brand color
- [ ] Update adaptive_icon_background in pubspec.yaml
- [ ] Update flutter_native_splash.color in pubspec.yaml
- [ ] Update any hardcoded theme colors in Dart code (if needed)

---

## Implementation Steps

### Step 1: Asset Preparation
```bash
# Place new assets in:
assets/icon/icon.png              # 1024x1024 main icon
assets/icon/icon_adaptive.png     # 1024x1024 adaptive foreground
assets/icon/icon_windows.png      # 256x256 Windows
assets/icon/icon_web.png          # 512x512 Web
assets/icon/icon_linux.png        # 512x512 Linux
assets/images/branding_full.png   # 3072x3072 splash
assets/images/branding_logo.png   # High-res full logo
```

### Step 2: Generate Platform Icons
```bash
flutter pub run flutter_launcher_icons:main
```

This will generate:
- iOS: `ios/Runner/Assets.xcassets/AppIcon.appiconset/`
- Android: `android/app/src/main/res/mipmap-*/ic_launcher.png`
- macOS: `macos/Runner/Assets.xcassets/AppIcon.appiconset/`

### Step 3: Generate Splash Screens
```bash
flutter pub run flutter_native_splash:create
```

This will generate:
- iOS: `ios/Runner/Assets.xcassets/LaunchImage.imageset/`
- Android: `android/app/src/main/res/drawable*/launch_background.xml`

### Step 4: Update Configuration (if needed)
If changing background color:
```yaml
# pubspec.yaml
flutter_icons:
  adaptive_icon_background: "#NEW_COLOR"

flutter_native_splash:
  color: "#NEW_COLOR"
```

### Step 5: Test on All Platforms
```bash
# iOS
flutter run -d <ios-device>

# Android
flutter run -d <android-device>

# Web
flutter run -d chrome

# macOS
flutter run -d macos

# Windows
flutter run -d windows
```

### Step 6: Commit Changes
```bash
git add assets/ ios/ android/ macos/ pubspec.yaml
git commit -m "feat: Implement ArrPilot brand identity

- New app icons for all platforms
- New splash screens
- Updated brand colors (if applicable)
- Generated platform-specific assets"
```

---

## Dependencies

**Design Tools Needed:**
- Vector graphics software (Adobe Illustrator, Figma, Inkscape)
- Icon design tool (optional: Icon Slate, Nucleo, SF Symbols)
- Image optimization (ImageOptim, TinyPNG)

**Flutter Tools (Already Installed):**
- `flutter_launcher_icons: ^0.14.3` ✅
- `flutter_native_splash: ^2.3.2` ✅

---

## Current Status: ⏸️ Paused - Awaiting Design Assets

**Blockers:**
1. **No new brand identity designed yet**
2. **No icon/logo assets created**

**Options to Proceed:**

### Option A: Professional Design (Recommended)
- Hire a graphic designer
- Provide design brief based on concept suggestions above
- Receive assets in required formats
- **Estimated Cost:** $500-2,000
- **Estimated Time:** 1-2 weeks

### Option B: AI-Generated Design
- Use AI image generation (Midjourney, DALL-E, Stable Diffusion)
- Iterate on prompts until satisfactory
- Refine in vector graphics software
- **Estimated Cost:** $10-50 (subscription)
- **Estimated Time:** 1-3 days

### Option C: Use Temporary Placeholders
- Keep LunaSea assets temporarily
- Focus on Phase 3 (Infrastructure) and Phase 4 (Testing)
- Replace assets before public launch
- **Estimated Cost:** $0
- **Estimated Time:** 0 days (deferred)

### Option D: Simple Text-Based Icon
- Create simple "AP" lettermark using text
- Generate in Figma/Canva (free tools)
- Export in required sizes
- **Estimated Cost:** $0
- **Estimated Time:** 4-8 hours

---

## Recommendation

**Proceed with Option C (Temporary Placeholders) for now:**

1. **Keep existing LunaSea assets** as placeholders
2. **Continue with Phase 3** (Infrastructure) and **Phase 4** (Testing)
3. **Prioritize brand design** before Phase 6 (Production Launch)
4. **Add clear TODO/FIXME comments** in code noting placeholders

**Reasoning:**
- Code rebranding (Phase 1) is complete ✅
- Icons are purely cosmetic and don't affect functionality
- Better to have working infrastructure + tests than perfect icons
- Can always update icons later via app store updates
- Gives time to properly design brand identity rather than rush

---

## Next Steps (Immediate)

1. ✅ **Document Phase 2 requirements** (this file)
2. ⏭️ **Add TODO comments** to pubspec.yaml noting placeholder icons
3. ⏭️ **Proceed to Phase 3** (Configuration & Infrastructure)
4. ⏭️ **Proceed to Phase 4** (Testing Infrastructure)
5. 📅 **Return to Phase 2** before Phase 6 (Production Launch)

---

## Files Modified (When Implementing)

**When new assets are ready:**
```
assets/icon/icon.png
assets/icon/icon_adaptive.png
assets/icon/icon_windows.png
assets/icon/icon_web.png
assets/icon/icon_linux.png
assets/images/branding_full.png
assets/images/branding_logo.png
pubspec.yaml (if changing colors)
ios/Runner/Assets.xcassets/AppIcon.appiconset/*
android/app/src/main/res/mipmap-*/*
macos/Runner/Assets.xcassets/AppIcon.appiconset/*
```

---

**Last Updated:** 2026-06-14
**Status:** Documented - Awaiting design assets or decision to proceed with placeholders

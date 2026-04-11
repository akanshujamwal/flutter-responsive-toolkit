#  Responsive Forge

<div align="center">

![Responsive Forge Banner](https://img.shields.io/badge/Responsive_Forge-v1.0.0-6C63FF?style=for-the-badge&logo=flutter&logoColor=white)

**A developer tool that turns designer screen dimensions into a production-ready Flutter responsive extension — instantly.**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=flat-square&logo=dart)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-00D4AA?style=flat-square)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-6C63FF?style=flat-square)](CONTRIBUTING.md)
[![Open Source](https://img.shields.io/badge/Open-Source-FF6B6B?style=flat-square&logo=github)](https://github.com/akanshujamwal/responsive_forge)
[![Platform](https://img.shields.io/badge/Platform-Mobile%20%7C%20Web-40C9A2?style=flat-square)](https://github.com/akanshujamwal/responsive_forge)

[Features](#-features) · [Getting Started](#-getting-started) · [How It Works](#-how-it-works) · [Generated Extension](#-generated-extension-api) · [Architecture](#-architecture) · [Contributing](#-contributing)

</div>

---

##  About

**Responsive Forge** is an open-source Flutter tool built for Flutter developers who work directly with UX/UI designers. Instead of manually calculating `MediaQuery` fractions every time, you enter the designer's screen dimensions once — and get a **complete, production-ready Dart extension file** covering:

-  Responsive width & height
-  Font size scaling
-  Padding & margin (all sides, symmetric, custom)
-  Border radius
-  Icon sizing
-  SizedBox spacers (predefined + dynamic)
-  Breakpoint helpers (`isMobile`, `isTablet`, `isDesktop`)
-  `responsive<T>(mobile, tablet, desktop)` adaptive value selector
-  `num` shorthand extensions (`16.0.sp(context)`)

A built-in **multi-screen calculator** lets you test any pixel value across 9 preset device sizes simultaneously.

---

##  Features

###  Extension Generator
- Enter your **designer's screen width & height** (e.g. 390 × 844)
- Select your **target platform** — Mobile, Tablet, Web, or All
- Choose a custom **extension name** (default: `AppResponsive`)
- One-tap **quick presets** for popular devices (iPhone SE, Pixel 7, iPad Pro, Web FHD, and more)
- Instant **syntax-highlighted** code preview
- **Copy to clipboard** or **download as `.dart`** file

###  Value Calculator
- Test any pixel value (width, height, font, radius, padding, icon) across all preset screens at once
- Results displayed in a live grid — one card per device
- Each card shows the **responsive result** and the **extension method** to use

###  Smart UX
-  Shimmer loading effect while code generates
-  Full light & dark mode support (system-aware)
-  Responsive two-panel layout on wide screens; bottom nav on mobile
-  Status bar showing design size, platform, and line count of generated file

---

##  Getting Started

### Prerequisites

| Tool | Version |
|------|---------|
| Flutter SDK | `>=3.0.0` |
| Dart SDK | `>=3.0.0 <4.0.0` |
| Android Studio / VS Code | Latest |

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/akanshujamwal/responsive_forge.git

# 2. Navigate to the project
cd responsive_forge

# 3. Install dependencies
flutter pub get

# 4. Run the app
flutter run
```

To run on a specific platform:

```bash
flutter run -d chrome       # Web
flutter run -d android      # Android
flutter run -d ios          # iOS (macOS required)
```

---

##  Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_bloc` | ^8.1.6 | State management (Cubit) |
| `equatable` | ^2.0.5 | Value equality for Cubit states |
| `shimmer` | ^3.0.0 | Loading shimmer animation |
| `google_fonts` | ^6.2.1 | Inter font family |
| `flutter_highlight` | ^0.7.0 | Syntax-highlighted code preview |
| `path_provider` | ^2.1.2 | File saving on mobile |
| `share_plus` | ^8.0.2 | File sharing on mobile |

---

##  How It Works

```
Designer gives you:  390 × 844 px
         ↓
  You enter in Responsive Forge
         ↓
  It generates:

  double get widthScale  => screenWidth  / 390.0;
  double get heightScale => screenHeight / 844.0;

  double w(double val)  => val * widthScale;
  double h(double val)  => val * heightScale;
  double sp(double val) => val * avgScale;
  ...and much more
         ↓
  In your Flutter code:
  Container(
    width:   context.w(200),
    height:  context.h(100),
    padding: context.pAll(16),
    child: Text('Hello', style: TextStyle(fontSize: context.sp(14))),
  )
```

---

##  Generated Extension API

Once you download your `.dart` file, here's everything available on `BuildContext`:

###  Dimensions

| Method | Returns | Description |
|--------|---------|-------------|
| `context.w(100)` | `double` | Responsive width |
| `context.h(50)` | `double` | Responsive height |
| `context.sp(16)` | `double` | Responsive font size |
| `context.r(8)` | `double` | Responsive border radius |
| `context.icon(24)` | `double` | Responsive icon size |

###  Screen Info

| Property | Returns | Description |
|----------|---------|-------------|
| `context.screenWidth` | `double` | Current screen width |
| `context.screenHeight` | `double` | Current screen height |
| `context.safeHeight` | `double` | Height minus status/nav bars |
| `context.statusBarHeight` | `double` | Status bar height |
| `context.isLandscape` | `bool` | Orientation check |
| `context.isPortrait` | `bool` | Orientation check |

###  Padding

| Method | Returns | Description |
|--------|---------|-------------|
| `context.pAll(16)` | `EdgeInsets` | All sides equal |
| `context.pH(20)` | `EdgeInsets` | Horizontal only |
| `context.pV(12)` | `EdgeInsets` | Vertical only |
| `context.pHV(20, 12)` | `EdgeInsets` | Horizontal + Vertical |
| `context.pOnly(left: 8, top: 4)` | `EdgeInsets` | Custom sides |

###  Margin

| Method | Returns | Description |
|--------|---------|-------------|
| `context.mAll(16)` | `EdgeInsets` | All sides equal |
| `context.mH(20)` | `EdgeInsets` | Horizontal only |
| `context.mV(12)` | `EdgeInsets` | Vertical only |
| `context.mOnly(right: 8)` | `EdgeInsets` | Custom sides |

###  Spacing (SizedBox)

| Method / Property | Returns | Description |
|-------------------|---------|-------------|
| `context.hSpace(20)` | `Widget` | Vertical SizedBox |
| `context.wSpace(20)` | `Widget` | Horizontal SizedBox |
| `context.vSpace4` … `context.vSpace64` | `Widget` | Predefined vertical spacers |
| `context.hSpace4` … `context.hSpace64` | `Widget` | Predefined horizontal spacers |

###  Border Radius

| Method | Returns | Description |
|--------|---------|-------------|
| `context.rAll(12)` | `BorderRadius` | All corners |
| `context.rTop(12)` | `BorderRadius` | Top corners only |
| `context.rBottom(12)` | `BorderRadius` | Bottom corners only |
| `context.rOnly(topLeft: 8, bottomRight: 16)` | `BorderRadius` | Custom corners |

###  Breakpoints

| Property / Method | Returns | Description |
|-------------------|---------|-------------|
| `context.isMobile` | `bool` | `screenWidth < 600` |
| `context.isTablet` | `bool` | `600 ≤ screenWidth < 1024` |
| `context.isDesktop` | `bool` | `screenWidth ≥ 1024` |
| `context.responsive(mobile: x, tablet: y, desktop: z)` | `T` | Adaptive value selector |

###  num Extension

```dart
16.0.sp(context)       // Font size
100.0.adaptW(context)  // Width
50.0.adaptH(context)   // Height
8.0.r(context)         // Border radius
```

---

##  Architecture

The project follows **Clean Architecture** with feature-based folder structure.

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   │   ├── app_colors.dart        # All color definitions
│   │   └── app_strings.dart       # All text & preset data
│   ├── theme/
│   │   └── app_theme.dart         # Light & dark MaterialTheme
│   ├── utils/
│   │   ├── extension_generator.dart    # Core code generation logic
│   │   ├── file_downloader.dart        # Conditional export stub
│   │   ├── file_downloader_web.dart    # dart:html download
│   │   └── file_downloader_mobile.dart # path_provider + share_plus
│   └── widgets/
│       ├── shimmer_loading.dart    # Reusable shimmer widget
│       └── custom_text_field.dart  # Styled AppTextField
└── features/
    ├── home/
    │   └── presentation/
    │       └── pages/home_page.dart   # Tab/side navigation shell
    ├── generator/
    │   ├── domain/
    │   │   └── entities/screen_config.dart
    │   └── presentation/
    │       ├── cubit/
    │       │   ├── generator_cubit.dart
    │       │   └── generator_state.dart
    │       ├── pages/generator_page.dart
    │       └── widgets/
    │           ├── config_form.dart
    │           ├── platform_chip_selector.dart
    │           └── code_preview_widget.dart
    └── calculator/
        ├── domain/
        │   └── entities/calc_result.dart
        └── presentation/
            ├── cubit/
            │   ├── calculator_cubit.dart
            │   └── calculator_state.dart
            ├── pages/calculator_page.dart
            └── widgets/calc_card.dart
```

### State Management

Uses **flutter_bloc (Cubit)**:

```
GeneratorInitial
    → GeneratorLoading     (shimmer shows)
    → GeneratorSuccess     (code preview renders)
        → GeneratorCopied      (2 sec feedback)
        → GeneratorDownloading (download in progress)
    → GeneratorError       (error message)
```

---

##  Preset Devices

| Device | Width | Height |
|--------|-------|--------|
| iPhone SE | 375 | 667 |
| iPhone 14 | 390 | 844 |
| iPhone 14 Pro Max | 430 | 932 |
| Pixel 7 | 412 | 915 |
| Samsung S23 | 360 | 780 |
| iPad Air | 820 | 1180 |
| iPad Pro 12.9" | 1024 | 1366 |
| Web HD | 1280 | 720 |
| Web FHD | 1920 | 1080 |

---

##  Roadmap

| Feature | Status | Priority |
|---------|--------|----------|
| Extension Generator (core) |  Done | — |
| Multi-screen Calculator |  Done | — |
| Light / Dark theme |  Done | — |
| Preset device quick-fill |  Done | — |
| Copy & Download `.dart` |  Done | — |
| VS Code sidebar extension |  Planned |  High |
| `num` extension toggle (`.sp` syntax) |  Planned |  High |
| Live device frame preview |  Planned |  Medium |
| URL-shareable config links |  Planned |  Medium |
| Unit test file generator |  Planned |  Medium |
| GitHub Pages hosted web version |  Planned |  Low |
| i18n / localization support |  Planned |  Low |
| Tablet & Desktop breakpoints config |  Planned |  Low |
| GitHub Actions CI/CD |  Planned |  Low |

---

##  Contributing

Contributions are welcome and appreciated! Here's how to get involved:

### Quick Start

```bash
# Fork the repo, then:
git clone https://github.com/akanshujamwal/responsive_forge.git
cd responsive_forge
flutter pub get
git checkout -b feature/your-feature-name
```

### Guidelines

- Follow the existing **Clean Architecture** folder structure
- Use **Cubit** for all state management — no `setState` outside widgets
- Keep widgets small and single-responsibility
- Add a preset device? Add it to `app_strings.dart` only — it flows everywhere automatically
- Run `flutter analyze` before opening a PR — zero warnings expected

### PR Checklist

- [ ] Code runs without errors on mobile and web
- [ ] `flutter analyze` passes clean
- [ ] New feature follows clean architecture structure
- [ ] README updated if a new feature was added

---

##  Known Issues / Bugs (from original code)

These were present in the original calculator and have been fixed in this version:

| Bug | Original | Fixed |
|-----|----------|-------|
| Method names swapped | `calculateResponsiveHeight` computed width | Methods renamed correctly |
| Wrong listener bindings | Height controller → width method | Each controller bound to correct method |
| `onChanged` duplicate call | `calculateResponsiveHeight()` called twice | Both height + width methods called |

---

##  License

```
MIT License

Copyright (c) 2024 Responsive Forge Contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```

---

##  Acknowledgements

- [Flutter](https://flutter.dev) — the framework that makes this possible
- [flutter_bloc](https://bloclibrary.dev) — clean and predictable state management
- [flutter_highlight](https://pub.dev/packages/flutter_highlight) — beautiful syntax highlighting
- [shimmer](https://pub.dev/packages/shimmer) — smooth loading UX
- Every Flutter developer who's manually calculated `size.width * 0.0258` at 2am 🫡

---

<div align="center">

Made with ❤️ for the Flutter community

⭐ **Star this repo** if Responsive Forge saves you time!

[Report Bug](https://github.com/akanshujamwal/responsive_forge/issues) · [Request Feature](https://github.com/akanshujamwal/responsive_forge/issues) · [Discussions](https://github.com/akanshujamwal/responsive_forge/discussions)

</div>

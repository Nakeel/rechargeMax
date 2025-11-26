# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## Project Overview

**RechargeMax** is a Flutter mobile application that gamifies the experience of buying mobile airtime and data. The app enables users to earn entries into draws, spin prize wheels for instant rewards, and build loyalty through tiered membership.

**Key Characteristics:**
- Cross-platform (iOS 14+, Android 8.0+)
- Flutter 3.7.0+ with Dart
- Gamification-focused with animations and rewards
- Passwordless authentication (phone + OTP)
- Clean architecture with modular feature structure

**Related Documentation:**
- `RechargeMax_Specification.pdf` - Complete UI/UX specification (11+ screens)
- `PROJECT_CONTEXT.md` - Comprehensive project context and setup details

---

## Build & Development Commands

### Prerequisites
```bash
# Ensure Flutter is installed and on stable channel
flutter --version

# Get dependencies
flutter pub get

# Clean build (if needed)
flutter clean && flutter pub get
```

### Development Builds

**Run app in development mode:**
```bash
flutter run
```

**Run on specific device/platform:**
```bash
# Run on iOS
flutter run -d ios

# Run on Android
flutter run -d android

# List available devices
flutter devices
```

**Run with specific build config:**
```bash
# Dev environment (currently default)
flutter run --dart-define=ENV=dev

# QA environment
flutter run --dart-define=ENV=qa

# Production environment
flutter run --dart-define=ENV=prod
```

### Testing

**Run all tests:**
```bash
flutter test
```

**Run specific test file:**
```bash
flutter test test/path/to/test_file.dart
```

**Run tests with coverage:**
```bash
flutter test --coverage
```

### Code Quality

**Run linting:**
```bash
flutter analyze
```

**Fix linting issues automatically:**
```bash
dart fix --apply
```

**Format code:**
```bash
dart format lib test
```

### Build & Release

**Build APK (Android):**
```bash
flutter build apk --release
```

**Build AAB (Android App Bundle):**
```bash
flutter build appbundle --release
```

**Build iOS:**
```bash
flutter build ios --release
```

**Generate code from annotations (Freezed, JSON):**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Architecture Overview

### Clean Architecture with Feature Modules

The codebase follows **clean architecture** with complete separation of concerns:

```
features/
├── splash/              # Splash screen feature
├── auth/                # Authentication (prepared, not implemented)
└── spinWheel/           # Spin the Wheel game feature
    ├── data/            # Repositories, data sources, DTOs
    ├── domain/          # Entities, use cases
    └── presentation/    # UI, BLoCs, screens
```

Each feature has three layers:
- **Data Layer**: Handles data fetching (APIs, local storage)
- **Domain Layer**: Business logic (entities, use cases)
- **Presentation Layer**: UI and state management (screens, BLoCs)

### Core Infrastructure

```
core/
├── config/              # App initialization and setup
├── network/             # HTTP client (Dio) with interceptors
├── router/              # Navigation (GoRouter)
├── ui/                  # Theme, colors, design system
├── resolver/            # Dependency injection setup
├── storage/             # Local persistence (Hive, SharedPreferences)
├── providers/           # Global Riverpod providers
└── utils/               # Utility functions and helpers
```

### Dependency Injection Strategy

**GetIt Service Locator:**
- Used for singleton registration in `lib/core/resolver/init_dependencies.dart`
- Core services: Dio client, API client
- Registered lazily to improve startup time

**Riverpod Providers:**
- Used for functional reactive state management
- Declared in `lib/core/providers/providers.dart`
- Better testability than GetIt alone

### State Management

The app uses a **hybrid approach**:
- **BLoC** (flutter_bloc): Event-driven state management for complex features
- **Riverpod**: Functional reactive state management for providers and side effects
- **RxDart**: Reactive extensions for stream handling

### Network Layer Architecture

Sophisticated multi-layer interceptor chain in `lib/core/network/dio/`:

1. **Auth Interceptor** - Injects JWT tokens into requests
2. **Token Refresh Interceptor** - Automatically refreshes expired tokens
3. **Retry Interceptor** - Retries failed requests with backoff
4. **Error Interceptor** - Centralizes error handling
5. **Logging Interceptor** - Logs requests/responses for debugging

**Environment Configuration:**
- Dev: `https://apidev.yalo.ng`
- QA: `https://apiqa.yalo.ng`
- Prod: `https://api.yalo.ng`
- Configure in `lib/core/network/env.dart`

### Routing Architecture

**GoRouter-based declarative routing:**
- Routes defined in feature modules via `RouterModule` abstraction
- Centralized route names in `lib/core/router/route_name.dart`
- Deep linking support for notifications and external links
- Current routes: Splash (`/`), Spin Wheel (`/spinWheelRoute`)

**Navigation Flow:**
```
AppStart (initialization)
→ AppSetUp (Hive, plugins)
→ initModules (feature registration)
→ generateRoute (GoRouter creation)
→ MyApp (UI)
```

---

## Key Design System Implementation

### Colors
Located in `lib/core/ui/colors.dart`:
- Primary Blue: `#1E88E5`
- Secondary Orange: `#FF9800`
- Success Green: `#4CAF50`
- Alert Red: `#F44336`

### Typography
Using **Roboto** and **Geist** fonts:
- H1-H3 for headings
- Body 1-2 for content
- Caption for supporting text
- All defined in `lib/core/ui/app_theme.dart`

### Responsive Design
- **ScreenUtil** for responsive scaling
- Design size: 414x896 (standard phone)
- Minimum text adaptation enabled
- Split screen support

### Components Library
**60+ reusable widgets** in `lib/common/widgets/`:
- Form components (inputs, date pickers, dropdowns)
- Display components (cards, badges, progress bars)
- Navigation components (tabs, buttons)
- Specialized: Prize wheel, countdown timer, loyalty badges

---

## Important Implementation Notes

### Authentication
- **Passwordless**: Phone number + OTP only
- No traditional login/password required
- Stored in `lib/features/auth/` (prepared structure)
- OTP verification screens ready for implementation

### Data Persistence
- **Hive**: NoSQL local database (configured, ready for use)
- **SharedPreferences**: Key-value storage for simple data
- Initialize in `lib/core/config/app_set_up.dart`

### Gamification Elements
- **Spin the Wheel**: Located in `lib/features/spinWheel/`
- Uses `flutter_fortune_wheel` package
- Sound effects (start spin, win) in `assets/sounds/`
- Confetti animations for celebrations
- Animations with smooth easing functions

### Localization
- Default locale: Nigerian English (`en_NG`)
- Set in `MyApp` widget
- Currency formatting ready (`lib/core/utils/currency_formatter.dart`)
- Prepare for multi-language support using `intl` package

### Asset Management
```
assets/
├── fonts/geist/          # Geist font family (8 weights)
├── fonts/roboto/         # Roboto font
├── images/               # PNG/JPG images
├── newSvg/              # SVG graphics
└── sounds/              # start_spin.wav, win.wav
```

---

## Common Development Tasks

### Adding a New Feature
1. Create feature folder in `lib/features/{feature_name}/`
2. Structure: `data/`, `domain/`, `presentation/`
3. Create `FeatureResolver` for DI registration
4. Create `RouterModule` for routes
5. Register in `lib/core/resolver/app_resolver.dart`

### Implementing a New Screen
1. Create screen file in `features/{feature}/presentation/screens/`
2. Use BLoC or Riverpod for state management
3. Add route in feature's router module
4. Register route in `AppRoutes` (lib/core/router/route_name.dart)
5. Apply design system colors and typography

### Working with Network Requests
1. Create data source in `features/{feature}/data/datasources/`
2. Implement repository in `features/{feature}/data/repositories/`
3. Use `BaseAppApiClient` from `lib/core/network/dio/base_api.dart`
4. Handle errors using interceptors
5. Create use cases in domain layer

### Adding New Dependencies
1. Add to `pubspec.yaml`
2. Run `flutter pub get`
3. For code generation: `flutter pub run build_runner build`
4. Check for any breaking changes in documentation

### Testing
- Unit tests in `test/` directory
- Follow feature structure in tests
- Use `mockito` for mocking (not currently in pubspec, add if needed)
- Test data sources, repositories, use cases, BLoCs

---

## Code Style & Conventions

### Naming
- **Files**: snake_case (e.g., `spin_wheel_screen.dart`)
- **Classes**: PascalCase (e.g., `SpinWheelScreen`)
- **Constants**: camelCase (e.g., `const appName`)
- **Variables/Functions**: camelCase (e.g., `getUserData()`)

### Widget Structure
```dart
class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

### State Management (BLoC)
```dart
// Use sealed classes or enums for events/states
sealed class MyEvent {}
sealed class MyState {}

// Use copyWith for immutable updates
```

### Formatting
- Run `dart format lib test` before committing
- Line length: Follow analyzer defaults
- Use const constructors where possible

---

## Troubleshooting

### Build Issues
```bash
# Complete clean rebuild
flutter clean && flutter pub get && flutter run

# Clear build cache
rm -rf build/
rm -rf ios/Pods ios/Podfile.lock
flutter pub get
```

### Dependency Conflicts
```bash
# Get latest compatible versions
flutter pub upgrade

# Resolve specific conflicts
flutter pub get --verbose
```

### Code Generation Not Working
```bash
# Rebuild generated files
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode for development
flutter pub run build_runner watch
```

### Hot Reload Issues
```bash
# Full restart (when hot reload fails)
flutter run -v
# Press 'R' in terminal for hot reload
# Press 'r' in terminal for hot restart
```

---

## Multi-Environment Setup

The app supports three environments with different API bases:

**Environment Variables** (lib/core/network/env.dart):
- Dev: `https://apidev.yalo.ng` (Paystack test key)
- QA: `https://apiqa.yalo.ng` (Paystack test key)
- Prod: `https://api.yalo.ng` (Paystack live key)

**To build for specific environment:**
1. Modify `Env.getConfig` in `lib/core/network/env.dart`
2. Currently defaults to dev environment
3. Use BuildConfig class for environment-specific configuration

---

## Performance Considerations

- **Image Optimization**: Use SVG where possible (`flutter_svg`)
- **Lazy Loading**: Implement for long lists using BLoC
- **State Management**: Keep state close to where it's used
- **Build Optimization**: Use const constructors, avoid rebuilds
- **Network**: Implement caching, batching requests

---

## Testing Strategy

**Recommended Testing Pyramid:**
1. **Unit Tests** (60%): Data sources, repositories, use cases
2. **Widget Tests** (20%): Individual screen components
3. **Integration Tests** (20%): Critical user flows

**Key Test Areas:**
- Network request handling and error scenarios
- Authentication flow (OTP verification)
- Transaction processing
- State management logic

---

## Git & Version Control

**Commit Message Format:**
```
[feature/bugfix/refactor] Brief description

- Detail 1
- Detail 2
```

**Branch Naming:**
- `feature/{feature-name}` - New features
- `bugfix/{bug-name}` - Bug fixes
- `refactor/{area}` - Refactoring
- `hotfix/{issue}` - Production hotfixes

---

## Next Development Steps

1. **Verify Figma Designs** - Compare with PDF specification when designs are provided
2. **Implement Authentication** - Phone entry + OTP screens
3. **Build Dashboard** - Home screen with jackpot and draws
4. **Recharge Flow** - Network and amount selection
5. **Gamification** - Enhanced wheel with animations
6. **Backend Integration** - Connect to API endpoints
7. **Testing** - Unit and integration tests
8. **Optimization** - Performance tuning
9. **Release Preparation** - Build for iOS/Android stores

---

## Useful Resources

- **Flutter Docs**: https://flutter.dev/docs
- **GoRouter**: https://pub.dev/packages/go_router
- **BLoC Pattern**: https://bloclibrary.dev/
- **Riverpod**: https://riverpod.dev/
- **Material Design 3**: https://m3.material.io/
- **Dio HTTP Client**: https://pub.dev/packages/dio

---

## Project Structure Quick Reference

```
recharge_max/
├── lib/
│   ├── main.dart                    # Entry point
│   ├── my_app.dart                  # Root widget
│   ├── core/                        # Infrastructure
│   │   ├── config/                  # App setup
│   │   ├── network/                 # Dio + interceptors
│   │   ├── router/                  # GoRouter config
│   │   ├── ui/                      # Theme, colors
│   │   ├── resolver/                # DI setup
│   │   └── utils/                   # Helpers
│   ├── common/                      # Shared
│   │   ├── widgets/                 # 60+ components
│   │   ├── models/                  # Shared models
│   │   └── entities/                # Shared entities
│   └── features/                    # Feature modules
│       ├── splash/                  # Splash screen
│       ├── auth/                    # Auth (prepared)
│       └── spinWheel/               # Wheel game
├── assets/                          # Static assets
├── android/                         # Android native
├── ios/                             # iOS native
└── test/                            # Tests
```

---

**Last Updated:** 2025-11-13
**Status:** Ready for Figma design verification and implementation phase

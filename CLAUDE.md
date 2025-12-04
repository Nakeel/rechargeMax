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

## Widget Reusability & Component Architecture

### Core Principle: DRY (Don't Repeat Yourself)

**CRITICAL RULE:** Every screen and widget file MUST NOT exceed **200 lines of code**. Violating this rule indicates poor abstraction and requires refactoring into smaller components.

### Widget Reusability Strategy

#### Rule 1: Always Reuse Existing Widgets from `lib/common/widgets/`

Before creating ANY new widget:
1. **Search** `lib/common/widgets/` for an existing widget that matches your needs
2. **Check if it exists:**
   - If exact match exists → Use it directly
   - If close match exists → Consider adding parameters/flags instead of creating duplicates
   - If widget doesn't exist → Create it in `lib/common/widgets/`

**Example of Reuse with Parameters:**
```dart
// Instead of creating RechargeButton, NetworkButton, WalletButton...
// Reuse AppButton with customizable properties:
AppButton(
  label: 'Recharge Now',
  backgroundColor: AppColors.colorPrimary,
  onPressed: () {},
  isOutlined: false,  // Flag for style variation
)
```

#### Rule 2: When to Create Reusable Widgets

Create a new widget in `lib/common/widgets/` when:
1. The widget will be used in **2 or more screens/features**
2. The widget encapsulates **meaningful UI logic** (not just styling)
3. The widget is **self-contained** and doesn't depend on feature-specific logic
4. The widget can be described with a **single clear purpose**

#### Rule 3: Widget Naming in Common Folder

- **Display/Layout widgets**: `{feature}_card_widget.dart`, `{item}_tile_widget.dart`
- **Input widgets**: `app_{type}_field.dart`, `custom_{component}.dart`
- **Buttons/Actions**: `app_button.dart`, `action_{name}_button.dart`
- **Containers/Backgrounds**: `{style}_container_widget.dart`, `{theme}_background.dart`
- **List/Grid items**: `product_item_widget.dart`, `category_item_widget.dart`

**Current Common Widgets Library:**
Located in `lib/common/widgets/` with 60+ reusable components.

See `## Common Development Tasks` → `### Implementing a New Screen` for integration patterns.

#### Rule 4: Handling UI Variations

**DO NOT create separate widgets for minor UI differences.** Instead, add parameters/flags:

❌ **WRONG - Creates duplicate widgets:**
```dart
// lib/common/widgets/jackpot_card.dart
class JackpotCard extends StatelessWidget { ... }

// lib/common/widgets/prize_card.dart  <- DUPLICATE!
class PrizeCard extends StatelessWidget { ... }
```

✅ **RIGHT - Use parameters:**
```dart
// lib/common/widgets/reward_card_widget.dart
class RewardCard extends StatelessWidget {
  final String title;
  final String amount;
  final Color? backgroundColor;
  final bool showCountdown;
  final String? countdownTime;
  final VoidCallback onTap;

  const RewardCard({
    required this.title,
    required this.amount,
    required this.onTap,
    this.backgroundColor,
    this.showCountdown = false,
    this.countdownTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(title),
          Text(amount),
          if (showCountdown)
            Text(countdownTime ?? '00:00'),
        ],
      ),
    );
  }
}
```

### Code Organization Rules

#### Rule 5: Maximum File Size - 200 Lines

**Every Dart file MUST NOT exceed 200 lines** (excluding imports and comments).

If a file exceeds 200 lines:
1. **Break it into smaller widgets** - Extract build methods into separate StatelessWidget classes
2. **Create helper widgets** - Move complex sections to dedicated widgets
3. **Move to common folder** - If reusable, place in `lib/common/widgets/`
4. **Create separate files** - Use multiple well-organized files instead of one monolithic file

**Line counting guidelines:**
- Includes: imports, class declarations, method bodies
- Excludes: blank lines (reasonable), documentation comments (but not excessive)

**Example of Proper Abstraction:**

❌ **WRONG - 250+ lines, everything in one file:**
```dart
// lib/features/recharge/presentation/screens/recharge_screen.dart
class RechargeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(...),  // 20 lines
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildNetworkSelector(...),    // 40 lines
            _buildAmountSelector(...),     // 60 lines
            _buildPaymentOptions(...),     // 50 lines
            _buildSummarySection(...),     // 40 lines
            _buildConfirmButton(...),      // 30 lines
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkSelector(...) { ... }    // 40 lines
  Widget _buildAmountSelector(...) { ... }     // 60 lines
  Widget _buildPaymentOptions(...) { ... }     // 50 lines
  Widget _buildSummarySection(...) { ... }     // 40 lines
  Widget _buildConfirmButton(...) { ... }      // 30 lines
}
```

✅ **RIGHT - Well-organized, each file under 200 lines:**

```
lib/features/recharge/presentation/
├── screens/
│   └── recharge_screen.dart              (120 lines)
└── widgets/
    ├── network_selector_widget.dart      (65 lines)
    ├── amount_selector_widget.dart       (75 lines)
    ├── payment_options_widget.dart       (70 lines)
    ├── summary_section_widget.dart       (60 lines)
    └── confirm_button_widget.dart        (45 lines)
```

**recharge_screen.dart (120 lines):**
```dart
class RechargeScreen extends StatefulWidget {
  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  late RechargeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<RechargeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recharge')),
      body: BlocBuilder<RechargeBloc, RechargeState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  NetworkSelectorWidget(
                    onNetworkSelected: _bloc.selectNetwork,
                  ),
                  SizedBox(height: 20.h),
                  AmountSelectorWidget(
                    onAmountSelected: _bloc.selectAmount,
                  ),
                  SizedBox(height: 20.h),
                  PaymentOptionsWidget(
                    onPaymentMethodSelected: _bloc.selectPayment,
                  ),
                  SizedBox(height: 20.h),
                  SummarySectionWidget(
                    network: state.selectedNetwork,
                    amount: state.selectedAmount,
                  ),
                  SizedBox(height: 24.h),
                  ConfirmButtonWidget(
                    onPressed: _bloc.confirmRecharge,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
```

#### Rule 6: Widget Structure Best Practices

When creating screens or components, follow this structure:

```dart
// 1. Imports
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ... other imports

// 2. Class declaration
class MyScreen extends StatelessWidget {
  const MyScreen({Key? key}) : super(key: key);

  // 3. Build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  // 4. Private helper methods (if absolutely necessary)
  PreferredSizeWidget _buildAppBar() { ... }
  Widget _buildBody() { ... }
}
```

**However, if helper methods are getting large or reusable:**
- Extract to separate widget classes instead
- Move to `lib/common/widgets/` if useful elsewhere

#### Rule 7: Feature-Specific Widgets

For widgets that are **feature-specific and not reusable**, create them in:
```
lib/features/{feature}/presentation/widgets/
```

**Example:**
```
lib/features/recharge/presentation/widgets/
├── network_selector_widget.dart
├── amount_input_widget.dart
└── payment_method_card.dart
```

These are scoped to the feature but should still follow the 200-line rule.

#### Rule 8: Identifying Future Reusable Widgets

When creating a feature-specific widget, ask:
- Could this be used in another feature?
- Is this a common UI pattern?
- Would other developers benefit from this?

**If YES:** Create in `lib/common/widgets/` instead.

**Example: During recharge development, if you create `NetworkProviderCard`:**
- Check: Is this needed elsewhere? (Wallet, Profile settings, etc.)
- YES → Create as `lib/common/widgets/network_provider_card_widget.dart`
- NO → Create as `lib/features/recharge/presentation/widgets/network_provider_card.dart`

---

### Refactoring Checklist

When implementing a new screen, ensure:

- [ ] No file exceeds 200 lines of code
- [ ] Checked `lib/common/widgets/` for reusable components
- [ ] Reused or extended existing widgets with parameters
- [ ] Created only truly reusable components in `lib/common/widgets/`
- [ ] Feature-specific components in `lib/features/{feature}/presentation/widgets/`
- [ ] All helper methods extracted as separate widget classes if large
- [ ] Each component has a single, clear responsibility
- [ ] Code is DRY - no duplicate widgets or repeated patterns
- [ ] Components are self-documented with clear naming
- [ ] Used const constructors where possible

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

**Last Updated:** 2025-12-04
**Status:** Production-ready with strict widget reusability and code organization standards enforced

## Important Implementation Standards

### Non-Negotiable Rules

1. **200-Line Maximum** - No screen or widget file shall exceed 200 lines of code
2. **Widget Reusability First** - Always check `lib/common/widgets/` before creating new components
3. **Parameterized Variations** - Use flags/parameters for UI variations instead of duplicate widgets
4. **DRY Principle** - No repeated widget patterns; extract to reusable components
5. **Feature-Scoped Widgets** - Feature-specific components in `lib/features/{feature}/presentation/widgets/`
6. **Common Library First** - Reusable components belong in `lib/common/widgets/`

### Violation Consequences

Failing to follow these rules will require:
- Code review and mandatory refactoring
- Decomposition into smaller components
- Widget consolidation and parameterization
- Re-organization into proper folder structure

**These standards ensure:** maintainability, scalability, code reusability, and consistent architecture across the project.

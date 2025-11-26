# RechargeMax Project Context

**Last Updated:** 2025-11-13
**Status:** Requirements & Design Analysis Phase
**Next Step:** Awaiting Figma designs for screen verification

---

## Project Overview

**RechargeMax Rewards** is a gamified mobile platform that transforms the mundane necessity of buying mobile airtime and data into a continuous, rewarding experience. The app enables users to earn entries into daily draws, spin prize wheels, and build loyalty through tiered membership.

**Target Platforms:**
- iOS 14+
- Android 8.0+ (Oreo)

**Project Size:** 607 MB | 125 Dart source files
**Current Version:** 1.0.0+1
**Framework:** Flutter with Dart 3.7.0+

---

## Technology Stack

### Core Framework
- **Flutter** - Cross-platform mobile development
- **Dart** - Programming language (3.7.0+)

### State Management & DI
- **flutter_bloc** (v8.1.2) - BLoC pattern
- **flutter_riverpod** (v2.5.1) - Reactive dependency injection
- **get_it** (v7.2.0) - Service locator

### Networking
- **dio** (v5.6.0) - HTTP client with interceptors
- **Comprehensive interceptor chain:**
  - Auth interceptor (JWT injection)
  - Token refresh interceptor (automatic renewal)
  - Error interceptor (centralized handling)
  - Retry interceptor (automatic retries)
  - Logging interceptor (request/response logging)

### Routing & Navigation
- **go_router** (v7.1.1) - Declarative routing

### UI & Design
- **flutter_screenutil** (v5.7.0) - Responsive design
- **flutter_svg** (v2.0.9) - SVG rendering
- **lottie** (v3.0.0) - Animations
- **Material Design 3** with custom theme

### Gamification & Media
- **flutter_fortune_wheel** (v1.3.1) - Fortune wheel widget
- **confetti** (v0.7.0) - Celebration effects
- **audioplayers** (v6.0.0) - Sound effects
- **timeline_tile** (v2.0.0) - Timeline components

### Data & Storage
- **hive** (v2.2.3) - Local NoSQL database
- **shared_preferences** (v2.0.15) - Key-value storage
- **Freezed** - Code generation for immutable models

---

## Project Structure

```
recharge_max/
├── lib/
│   ├── main.dart                     # Entry point
│   ├── my_app.dart                   # Root widget
│   │
│   ├── core/                         # Core infrastructure
│   │   ├── config/                   # App configuration & setup
│   │   ├── network/                  # Network layer with interceptors
│   │   ├── ui/                       # Theme, colors, assets
│   │   ├── router/                   # Navigation (GoRouter)
│   │   ├── storage/                  # Local persistence
│   │   ├── resolver/                 # Dependency resolution
│   │   └── utils/                    # Utility functions
│   │
│   ├── common/                       # Shared components
│   │   ├── entities/                 # Domain entities
│   │   ├── models/                   # Data models
│   │   └── widgets/                  # 60+ reusable UI components
│   │
│   └── features/                     # Feature modules (Clean Architecture)
│       ├── splash/                   # Splash screen
│       ├── auth/                     # Authentication (prepared)
│       └── spinWheel/                # Spin the Wheel game
│
├── assets/
│   ├── fonts/geist/                  # Geist font family
│   ├── fonts/roboto/                 # Roboto font
│   ├── images/                       # Image assets
│   ├── newSvg/                       # SVG assets
│   └── sounds/                       # Audio files
│
├── android/                          # Android native code
├── ios/                              # iOS native code
├── pubspec.yaml                      # Package manifest
└── analysis_options.yaml             # Linting config
```

---

## Design System

### Color Palette

**Primary Colors:**
- Primary Blue: `#1E88E5` - Primary buttons, key interactive elements
- Secondary Orange: `#FF9800` - Accents, CTAs, highlights
- Success Green: `#4CAF50` - Confirmations, success states
- Alert Red: `#F44336` - Errors, alerts, critical info

**Neutral Colors:**
- Dark Gray: `#333333` - Primary text
- Medium Gray: `#757575` - Secondary text
- Light Gray: `#E0E0E0` - Borders, dividers
- Off-White: `#F5F5F5` - Backgrounds, cards
- White: `#FFFFFF` - Page backgrounds

**Tier Colors:**
- Bronze: `#CD7F32`
- Silver: `#C0C0C0`
- Gold: `#FFD700`

### Typography

**Font Family:** Roboto (primary), System default (fallback)

**Type Scale:**
- H1: 24px, Bold (700), 32px line height
- H2: 20px, Bold (700), 28px line height
- H3: 18px, Medium (500), 24px line height
- Body 1: 16px, Regular (400), 24px line height
- Body 2: 14px, Regular (400), 20px line height
- Caption: 12px, Regular (400), 16px line height
- Button: 16px, Medium (500), 24px line height

### Spacing System

8-point grid system:
- Tiny: 4px
- Small: 8px
- Medium: 16px
- Large: 24px
- Extra Large: 32px
- Huge: 48px

### Elevation & Shadows

- Level 0: No shadow
- Level 1: `0px 2px 4px rgba(0,0,0,0.1)` - Cards
- Level 2: `0px 4px 8px rgba(0,0,0,0.1)` - FABs, dropdowns
- Level 3: `0px 8px 16px rgba(0,0,0,0.1)` - Modals, dialogs
- Level 4: `0px 16px 24px rgba(0,0,0,0.1)` - Onboarding

---

## Major Features & Screens

### 1. Authentication (Not Required for Basic Recharge)
- **Phone Number Entry Screen** - Country code pre-filled (+234)
- **OTP Verification Screen** - 6-digit code with countdown & resend

### 2. Onboarding
- **Welcome Screen** - Feature highlights
- **Feature Walkthrough** - 3 screens explaining key features

### 3. Home/Dashboard
- Jackpot section with countdown timer
- Recent winners display (masked phone numbers)
- Loyalty tier status
- Quick action buttons (Recharge, Subscribe, Buy Data, Refer & Earn)
- Subscription prompt banner

### 4. Recharge Screen
- Network selection (MTN, Airtel, Glo, 9mobile)
- Recharge type toggle (Airtime/Data)
- Phone number input
- Amount selection (quick buttons + custom input)
- Data package selection
- Payment method selection
- Real-time entries calculation
- Recent recharges list

### 5. Spin the Wheel Screen
- Interactive wheel with 6-8 segments
- Realistic spinning animation with easing
- Sound effects (mute option)
- Confetti celebration animation
- Prize announcement & details
- Share & continue actions

### 6. Draws Screen
- Active draws tab (sorted by end date)
- Past draws tab (sorted by date)
- Draw cards with countdown, prize amount, entries
- Draw details modal with full information
- Pagination/infinite scroll

### 7. Loyalty Tier Screen
- Current tier badge display
- Progress tracker to next tier
- Tier benefits comparison table
- Spending history summary
- Tips for advancing tiers

### 8. Subscription Management
- Subscription status indicator
- Benefits summary
- Pricing display (₦20/day, ~₦600/month)
- Toggle switch for activation/deactivation
- Payment method selection
- Terms & conditions

### 9. Wallet Screen
- Current balance card with Add Money/Withdraw buttons
- Points balance with expiration info
- Transaction history with filtering
- Saved payment methods
- Pull-to-refresh functionality

### 10. Affiliate Dashboard
- Status card (Active/Pending, referral code, total earnings)
- Referral link display with copy & share options
- QR code option
- Performance metrics (clicks, referrals, conversion, commission)
- Commission structure explanation
- Earnings history with filtering
- Payout section with status tracking
- Marketing materials & tips

### 11. Profile Screen
- Phone number & email display
- Account sections (Personal, Notifications, Payment, History, Help)
- Affiliate program link
- "Verify on New Device" button (instead of logout)

---

## User Personas & Journeys

### Primary Personas

1. **Regular Recharger - Adebayo**
   - 28-year-old urban professional
   - Recharges 2-3 times/week for ₦500-₦1000
   - Goal: Convenience + potential prizes

2. **Value Seeker - Chioma**
   - 35-year-old small business owner
   - Larger recharges (₦1000-₦5000) less frequently
   - Goal: Maximize value, build loyalty

3. **Affiliate Marketer - Emmanuel**
   - 22-year-old university student
   - Heavy app user, promotes actively
   - Goal: Earn commissions, track referrals

### Key User Flows

**First-Time User Journey:**
1. Discovery & Download
2. Welcome screens
3. Phone number entry
4. First recharge
5. Optional account verification (OTP)
6. Explore dashboard & draws
7. Discover affiliate program

**Regular User Flow:**
1. App launch (auto-recognized)
2. Dashboard review
3. Recharge process
4. Spin wheel (if ₦1000+)
5. Check draws & loyalty tier
6. Repeat with notifications

**Affiliate Journey:**
1. Register for affiliate program
2. Generate & share referral link
3. Monitor performance metrics
4. Track earnings
5. Request payout when threshold reached

---

## Interaction Patterns

### Navigation
- **Primary:** Bottom navigation bar (5 items: Home, Recharge, Draws, Wallet, Profile)
- **Secondary:** Tab bars for related content
- **Deep Linking:** Supported for notifications & external links

### Gestures
- **Tap/Press:** Primary interaction with visual feedback
- **Swipe:** Horizontal for tabs, vertical for scroll, pull-to-refresh
- **Long Press:** Additional options & context menus

### Feedback
- **Loading:** Skeleton screens, progress indicators, spinners
- **Success:** Animations, confirmation messages, celebratory effects
- **Error:** Clear messages with guidance, retry options

### Authentication
- **Passwordless:** Phone number + OTP only
- **Persistent:** Device-level authentication with extended timeout
- **Progressive:** Basic features without auth, personalized features require verification

---

## Accessibility Requirements

- **Visual:** 4.5:1 contrast ratio, font size adjustments, alt text for images
- **Touch:** 48x48dp minimum touch targets, adequate spacing
- **Screen Readers:** Semantic structure, proper labeling, TalkBack/VoiceOver support
- **Motion:** Reduced motion preferences supported
- **Timeouts:** Appropriate action timeouts with clear messaging

---

## Implementation Status

### ✅ Completed
- Project structure & architecture setup
- Core configuration (DI, routing, theme)
- Network layer with interceptors
- 60+ reusable UI components
- Splash screen basic implementation
- Spin the Wheel widget (basic)

### ⏳ Ready for Implementation (Awaiting Figma Designs)
- Authentication screens (Phone entry + OTP)
- Onboarding screens (Welcome + Walkthrough)
- Dashboard/Home screen
- Recharge screen
- Enhanced Spin the Wheel with animations
- Draws management screen
- Loyalty tier screen
- Subscription management
- Wallet screen
- Affiliate dashboard
- Profile screen
- Full design system application

---

## Next Steps

1. **Receive Figma Designs** - Await design file link
2. **Design Verification** - Cross-reference Figma with PDF spec
3. **Create Implementation Plan** - Prioritize screens & features
4. **Begin Development** - Start with high-priority features
5. **API Integration** - Connect to backend services
6. **Testing & QA** - Unit, widget, integration tests
7. **Release** - Build for iOS & Android

---

## Key Decisions & Constraints

- **No Traditional Login:** Passwordless authentication via phone + OTP
- **Offline-First:** App works offline, syncs when online
- **Responsive Design:** Works across various device sizes
- **Clean Architecture:** Modular feature-based structure
- **Multi-Environment:** Dev/QA/Prod configurations ready
- **Accessibility First:** WCAG compliance required

---

## Resources

- **Spec Document:** `RechargeMax_Specification.pdf` (7.9 MB)
- **Project Path:** `/Users/nakeeljr/Downloads/development/udux/recharge_max`
- **Package File:** `pubspec.yaml`
- **Main Entry:** `lib/main.dart`
- **App Root:** `lib/my_app.dart`

---

## Contact & Notes

- Awaiting **Figma design file** for screen verification
- All infrastructure ready for development
- Design system fully specified
- Ready to begin implementation once designs are verified

---

**Session Context Saved:** 2025-11-13
**Next Session:** Resume from design verification step

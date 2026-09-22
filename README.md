# 🚀 Amarjit Portfolio — Flutter Project

**Sarangthem Amarjit Meetei** — Flutter Developer & Software Engineer  
Portfolio built entirely in Flutter for Web, Android & iOS.

---

## 📁 Project Structure

```
amarjit_portfolio/
├── lib/
│   ├── main.dart                      # App entry point
│   ├── theme/
│   │   └── app_theme.dart             # Colors, gradients, ThemeData
│   ├── models/
│   │   └── app_data.dart              # All content data (experiences, projects, etc.)
│   ├── utils/
│   │   └── responsive.dart            # Breakpoint helpers
│   ├── screens/
│   │   └── portfolio_screen.dart      # Main screen with scroll controller
│   └── widgets/
│       ├── common_widgets.dart        # Shared components (buttons, cards, tags…)
│       ├── navbar.dart                # Sticky top navigation bar
│       ├── hero_section.dart          # Hero with animated phone mockup
│       ├── stats_bar.dart             # Animated stat counters
│       ├── experience_section.dart    # Animated timeline
│       ├── skills_section.dart        # Skills grid cards
│       ├── projects_section.dart      # Project cards with hover effects
│       ├── education_section.dart     # Education cards
│       ├── contact_section.dart       # Contact info + strengths panel
│       ├── particles_bg.dart          # Floating particles + gradient mesh
│       ├── flutter_fab.dart           # Floating Flutter logo button
│       └── footer.dart                # Footer
├── web/
│   ├── index.html                     # Custom loading screen
│   └── manifest.json                  # PWA manifest
├── assets/images/                     # Add your profile photo here
└── pubspec.yaml
```

---

## ⚡ Quick Start

### Prerequisites
- Flutter SDK **≥ 3.0.0** installed  
  → https://docs.flutter.dev/get-started/install
- Dart SDK (bundled with Flutter)

### 1. Install dependencies
```bash
cd amarjit_portfolio
flutter pub get
```

### 2. Run on Web (recommended)
```bash
flutter run -d chrome
```

### 3. Run on Android
```bash
flutter run -d android
```

### 4. Run on iOS
```bash
flutter run -d ios
```

### 5. Build for Web (deploy to Firebase Hosting)
```bash
flutter build web --release
# Output in: build/web/
```

### 6. Deploy to Firebase Hosting
```bash
# Install Firebase CLI first
npm install -g firebase-tools
firebase login
firebase init hosting    # select build/web as public dir
flutter build web --release
firebase deploy
```

---

## 🎨 Customization

### Update your content
All data lives in **`lib/models/app_data.dart`** — just edit:
- `AppData.experiences` — your work history
- `AppData.projects` — your projects + live URLs
- `AppData.educations` — your education
- `AppData.skillGroups` — your skills
- `AppData.strengths` — your strengths

### Add your profile photo
1. Place your photo at `assets/images/profile.jpg`
2. In `hero_section.dart`, replace the phone mockup with:
```dart
CircleAvatar(
  radius: 120,
  backgroundImage: AssetImage('assets/images/profile.jpg'),
)
```

### Change colors
Edit `lib/theme/app_theme.dart` — all colors are in one place.

---

## 📦 Dependencies

| Package | Purpose |
|---|---|
| `google_fonts` | Sora + JetBrains Mono fonts |
| `animate_do` | FadeIn/SlideIn entrance animations |
| `url_launcher` | Open GitHub, LinkedIn, live project URLs |
| `flutter_svg` | SVG icon support |
| `visibility_detector` | Trigger animations on scroll into view |

---

## 🌟 Features

- ✅ **Fully responsive** — Mobile, Tablet, Desktop
- ✅ **Smooth scroll navigation** — Navbar links scroll to sections
- ✅ **Entrance animations** — Cards & sections animate in on scroll
- ✅ **Animated phone mockup** — Bobbing Flutter-style phone in hero
- ✅ **Animated counters** — Stats count up when visible
- ✅ **Interactive hover effects** — Cards lift, buttons glow
- ✅ **Floating particles background** — Subtle animated atmosphere
- ✅ **Flutter Web PWA ready** — Custom loading screen + manifest
- ✅ **Dark theme** — Deep space aesthetic with Flutter brand colors

---

## 🚀 Live Demo
https://amarjit.web.app

---

Built with ❤️ using Flutter  
© 2026 Sarangthem Amarjit Meetei

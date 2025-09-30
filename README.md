# Savvy Shopper - Mobile App

A cross-platform Flutter mobile application for price comparison across 11(removed 1) South African retailers in three major categories: Groceries, Clothing, and Electronics/PC Components.


## Demo

<div align="center">

### 📱 Mobile App
<video src="static/savvy-shopper-demo-1_small1.mp4" controls autoplay loop muted width="300" style="border: 8px solid #1a1a1a; border-radius: 24px; box-shadow: 0 8px 16px rgba(0,0,0,0.3); margin: 20px;">
  Your browser does not support the video tag.
</video>

</div>


## 🎯 Project Overview

Savvy Shopper mobile app empowers consumers to make informed purchasing decisions by providing real-time price tracking, historical price trends, and multi-store comparisons. The app connects to a REST API backend that aggregates data from web scrapers across multiple retailers.

**Key Achievement**: This project played a pivotal role in securing my first data scientist position at Shoprite ZA, demonstrating proficiency in mobile development, state management, and API integration.

## ✨ Features

- **Multi-Retailer Price Comparison**: Browse and compare prices across 11 major South African retailers
- **Historical Price Charts**: Interactive price trend visualization using Syncfusion charts
- **Smart Shopping List**: Create grocery lists with automatic multi-store price comparison
- **Product Search**: Find specific products across all supported stores
- **Price Recommendations**: Algorithm-based "good buy" and "bad buy" indicators
- **Push Notifications**: Firebase Cloud Messaging for price alerts
- **Responsive UI**: Adaptive design for various screen sizes using ScreenUtil

## 🛍️ Supported Retailers

### Groceries (3 Stores)
- **Pick n Pay (PnP)**
- **Shoprite**
- **Woolworths**

### Clothing (5 Stores)
- **Foschini**
- **Markham**
- **Sportscene**
- **Superbalist**
- **Woolworths Clothing**

### Electronics & PC Components (3 Stores)
- **Computermania**
- **HiFi Corp**
- **Takealot**

## 🛠️ Tech Stack

### Framework & Language
- **Flutter 2.10.5** (Dart 2.x)
- **Dart SDK**: `>=2.7.0 <3.0.0`

### State Management & Architecture
- **Provider 4.3.2+3** - State management
- **Get_it 5.0.6** - Service locator / dependency injection

### UI & Visualization
- **Flutter ScreenUtil 4.0.0** - Responsive UI design
- **Flutter SVG 0.19.0** - SVG asset rendering
- **Syncfusion Flutter Charts 18.3.53** - Interactive price charts
- **Device Preview 0.5.5** - Multi-device testing

### Backend & Data
- **HTTP 0.12.2** - REST API communication
- **Shared Preferences 0.5.12+4** - Local data persistence
- **Firebase Messaging 7.0.3** - Push notifications

### Utilities
- **String Similarity 1.1.0** - Product search matching
- **Cupertino Icons 1.0.0** - iOS-style icons

### Custom Assets
- **Fonts**: Montserrat, ClickerScript
- **Icons**: Custom launcher icons via `flutter_launcher_icons`

## 📁 Project Structure

```
lib/
├── main.dart                          # App entry point
├── locator.dart                       # Service locator setup
└── src/
    ├── components/                    # Reusable UI components
    │   ├── clothing/
    │   ├── grocery_shoppinglist/
    │   ├── homescreen_components/
    │   ├── pnp/
    │   ├── shoprite/
    │   └── woolies/
    ├── constants/                     # App-wide constants
    │   └── constants.dart
    ├── mixins/                        # Shared behavior mixins
    │   ├── accessories_home_page_mixin.dart
    │   ├── clothing_graph_page_mixin.dart
    │   ├── clothing_home_page_mixin.dart
    │   ├── grocery_graph_page_mixin.dart
    │   └── grocery_home_page_mixin.dart
    ├── networking/                    # API data fetching
    │   ├── accessories/
    │   ├── clothing/
    │   └── grocery/
    ├── pages/                         # App screens
    │   ├── accessories_home_screens/
    │   ├── accessories_product_graph/
    │   ├── clothing_home_screens/
    │   ├── clothing_product_graph/
    │   ├── groceries_home_screens/
    │   ├── groceries_product_graph/
    │   ├── main_menu.dart
    │   ├── shopping_list.dart
    │   └── welcome_screen.dart
    ├── page_views/                    # PageView widgets
    │   ├── accessories_page_view.dart
    │   ├── clothing_page_view.dart
    │   └── grocery_page_view.dart
    ├── providers/                     # State management
    │   ├── accessories/
    │   ├── clothing/
    │   ├── grocery/
    │   └── grocery_shopping_list.dart
    └── services/                      # Business logic
        ├── accessories_services/
        ├── clothing_services/
        ├── grocery_services/
        ├── background_messages.dart
        └── push_notification_service.dart
```

## 🚀 Quick Start (Recommended: FVM + Windows)

### Why FVM?
This is a legacy Flutter 2.x project. Using **FVM (Flutter Version Manager)** ensures compatibility without affecting your global Flutter installation.

### Prerequisites
- **Windows 10/11** (easiest platform - no Java required)
- **Git** for version control

### 1. Install FVM
```bash
dart pub global activate fvm
```

### 2. Clone & Setup
```bash
git clone <repository-url>
cd savvy_shopper_mobile_app
```

### 3. Install Flutter 2.10.5
```bash
fvm install 2.10.5
fvm use 2.10.5
```

### 4. Get Dependencies
```bash
fvm flutter pub get
```

### 5. Run on Windows (No Java/Android Setup Required!)
```bash
fvm flutter run -d windows
```

That's it! The app will launch as a native Windows application. 🎉

## 📱 Running on Android/iOS

### Android Prerequisites
- **Android Studio** with Android SDK
- **Java Development Kit (JDK)** - Version 8 or higher
- Android device or emulator

### Android Setup
```bash
# List available devices
fvm flutter devices

# Run on Android
fvm flutter run -d <device-id>
```

### iOS Prerequisites (macOS only)
- **Xcode 12+**
- iOS device or simulator
- CocoaPods

### iOS Setup
```bash
# Install iOS dependencies
cd ios
pod install
cd ..

# Run on iOS
fvm flutter run -d <ios-device-id>
```

## 🔧 Development

### Hot Reload
Press `r` in the terminal for hot reload during development.

### Debug Mode
```bash
fvm flutter run --debug
```

### Release Build
```bash
# Android APK
fvm flutter build apk --release

# iOS
fvm flutter build ios --release

# Windows
fvm flutter build windows --release
```

## 🎨 Key Screens

1. **Welcome Screen** - App introduction
2. **Main Menu** - Category selection (Groceries/Clothing/Accessories)
3. **Store Home Screens** - Product listings per retailer
4. **Product Graph Pages** - Historical price charts and comparisons
5. **Shopping List** - Multi-store price comparison for grocery items

## 📊 State Management Architecture

The app uses **Provider** for state management with the following providers:

**Grocery Providers:**
- `ShopriteAllProductList`
- `PnPAllProductList`
- `WooliesAllProductList`
- `GroceryShoppingList`
- `GroceryShoppingListFilter`

**Clothing Providers:**
- `FoschiniAllProductList`
- `MarkhamAllProductList`
- `SportsceneAllProductList`
- `SuperbalistAllProductList`
- `WoolworthsClothingAllProductList`

**Accessories Providers:**
- `TakealotAllProductList`
- `HifiAllProductList`
- `ComputermaniaAllProductList`

## 🔌 API Integration

The app consumes REST API endpoints from the Savvy Shopper backend:

- **Base URL**: Configure in `lib/src/constants/constants.dart`
- **HTTP Client**: `http` package for API requests
- **Data Models**: Store-specific models in `lib/src/networking/`

## 🔔 Firebase Setup

### Prerequisites
- Firebase project with Cloud Messaging enabled
- `google-services.json` (Android) in `android/app/`
- `GoogleService-Info.plist` (iOS) in `ios/Runner/`

### Configuration
Push notifications are handled by:
- `lib/src/services/push_notification_service.dart`
- `lib/src/services/background_messages.dart`

## 🐛 Troubleshooting

### Old Flutter Version Issues
If you encounter SDK compatibility errors:
```bash
fvm use 2.10.5
fvm flutter clean
fvm flutter pub get
```

### Gradle Build Errors (Android)
For Java/Gradle compatibility issues, consider running on **Windows desktop** instead:
```bash
fvm flutter run -d windows
```

### Missing Assets
Ensure all assets are present:
```bash
flutter pub get
```

## 📦 Building for Production

### Android Release
```bash
fvm flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### iOS Release (macOS)
```bash
fvm flutter build ios --release
```

### Windows Release
```bash
fvm flutter build windows --release
# Output: build/windows/runner/Release/
```

## 🎓 Learning Outcomes

This project demonstrates:
- Cross-platform mobile development (iOS/Android/Windows)
- State management patterns (Provider)
- RESTful API integration
- Data visualization (Syncfusion Charts)
- Push notifications (Firebase Cloud Messaging)
- Responsive UI design
- Service locator pattern (Get_it)
- Legacy code maintenance and FVM usage

## 📄 License

All rights reserved. This project is for portfolio demonstration purposes.

## 👨‍💻 Developer

**Taku**

Developed as part of the Savvy Shopper full-stack ecosystem, encompassing mobile development, API integration, and real-time data visualization.

## 🔗 Related Projects

- **Backend API**: Flask REST API serving product data
- **Web Scrapers**: Scrapy-based data collection system
- **Chrome Extension**: Browser-based price comparison tool

---

**Built with ❤️ using Flutter**

Flutter 2.10.5 + Provider + Firebase | 2020
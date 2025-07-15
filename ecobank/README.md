# Ecobank Mobile (Flutter Demo)

A cross-platform Flutter application that simulates a mobile banking experience for Ecobank, supporting multiple African countries. This app is for demonstration and educational purposes only.

## Features

- **Multi-country support**: Ghana, Nigeria, Ivory Coast, Algeria (dynamic flag and currency symbol)
- **Onboarding**: Simple login with country and phone number selection
- **Home Dashboard**:
  - Account overview with balance (toggle visibility)
  - Quick actions: Airtime/Data, Transfer, Pay Bill, Xpress Cash, EcobankPay, Split Payments
  - Recent activity list (transactions)
- **Transactions**:
  - Airtime/Data purchase (for self or others)
  - Bank transfers (Ecobank, other local banks, mobile money)
  - Bill payments (Electricity, Water, Internet, TV)
  - Xpress Cash (cash withdrawal code)
  - EcobankPay (QR and phone payments)
  - Split payments (share bill among friends)
- **Card Services**: Virtual, debit, and prepaid card management (UI only)
- **Notifications**: Transaction and activity notifications
- **Help**: Contact info, chat, and support
- **More**: Settings, manage beneficiaries, loans, statements, legal, contact, and location

## Project Structure

```
lib/
  main.dart                # App entry point and navigation
  screens/
    LoginScreen.dart       # Login/onboarding
    SignUpScreen.dart      # Registration
    HomeScreen.dart        # Main dashboard
    CardServicesScreen.dart
    HelpScreen.dart
    NotificationsScreen.dart
    MoreScreen.dart
    transactions/          # All transaction flows
      airtime_data_screen.dart
      pay_bill_screen.dart
      xpress_cash_screen.dart
      ecobank_pay_screen.dart
      split_payments_screen.dart
      transfer_options_screen.dart
      ...
```

## Getting Started

### Prerequisites
- Flutter SDK (latest stable)
- Dart SDK
- Android Studio, VS Code, or compatible IDE
- Android/iOS emulator or device

### Setup
1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd ecobank
   ```
2. **Install dependencies**
   ```bash
   flutter pub get
   ```
3. **Run the app**
   ```bash
   flutter run
   ```

## Notes
- This app is a UI/UX demo only. No real banking or backend integration.
- All data is local and resets on restart.
- For educational and non-commercial use only.

---

© 2024 Ecobank Mobile Demo. Not affiliated with Ecobank Group.

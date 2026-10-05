# Banking Demo Flutter — Windows-friendly project

This is an educational Flutter banking UI demo. It is **not an official IDBI Bank application**, does not connect to IDBI or any payment network, and must not be used to collect real bank credentials, PINs, OTPs, card data, or account details.

## What is included
- Flutter/Dart source
- Login with any 4-digit **demo** MPIN
- Dashboard and fictional balance
- Fictional transaction history
- Transfer simulation (never sends money)
- Services, cards/deposits placeholders, profile/logout
- Persistent visible DEMO / STUDENT PROJECT notice
- User-provided reference image in `assets/images/project_logo.jpeg`

## Windows setup
1. Install Flutter SDK from the official Flutter documentation.
2. Install Android Studio (useful for Android emulator/SDK) and VS Code or Android Studio as your editor.
3. Extract this ZIP.
4. Open PowerShell in the extracted `BankingDemoFlutter` folder.
5. Run:
   `flutter doctor`
6. This package intentionally contains platform-neutral source. Generate local platform scaffolding with:
   `flutter create .`
7. Run on Windows (if Windows desktop support is enabled):
   `flutter run -d windows`
   Or run on an Android emulator/device:
   `flutter run`

## iPhone build
You can write and test most Flutter code on Windows, but Apple requires macOS/Xcode for the final iOS build/signing. Copy the same project to a Mac or macOS CI/build service, run `flutter create .` if the iOS folder is not present, then `flutter build ios` / Xcode signing.

For installation on an iPhone, the resulting app must be signed/provisioned with an Apple account/developer identity. An unsigned IPA cannot simply be installed like an Android APK.

## Important project safety
Keep the DEMO labeling. Do not change this into an app that impersonates a real bank or asks users for real banking credentials.

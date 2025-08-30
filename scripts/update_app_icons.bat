@echo off
REM Shartflix App Icon Update Script for Windows
REM This script updates the app icons using SinFlixLogo.png

echo 🎬 Updating Shartflix App Icons...

REM Check if SinFlixLogo.png exists
if not exist "assets\logo\SinFlixLogo.png" (
    echo ❌ Error: SinFlixLogo.png not found in assets\logo\
    pause
    exit /b 1
)

REM Install dependencies
echo 📦 Installing dependencies...
flutter pub get

REM Generate app icons
echo 🎨 Generating app icons...
flutter pub run flutter_launcher_icons:main

REM Clean up old icons (optional)
echo 🧹 Cleaning up old icons...
for /r "android\app\src\main\res" %%f in (ic_launcher.png) do del "%%f" 2>nul

echo ✅ App icons updated successfully!
echo 📱 Icons generated for:
echo    - Android (all densities)
echo    - iOS (all sizes)
echo    - Web (192x192, 512x512)
echo    - Windows (48x48)
echo    - macOS (1024x1024)

echo.
echo 🚀 Next steps:
echo    1. Clean and rebuild your project:
echo       flutter clean && flutter pub get
echo    2. Test on different platforms:
echo       flutter run
echo    3. Build release versions:
echo       flutter build apk --release
echo       flutter build ios --release

pause

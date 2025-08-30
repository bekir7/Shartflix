#!/bin/bash

# Shartflix App Icon Update Script
# This script updates the app icons using SinFlixLogo.png

echo "🎬 Updating Shartflix App Icons..."

# Check if SinFlixLogo.png exists
if [ ! -f "assets/logo/SinFlixLogo.png" ]; then
    echo "❌ Error: SinFlixLogo.png not found in assets/logo/"
    exit 1
fi

# Install dependencies
echo "📦 Installing dependencies..."
flutter pub get

# Generate app icons
echo "🎨 Generating app icons..."
flutter pub run flutter_launcher_icons:main

# Clean up old icons (optional)
echo "🧹 Cleaning up old icons..."
find android/app/src/main/res -name "ic_launcher.png" -delete 2>/dev/null || true

echo "✅ App icons updated successfully!"
echo "📱 Icons generated for:"
echo "   - Android (all densities)"
echo "   - iOS (all sizes)"
echo "   - Web (192x192, 512x512)"
echo "   - Windows (48x48)"
echo "   - macOS (1024x1024)"

echo ""
echo "🚀 Next steps:"
echo "   1. Clean and rebuild your project:"
echo "      flutter clean && flutter pub get"
echo "   2. Test on different platforms:"
echo "      flutter run"
echo "   3. Build release versions:"
echo "      flutter build apk --release"
echo "      flutter build ios --release"

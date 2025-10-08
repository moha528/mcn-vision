#!/usr/bin/env bash

# Script to disable code signing in Xcode project for Codemagic builds
# This allows building without Development Team configured

set -e

echo "🔧 Disabling code signing in Xcode project..."

PROJECT_FILE="ios/Runner.xcodeproj/project.pbxproj"

if [ ! -f "$PROJECT_FILE" ]; then
    echo "❌ Error: $PROJECT_FILE not found!"
    exit 1
fi

# Backup original file
cp "$PROJECT_FILE" "$PROJECT_FILE.backup"
echo "✅ Backup created: $PROJECT_FILE.backup"

# Disable code signing for Release configuration
sed -i.tmp 's/CODE_SIGN_IDENTITY = "iPhone Distribution"/CODE_SIGN_IDENTITY = ""/g' "$PROJECT_FILE"
sed -i.tmp 's/CODE_SIGN_IDENTITY = "iPhone Developer"/CODE_SIGN_IDENTITY = ""/g' "$PROJECT_FILE"
sed -i.tmp 's/CODE_SIGN_IDENTITY\[sdk=iphoneos\*\] = "iPhone Developer"/CODE_SIGN_IDENTITY\[sdk=iphoneos\*\] = ""/g' "$PROJECT_FILE"

# Set code signing to manual
sed -i.tmp 's/CODE_SIGN_STYLE = Automatic/CODE_SIGN_STYLE = Manual/g' "$PROJECT_FILE"

# Remove development team requirement
sed -i.tmp 's/DEVELOPMENT_TEAM = .*/DEVELOPMENT_TEAM = "";/g' "$PROJECT_FILE"

# Disable automatic code signing
sed -i.tmp 's/ProvisioningStyle = Automatic/ProvisioningStyle = Manual/g' "$PROJECT_FILE"

# Clean up temp files
rm -f "$PROJECT_FILE.tmp"

echo "✅ Code signing disabled successfully!"
echo "📝 Modified: $PROJECT_FILE"
echo ""
echo "You can now run: flutter build ios --release --no-codesign"

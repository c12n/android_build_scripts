#!/usr/bin/env bash
# Builds an unsigned (ad-hoc signed) BouncingBall.ipa. Requires macOS with Xcode.
set -euo pipefail

cd "$(dirname "$0")"
APP_NAME=BouncingBall
BUILD_DIR=build
APP_DIR="$BUILD_DIR/Payload/$APP_NAME.app"

rm -rf "$BUILD_DIR"
mkdir -p "$APP_DIR"

SDK_PATH=$(xcrun --sdk iphoneos --show-sdk-path)
xcrun --sdk iphoneos swiftc \
    -parse-as-library \
    -target arm64-apple-ios15.0 \
    -sdk "$SDK_PATH" \
    -O \
    Sources/*.swift \
    -o "$APP_DIR/$APP_NAME"

cp Info.plist "$APP_DIR/Info.plist"
plutil -convert binary1 "$APP_DIR/Info.plist"
printf 'APPL????' > "$APP_DIR/PkgInfo"

# Ad-hoc signature; sideloading tools (AltStore, Sideloadly, etc.) re-sign with your own certificate.
codesign --force --sign - --timestamp=none "$APP_DIR"

(cd "$BUILD_DIR" && zip -qry "$APP_NAME.ipa" Payload)
echo "Built $(pwd)/$BUILD_DIR/$APP_NAME.ipa"

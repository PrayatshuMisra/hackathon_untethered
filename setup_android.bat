@echo off
echo === Setting up Android Development for Untethered AI ===
echo.

echo This will help you set up Android Studio to build native APK files.
echo.

echo Step 1: Download Android Studio
echo Please download Android Studio from:
echo https://developer.android.com/studio
echo.

echo Step 2: Install Android Studio
echo - Run the downloaded installer
echo - Follow the installation wizard
echo - Make sure to install Android SDK
echo.

echo Step 3: Set up Android SDK
echo - Open Android Studio
echo - Go to Tools > SDK Manager
echo - Install Android SDK Platform-Tools
echo - Install at least one Android SDK Platform (API 21+)
echo.

echo Step 4: Set environment variables
echo - Set ANDROID_HOME to your Android SDK location
echo - Usually: C:\Users\%USERNAME%\AppData\Local\Android\Sdk
echo.

echo Step 5: Build APK
echo After setup, run: flutter build apk --release
echo.

echo The APK will be created at: build\app\outputs\flutter-apk\app-release.apk
echo.

pause 
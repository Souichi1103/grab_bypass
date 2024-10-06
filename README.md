# Grab App Bypass Using Frida

This project automates the installation of Frida server and includes scripts to bypass several security measures within the Grab app (`com.grabtaxi.passenger`).

## Prerequisites
- Your device must be **ARM64** architecture.
- The device must be **rooted**.
- Ensure **ADB** is installed and your device is connected via ADB.

## What This Script Bypasses
- **Banning accounts**: This bypass helps prevent your account from being banned within the app.
- **Frida detection**: It bypasses any attempt by the app to detect the presence of Frida.
- **`libpsec` library detection**: Bypasses security checks related to the `libpsec` library in the app.

## How to Use

1. Connect your rooted ARM64 device via ADB.
2. Run the `init.bat` script, which will:
   - Check if ADB is connected.
   - Verify if your device is rooted.
   - Ensure your device architecture is ARM64.
   - Automatically install and set up the Frida server on your device if it doesn’t already exist.
   - Push the `maps` file to `/data/local/tmp`.

3.  Once the installation is complete, you can run Frida with the following command:
   ```bash
   **Terminal 1:**
   adb shell "su -c /data/local/tmp/fda-tanginamo &"
   **Terminal 2:**
   frida -l grab_main.js -f com.grabtaxi.passenger -U
   

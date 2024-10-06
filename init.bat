@echo off
setlocal enabledelayedexpansion

:: Check if ADB is connected
echo Checking if ADB is connected...
adb get-state >nul 2>&1
if !errorlevel! neq 0 (
    echo ADB is not connected. Please connect your device and try again.
    pause
    exit /b
)

:: Check if device is rooted
echo Checking if device is rooted...
adb shell su -c "id" >nul 2>&1
if !errorlevel! neq 0 (
    echo Device is not rooted. Please root your device and try again.
    pause
    exit /b
)

:: Check device architecture
echo Checking device architecture...
for /f "delims=" %%a in ('adb shell getprop ro.product.cpu.abi') do set ARCH=%%a
if /i "!ARCH!" neq "arm64-v8a" (
    echo Device is not ARM64 architecture. Exiting.
    pause
    exit /b
)

:: Check if Frida server already exists
echo Checking if Frida server already exists...
adb shell ls /data/local/tmp/frida-server >nul 2>&1
if !errorlevel! equ 0 (
    echo Frida server already exists on the device. Skipping installation.
) else (
    :: Install the latest Frida server for ARM64
    echo Installing Frida server...
    set FRIDA_SERVER_URL=https://github.com/frida/frida/releases/download/16.5.2/frida-server-16.5.2-android-arm64.xz

    :: Download the Frida server
    curl -L -o frida-server.xz !FRIDA_SERVER_URL!
    if !errorlevel! neq 0 (
        echo Failed to download Frida server. Exiting.
        pause
        exit /b
    )

    :: Extract the Frida server from the .xz file using 7-Zip
    "7z.exe" e frida-server.xz
    if !errorlevel! neq 0 (
        echo Failed to extract Frida server. Exiting.
        pause
        exit /b
    )

    :: Move the Frida server to /data/local/tmp
    adb push frida-server /data/local/tmp/
    if !errorlevel! neq 0 (
        echo Failed to push Frida server to device. Exiting.
        pause
        exit /b
    )

    :: Set permissions
    adb shell chmod 777 /data/local/tmp/frida-server
    echo Frida server installed successfully!
)

:: Move the maps file from the current directory to /data/local/tmp
if exist maps (
    adb push maps /data/local/tmp/
    adb shell chmod 777 /data/local/tmp/maps
    echo Maps file pushed and permissions set.
) else (
    echo No maps file found in the current directory.
)

echo Installation complete!
pause

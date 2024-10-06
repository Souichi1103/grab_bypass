# Grab App Frida Hooking

## Requirements
- **ADB**: Ensure ADB is connected to your device.
- **Root Access**: Your device must be rooted.
- **Architecture**: Only ARM64 devices are supported. The script automatically detects if your device is compatible.

## How to Run
1. Open a terminal or command prompt.
2. Navigate to the directory containing your files.
3. Run the `init.bat` file to automatically install and configure the necessary files, including the Frida server.
4. Once everything is set up, run the following command to start Frida:

   ```bash
   frida -l grab_main.js -f com.grabtaxi.passenger -U

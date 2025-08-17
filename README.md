# CyberPatriot Windows 10 Security Automation Batch File 🖥️🔒

## Description 📜  
This repository contains a **Windows 10 batch file** designed for use in the **CyberPatriot competition**. The script automates a series of essential security tasks to help secure and configure a Windows 10 machine for competition requirements.

## Setup Instructions ⚙️

1. **Copy the Batch Script**  
   ✂️ Open Notepad (or any text editor) and copy the entire batch file content from this repository.

2. **Save the Batch File**  
   💾 In Notepad, go to `File > Save As`.  
   📍 Choose a location (e.g., Desktop) and change the file extension from `.txt` to `.bat` (e.g., `cyberpatriot_setup.bat`).

3. **Run the Batch File**  
   🚀 Right-click the saved `.bat` file and select `Run as Administrator`.  
   The script will automatically execute the necessary security tasks to configure your system.

## Features ✨  
- **Automated Security Configurations**: Automates key security settings for Windows 10 to meet competition standards.  
- **CyberPatriot Compliance**: Tailored specifically for CyberPatriot competition environments.  
- **Windows 10 Compatibility**: Works seamlessly with Windows 10 systems.  
- **Customizable**: Easily editable for further tasks or customizations based on your needs.

## Example Code 📝  
Here’s a glimpse of what the batch script does (full script available in the repository):

```batch
:menu
cls
echo Welcome to the System Configuration Script
echo Options:
echo "1) Set user properties      2) Create a user"
echo "3) Disable a user           4) Change all passwords"
echo "5) Disable guest/admin      6) Set password policy"
echo "7) Password Policy 2        8) Group check status"
echo "9) Set lockout policy       10) Enable Firewall"
echo "11) Search for media files  12) Disable services"
echo "13) Turn on UAC             14) Remote Desktop Config"
echo "15) Enable auto update       16) Security options"
echo "17) Audit the machine        18) Auto Login netpwiz"
echo "19) Disable port 1900        20) Adaptor Settings"
echo "21) Windows Services         22) Disable Tiles"
echo "23) Disable AutoPlay         0) Exit"
echo "70) Reboot"

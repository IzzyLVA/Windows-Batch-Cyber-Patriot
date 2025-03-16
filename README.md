# This is a Windows 10 Batch File for the CyberPatriot Competition

## Description

This repository contains a batch file for use in CyberPatriot competitions, specifically designed for Windows 10 systems. The batch file performs a series of automated tasks to help secure and configure a Windows 10 machine.

## Setup Instructions

1. **Copy the Batch Script**:
   - Open Notepad or any text editor.
   - Copy the entire batch file content from this repository.

2. **Save the Batch File**:
   - In Notepad, go to **File** > **Save As**.
   - Choose a location to save the file (e.g., Desktop).
   - Change the file extension from `.txt` to `.bat` (e.g., `cyberpatriot_setup.bat`).

3. **Run the Batch File**:
   - Right-click the saved `.bat` file and select **Run as Administrator**.
   - The script will automatically execute the necessary tasks.

## Features

- Automates the setup of specific security configurations.
- Compatible with Windows 10 for CyberPatriot competitions.

## Example Code

Here’s a snippet of the batch script:

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

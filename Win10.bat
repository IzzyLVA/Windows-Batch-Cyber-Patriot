@echo off
setlocal enabledelayedexpansion

echo Welcome to the System Configuration Script

:: Check for admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Access Denied. Please run the script with administrator privileges.
    pause
    exit /b 1
)

:: Logging setup
set logFile=C:\config_script_log.txt
echo [%date% %time%] Starting script execution >> %logFile%

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

set /p answer=Please choose an option: 

if "%answer%"=="1" goto :userProp
if "%answer%"=="2" goto :createUser
if "%answer%"=="3" goto :disUser
if "%answer%"=="4" goto :passwd
if "%answer%"=="5" goto :disGueAdm
if "%answer%"=="6" goto :passwdPol
if "%answer%"=="7" goto :passwdPol2
if "%answer%"=="8" goto :groupStat
if "%answer%"=="9" goto :lockout
if "%answer%"=="10" goto :firewall
if "%answer%"=="11" goto :badFiles
if "%answer%"=="12" goto :services
if "%answer%"=="13" goto :UAC
if "%answer%"=="14" goto :remDesk
if "%answer%"=="15" goto :autoUpdate
if "%answer%"=="16" goto :secOpt
if "%answer%"=="17" goto :audit
if "%answer%"=="18" goto :autoLog
if "%answer%"=="19" goto :disPort
if "%answer%"=="20" goto :adaptSet
if "%answer%"=="21" goto :winServ
if "%answer%"=="22" goto :tiles
if "%answer%"=="23" goto :autoPlay
if "%answer%"=="0" exit /b
if "%answer%"=="70" goto :shutdown

echo Invalid option. Please try again.
pause
goto :menu

:userProp
echo Setting password never expires
wmic UserAccount set PasswordExpires=True
wmic UserAccount set PasswordChangeable=True
wmic UserAccount set PasswordRequired=True
if %errorlevel% neq 0 (
    echo Error setting user properties. Please check your system and try again. >> %logFile%
    pause
    goto :menu
)
echo User properties set successfully.
echo [%date% %time%] User properties configured >> %logFile%
pause
goto :menu

:createUser
set /p answer=Would you like to create a user? [y/n]: 
if /i "%answer%"=="y" (
    set /p NAME=What is the user you would like to create?:
    set /p PASS=Enter a password for !NAME!:
    rem Check if username or password is empty
    if "!NAME!"=="" (
        echo Username cannot be empty. Exiting.
        pause
        goto :menu
    )
    if "!PASS!"=="" (
        echo Password cannot be empty. Exiting.
        pause
        goto :menu
    )
    net user !NAME! !PASS! /add
    if %errorlevel% neq 0 (
        echo Error creating user !NAME!. >> %logFile%
        echo Failed to create user !NAME!.
        pause
        goto :menu
    )
    echo !NAME! has been added
    echo [%date% %time%] User !NAME! created >> %logFile%
    pause
) 
goto :menu

:disUser
for %%A in (Account1 Account2) do (
    net user %%A /active:no
    if %errorlevel% neq 0 (
        echo Failed to disable account %%A. >> %logFile%
        echo Failed to disable %%A.
        pause
        goto :menu
    )
    net user %%A Password!
    if %errorlevel% neq 0 (
        echo Failed to set password for account %%A. >> %logFile%
        echo Failed to set password for %%A.
        pause
        goto :menu
    )
)
echo All specified accounts have been disabled and set to password "Password!".
echo [%date% %time%] Disabled accounts: Account1, Account2 >> %logFile%
pause
goto :menu

:passwd
set /p pass=Enter a new password for all users: 
for /f "tokens=1" %%A in ('net user ^| findstr /r "^[A-Za-z0-9]"') do (
    if /i not "%%A"=="Administrator" if /i not "%%A"=="Guest" (
        net user "%%A" !pass!
        if %errorlevel% neq 0 (
            echo Failed to change password for user %%A. >> %logFile%
            echo Failed to change password for %%A.
            pause
            goto :menu
        )
    )
)
echo All user passwords have been set to !pass!
echo [%date% %time%] Changed all user passwords to !pass! >> %logFile%
pause
goto :menu

:lockout
net accounts /lockoutthreshold:3
net accounts /lockoutduration:30
net accounts /lockoutwindow:30
if %errorlevel% neq 0 (
    echo Error setting lockout policy. >> %logFile%
    echo Failed to set lockout policies.
    pause
    goto :menu
)
echo Lockout policies have been set.
echo [%date% %time%] Lockout policies configured >> %logFile%
pause
goto :menu

:firewall
netsh advfirewall set allprofiles state on
if %errorlevel% neq 0 (
    echo Error enabling the firewall. >> %logFile%
    echo Failed to enable firewall.
    pause
    goto :menu
)
echo Firewall has been enabled.
echo [%date% %time%] Firewall enabled >> %logFile%
pause
goto :menu

:badFiles
echo Searching for media files...
dir /s /b /a-d "C:\*.mp3" "C:\*.mp4" "C:\*.avi"
if %errorlevel% neq 0 (
    echo Error searching for media files. >> %logFile%
    echo Failed to search for media files.
    pause
    goto :menu
)
echo Media files search completed.
echo [%date% %time%] Media files search completed >> %logFile%
pause
goto :menu

:services
sc query "Routing and Remote Access" >nul 2>&1 && sc config "Routing and Remote Access" start= disabled
sc config "Net.Tcp Port Sharing Service" start= disabled
net start "DHCP"
sc config "MpsSvc" start= auto
netsh advfirewall set allprofiles state on
if %errorlevel% neq 0 (
    echo Error configuring services. >> %logFile%
    echo Failed to configure services.
    pause
    goto :menu
)
echo Services have been configured.
echo [%date% %time%] Services configured >> %logFile%
pause
goto :menu

:UAC
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f
if %errorlevel% neq 0 (
    echo Error enabling UAC. >> %logFile%
    echo Failed to enable User Account Control (UAC).
    pause
    goto :menu
)
echo User Account Control (UAC) has been turned on. Restart required.
echo [%date% %time%] UAC enabled >> %logFile%
pause
goto :menu

:remDesk
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
netsh advfirewall firewall set rule group="Remote Desktop" new enable=yes
if %errorlevel% neq 0 (
    echo Error enabling Remote Desktop. >> %logFile%
    echo Failed to enable Remote Desktop.
    pause
    goto :menu
)
echo Remote Desktop is now enabled.
echo [%date% %time%] Remote Desktop enabled >> %logFile%
pause
goto :menu

:autoUpdate
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 2 /f
if %errorlevel% neq 0 (
    echo Error enabling auto updates. >> %logFile%
    echo Failed to enable automatic updates.
    pause
    goto :menu
)
echo Automatic updates have been enabled.
echo [%date% %time%] Auto updates enabled >> %logFile%
pause
goto :menu

:disPort
netsh advfirewall firewall add rule name="Block Port 1900" dir=in action=block protocol=UDP localport=1900
if %errorlevel% neq 0 (
    echo Error blocking port 1900. >> %logFile%
    echo Failed to block port 1900.
    pause
    goto :menu
)
echo Port 1900 has been blocked.
echo [%date% %time%] Blocked port 1900 >> %logFile%
pause
goto :menu

:shutdown
set /p confirm=Are you sure you want to restart the system? [y/n]:
if /i "%confirm%"=="y" (
    shutdown /r /t 0
    echo [%date% %time%] System is restarting. >> %logFile%
) else (
    echo Restart cancelled.
    echo [%date% %time%] Restart cancelled. >> %logFile%
)
pause
goto :menu

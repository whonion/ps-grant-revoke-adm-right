@echo off
setlocal EnableDelayedExpansion

:: Get the current domain and username of the logged-in user
for /F "tokens=1* delims=\" %%A in ("%USERDOMAIN%\%USERNAME%") do (
    set "currentDomain=%%A"
    set "currentUsername=%%B"
)

:: Check if the script is running with administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrator privileges.
    echo Please run the script as an administrator.
    pause
    exit /b 1
)

:: Add the domain user to the local Administrators group
net localgroup Administrators "%currentDomain%\%currentUsername%" /add
if %errorlevel% equ 0 (
    echo User '%currentDomain%\%currentUsername%' has been added to the local Administrators group on this machine.
) else (
    echo Failed to add user '%currentDomain%\%currentUsername%' to the local Administrators group.
)

:: Pause the script so that you can see the output before it closes
pause

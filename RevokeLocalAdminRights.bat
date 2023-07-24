@echo off
:: Check if the script is running with administrator privileges
net session >nul 2>&1
If %errorlevel% neq 0 (
    echo This script requires administrator privileges. Please run the script as administrator.
    Exit /B 1
)

:: Get the current domain user account name
set "domainUser=%USERDOMAIN%\%USERNAME%"

:: Define the name of the local machine
set "localMachine=%COMPUTERNAME%"

:: Remove the domain user from the local administrators group
net localgroup administrators "%localMachine%\%domainUser%" /delete
# Check if the script is running with administrator privileges
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script requires administrator privileges. Please run the script as administrator."
    Exit 1
}

# Get the current domain user account name
$domainUser = $env:USERDOMAIN + '\' + $env:USERNAME

# Define the name of the local machine
$localMachine = $env:COMPUTERNAME

# Remove the domain user from the local administrators group
net localgroup administrators "$localMachine\$domainUser" /delete
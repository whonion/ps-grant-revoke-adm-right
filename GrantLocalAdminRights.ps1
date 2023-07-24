# Get the current domain and username of the logged-in user
$currentDomain = $env:USERDOMAIN
$currentUsername = $env:USERNAME
$domainUser = "$currentDomain\$currentUsername"

# Check if the script is running with administrative privileges
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if (-not $isAdmin) {
    Write-Host "This script requires administrator privileges."
    Write-Host "Please run the script as an administrator."
    exit
}

# Add the domain user to the local Administrators group
$administratorsGroup = [ADSI]"WinNT://$env:COMPUTERNAME/Administrators,group"
$administratorsGroup.Invoke("Add", [ADSI]"WinNT://$domainUser")

if ($?) {
    Write-Host "User '$domainUser' has been added to the local Administrators group on this machine."
} else {
    Write-Host "Failed to add user '$domainUser' to the local Administrators group."
}

# Pause the script so that you can see the output before it closes
Pause
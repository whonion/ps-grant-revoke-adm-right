# This script grants local administrator rights to the current domain user,
# executes the specified script, and then revokes the administrator rights.

param (
    [string]$ScriptPath
)

# Function to grant local administrator rights
function Grant-AdminRights {
    $adminGroup = [System.Security.Principal.WindowsBuiltInRole]::Administrator
    $currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principle = New-Object System.Security.Principal.WindowsPrincipal($currentUser)

    if (!$principle.IsInRole($adminGroup)) {
        $group = "Administrators"
        $user = $env:USERDOMAIN + "\" + $env:USERNAME
        net localgroup $group $user /add
    }
}

# Function to revoke local administrator rights
function Revoke-AdminRights {
    $adminGroup = [System.Security.Principal.WindowsBuiltInRole]::Administrator
    $currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principle = New-Object System.Security.Principal.WindowsPrincipal($currentUser)

    if ($principle.IsInRole($adminGroup)) {
        $group = "Administrators"
        $user = $env:USERDOMAIN + "\" + $env:USERNAME
        net localgroup $group $user /delete
    }
}

Grant-AdminRights
& $ScriptPath
Revoke-AdminRights
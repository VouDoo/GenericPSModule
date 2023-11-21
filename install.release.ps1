<#
.SYNOPSIS
    Install release module.

.DESCRIPTION
    Install module from release directory.

.EXAMPLE
    PS> ./install.release.ps1

    Install module for the current user only.

.EXAMPLE
    PS> ./import.release.ps1 -AllUsers

    Install module for all the users on the system.

.LINK
    - https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_modules

#>

[CmdletBinding()]
param (
    [Parameter()]
    [switch] $AllUsers
)

# Load settings
$Settings = & (Join-Path -Path $PSScriptRoot -ChildPath "settings.ps1")

# Check if release module exists
if (-not (Test-Path -Path $Settings.Release -PathType Container)) {
    Write-Error -ErrorAction Stop -Message "Release module does not exist. Build it first."
}

# Define ModuleRoot depending on scope
$ModuleRoot = if ($AllUsers.IsPresent) {
    "$env:PROGRAMFILES\PowerShell\Modules"
}
else {
    "$HOME\Documents\PowerShell\Modules"
}

# Define destination directory
$Destination = "$ModuleRoot\{0}\{1}" -f $Settings.ModuleName, $Settings.ModuleVersion

# Remove destination directory if exists
if (Test-Path -Path $Destination -PathType Container) {
    Remove-Item -Path $Destination -Recurse
}

# Copy release module files to destination directory
Copy-Item -Path $Settings.Release -Destination $Destination -Recurse

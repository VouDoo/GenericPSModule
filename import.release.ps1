<#
.SYNOPSIS
    Import release module.

.DESCRIPTION
    Import module from release module file or manifest in the current PS Session.

.EXAMPLE
    PS> ./import.release.ps1 -Source Module

    Import module from psm1 file.
    This is useful when you need to test all the functions.

.EXAMPLE
    PS> ./import.release.ps1 -Source Manifest

    Import module from psd1 file.
    It imports the module as it is expressed in the manifest.

.LINK
    - https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_modules

#>

[CmdletBinding()]
param (
    [Parameter()]
    [ValidateSet(
        "Module", "psm1",
        "Manifest", "psd1"
    )]
    [string] $Source = "Module"
)

# Load settings
$Settings = & (Join-Path -Path $PSScriptRoot -ChildPath "settings.ps1")

# Check if release module exists
if (-not (Test-Path -Path $Settings.Release -PathType Container)) {
    Write-Error -ErrorAction Stop -Message "Release module does not exist. Build it first."
}

# Import release module
$FileToImport = switch ($Source) {
    { $_ -in ("Module", "psm1") } { $Settings.ReleaseModule }
    { $_ -in ("Manifest", "psd1") } { $Settings.ReleaseManifest }
}
Import-Module -Name $FileToImport -Force -Verbose

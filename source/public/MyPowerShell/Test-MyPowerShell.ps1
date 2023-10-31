function Test-MyPowerShell {
    <#
    .SYNOPSIS
        Test my PowerShell.

    .DESCRIPTION
        Test my current PowerShell session to know whether the version is up-to-date or not.

    .EXAMPLE
        PS> Test-MyPowerShell

        Return information about the version of my current PowerShell session.

    #>

    [CmdletBinding()]
    [OutputType([String])]
    param ()

    process {
        $Version = Get-PowershellVersion
        switch (Get-PowerShellEdition) {
            "Desktop" {
                if ($Version -eq "5.1") {
                    "You use the latest version of PowerShell Desktop."
                }
                else {
                    "You must not use this version of PowerShell anymore..."
                }
            }
            "Core" {
                if ($Version -eq (Get-PowerShellLatestAvailableVersion)) {
                    "You use the latest version of PowerShell Core."
                }
                else {
                    "Your PowerShell Core is out-of-date..."
                }
            }
            Default {
                "Unknown edition of PowerShell."
            }
        }
    }
}

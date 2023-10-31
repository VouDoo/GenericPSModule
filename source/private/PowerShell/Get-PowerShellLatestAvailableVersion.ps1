function Get-PowerShellLatestAvailableVersion {
    [CmdletBinding()]
    [OutputType([String])]
    param ()

    process {
        (Invoke-RestMethod -Uri "https://api.github.com/repos/PowerShell/PowerShell/releases/latest").tag_name.Trim("v")
    }
}

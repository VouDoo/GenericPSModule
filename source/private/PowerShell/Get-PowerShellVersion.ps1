function Get-PowerShellVersion {
    [CmdletBinding()]
    [OutputType([String])]
    param ()

    process {
        $PSVersionTable.PSVersion.ToString()
    }
}

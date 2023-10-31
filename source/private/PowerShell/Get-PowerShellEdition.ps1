function Get-PowerShellEdition {
    [CmdletBinding()]
    [OutputType([String])]
    param ()

    process {
        $PSVersionTable.PSEdition
    }
}

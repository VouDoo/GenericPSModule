function Get-ComputerOperatingSystem {
    <#
    .SYNOPSIS
        Get operating system name.

    .DESCRIPTION
        Get the name of the operating system on which the system runs.

    .INPUTS
        None. You cannot pipe objects to Get-ComputerOperatingSystem.

    .OUTPUTS
        string. It returns the name of the operating system.

    .EXAMPLE
        PS> Get-ComputerOperatingSystem

        Return operating system name.

    #>

    [CmdletBinding()]
    [OutputType([string])]
    param ()

    process {
        $CimInstance = Get-CimInstance -ClassName Win32_OperatingSystem -Property Caption -ErrorAction Stop

        $CimInstance.Caption.Replace("Microsoft", $null).Trim()
    }
}

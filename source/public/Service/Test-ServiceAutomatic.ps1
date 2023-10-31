function Test-WinServiceAutomatic {
    <#
    .SYNOPSIS
        Tests if Windows service is set to Automatic.

    .DESCRIPTION
        This function tests if a Windows service is set to Automatic,
        including Automatic (Delayed start).

    .INPUTS
        None. You cannot pipe objects to Test-WinServiceAutomatic.

    .OUTPUTS
        None.

    .PARAMETER Name
        Name of the Windows service.

    .EXAMPLE
        PS> Test-WinServiceAutomatic -Name "MyService"

        Return True if service is set to automatic, else False.

    #>

    [CmdletBinding()]
    [OutputType([bool])]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = "Name of the Windows service"
        )]
        [ValidateNotNullOrEmpty()]
        [string] $Name
    )

    process {
        $Service = Get-Service -Name $Name -ErrorAction SilentlyContinue

        $Service.StartType -in ("Automatic", "AutomaticDelayed")
    }
}

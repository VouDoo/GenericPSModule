function Set-ServiceAutomaticDelayed {
    <#
    .SYNOPSIS
        Set Windows service to Automatic (Delayed start).

    .DESCRIPTION
        This function sets a Windows service to Automatic (Delayed start).

        As the "Set-Service" PowerShell cmdlet does not have this startup
        type in PowerShell 5.1, this function is an alternative.

        This function uses the Service Control (sc.exe) Windows command.
        More details available on this page: https://ss64.com/nt/sc.html

    .INPUTS
        None. You cannot pipe objects to Set-ServiceAutomaticDelayed.

    .OUTPUTS
        None.

    .PARAMETER Name
        Name of the Windows service.

    .EXAMPLE
        PS> Set-ServiceAutomaticDelayed -Name "MyService"



    #>

    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([void])]
    param (
        [Parameter(
            Mandatory = $true,
            HelpMessage = "Name of the Windows service"
        )]
        [ValidateNotNullOrEmpty()]
        [string] $Name
    )

    process {
        if ($PSCmdlet.ShouldProcess($Name)) {
            try {
                Write-Debug -Message "Execute `"sc.exe`" command to set the Windows Service $Name to Automatic (Delayed start)."
                & sc.exe config "$Name" start= delayed-auto
                Write-Verbose -Message "Windows Service $Name is now set to Automatic (Delayed start)."
            }
            catch {
                Write-Error -Message "Windows service `"{0}`" cannot be set to Automatic (Delayed start). Error message: {1}" -f $Name, $_.Exception.Message
            }
        }
    }
}

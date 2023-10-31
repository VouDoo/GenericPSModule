function Get-ComputerLogicalProcessorCount {
    <#
    .SYNOPSIS
        Get number of logical processors.

    .DESCRIPTION
        Get the number of logical processors present on the system.

    .INPUTS
        None. You cannot pipe objects to Get-ComputerLogicalProcessorCount.

    .OUTPUTS
        int. It returns the number of logical processors.

    .EXAMPLE
        PS> Get-ComputerLogicalProcessorCount

        Return the number of logical processor.

    #>

    [CmdletBinding()]
    [OutputType([int])]
    param ()

    process {
        $CimInstance = Get-CimInstance -ClassName Win32_ComputerSystem -Property NumberOfLogicalProcessors -ErrorAction Stop

        $CimInstance.NumberOfLogicalProcessors -as [int]
    }
}

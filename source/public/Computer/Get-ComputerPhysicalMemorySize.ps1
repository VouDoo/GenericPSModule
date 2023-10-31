function Get-ComputerPhysicalMemorySize {
    <#
    .SYNOPSIS
        Get physical memory size.

    .DESCRIPTION
        Get the total size of the physical memory present on the system.

    .INPUTS
        None. You cannot pipe objects to Get-ComputerPhysicalMemorySize.

    .OUTPUTS
        int. It returns the total physical memory size.

    .PARAMETER Prefix
        Binary prefix to convert the memory size.

    .EXAMPLE
        PS> Get-ComputerPhysicalMemorySize

        Return physical memory size in Gigabyte.

    .EXAMPLE
        PS> Get-ComputerPhysicalMemorySize -Prefix Mega

        Return physical memory size in Megabyte.

    #>

    [CmdletBinding()]
    [OutputType([int])]
    param (
        [Parameter(
            HelpMessage = "Binary prefix to convert the memory size"
        )]
        [ValidateSet(
            "Gigabyte", "GB",
            "Megabyte", "MB"
        )]
        [Alias("Prefix", "Unit", "UnitPrefix")]
        [string] $BinaryPrefix = "Gigabyte"
    )

    process {
        $CimInstance = Get-CimInstance -ClassName Win32_ComputerSystem -Property TotalPhysicalMemory -ErrorAction Stop

        switch ($BinaryPrefix) {
            { $_ -in ("Gigabyte", "GB") } {
                [math]::Round($CimInstance.TotalPhysicalMemory / 1GB)
            }
            { $_ -in ("Megabyte", "MB") } {
                [math]::Round($CimInstance.TotalPhysicalMemory / 1MB)
            }
        }
    }
}

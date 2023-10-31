function Get-ComputerFixedDisk {
    <#
    .SYNOPSIS
        Get fixed disks.

    .DESCRIPTION
        Get information on fixed disks present on the computer.

    .INPUTS
        None. You cannot pipe objects to Get-ComputerFixedDisk.

    .OUTPUTS
        PSCustomObject. It returns an array of objects containing information for each fixed disk.

    .EXAMPLE
        PS> Get-ComputerFixedDisk

        Return list of the fixed disks present on the computer.

    #>

    [CmdletBinding()]
    [OutputType([PSCustomObject])]
    param ()

    process {
        <# Meaning of DriveType values:
            0 (0x0)  Unknown
            1 (0x1)  NoRootDirectory
            2 (0x2)  Removable
            3 (0x3)  Fixed
            4 (0x4)  Network
            5 (0x5)  CDRom
            6 (0x6)  Ram
        #>
        $CimInstance = Get-CimInstance -ClassName Win32_LogicalDisk -Property DeviceID, DriveType, VolumeName, Size, FreeSpace -ErrorAction Stop

        $CimInstance | Where-Object { $_.DriveType -eq 3 } | Select-Object -Property @(
            @{
                Name       = "Volume"
                Expression = { $_.DeviceID }
            },
            @{
                Name       = "Name" ;
                Expression = { $_.VolumeName }
            },
            @{
                Name       = "FreeSpaceGB"
                Expression = { [math]::truncate($_.FreeSpace / 1GB * 100) / 100 }
            },
            @{
                Name       = "SizeGB"
                Expression = { [math]::truncate($_.Size / 1GB * 100) / 100 }
            }
        )
    }
}

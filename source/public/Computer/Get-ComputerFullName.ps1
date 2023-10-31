function Get-ComputerFullName {
    <#
    .SYNOPSIS
        Get computer full name.

    .DESCRIPTION
        Get computer name combined with host and domain names.

    .INPUTS
        None. You cannot pipe objects to Get-ComputerFullName.

    .OUTPUTS
        string. It returns the full computer name.

    .EXAMPLE
        PS> Get-ComputerFullName

        Return computer full name.

    #>

    [CmdletBinding()]
    [OutputType([string])]
    param ()

    process {
        <# Meaning of DomainRole values:
            0 (0x0)  Standalone Workstation
            1 (0x1)  Member Workstation
            2 (0x2)  Standalone Server
            3 (0x3)  Member Server
            4 (0x4)  Backup Domain Controller
            5 (0x5)  Primary Domain Controller
        #>
        $CimInstance = Get-CimInstance -ClassName Win32_ComputerSystem -Property Name, Domain, DomainRole -ErrorAction Stop

        if ($CimInstance.DomainRole -in (1, 3, 4, 5)) {
            ("{0}.{1}" -f $CimInstance.Name, $CimInstance.Domain).ToLower()
        }
        else {
            $CimInstance.Name.ToLower()
        }
    }
}

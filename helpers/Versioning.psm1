#
# Helper functions for managing Versioning
#

using namespace System.Management.Automation

function Test-Version {
    <#
    .SYNOPSIS
        Check if version format is correct.

    .DESCRIPTION
        Test if string can be initiated as a System.Version PowerShell object.
        If so, it means that the string uses the correct versioning format.

    .EXAMPLE
        PS> Test-Version -VersionString "0.1.0"

        Return True.

    #>

    [CmdletBinding()]
    [OutputType([bool])]
    param (
        [Parameter(
            Mandatory,
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [string] $VersionString
    )

    process {
        try {
            [System.Version] $VersionString -and $true
        }
        catch {
            $false
        }
    }
}

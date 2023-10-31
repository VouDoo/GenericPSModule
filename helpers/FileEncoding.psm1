#
# Helper functions for file encoding
#

function Remove-Utf8Bom {
    <#
    .SYNOPSIS
        Removes a UTF8 BOM from a file.

    .DESCRIPTION
        Removes a UTF8 BOM from a file if the BOM appears to be present.
        The UTF8 BOM is identified by the byte sequence 0xEF 0xBB 0xBF at the beginning of the file.

    .EXAMPLE
        PS> Remove-Utf8Bom -Path C:\file.txt

        Remove a BOM from a single file.

    .EXAMPLE
        PS> Get-ChildItem C:\folder -Recurse -File | Remove-Utf8Bom

        Remove the BOM from every file returned by Get-ChildItem.

    #>

    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseShouldProcessForStateChangingFunctions', '')]
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory,
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [ValidateScript( { Test-Path -Path $_ -PathType Leaf } )]
        [String] $Path
    )

    begin {
        $Encoding = [System.Text.UTF8Encoding]::new($false)
    }

    process {
        $Path = $PSCmdlet.GetUnresolvedProviderPathFromPSPath($Path)
        try {
            $Bom = [Byte[]]::new(3)
            $Stream = [System.IO.File]::OpenRead($Path)
            $null = $Stream.Read($Bom, 0, 3)
            $Stream.Close()
            if ([BitConverter]::ToString($Bom, 0) -eq 'EF-BB-BF') {
                [System.IO.File]::WriteAllLines(
                    $Path,
                    [System.IO.File]::ReadAllLines($Path),
                    $Encoding
                )
            }
            else {
                Write-Verbose ('A UTF8 BOM was not detected on the file {0}' -f $Path)
            }
        }
        catch {
            Write-Error -ErrorRecord $_
        }
    }
}

Export-ModuleMember -Function Remove-Utf8Bom

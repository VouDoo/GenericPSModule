function New-Logger {
    <#
    .SYNOPSIS
        Create logger.

    .DESCRIPTION
        Create a new logger object.

    .INPUTS
        None. You cannot pipe objects to New-Logger.

    .OUTPUTS
        Logger. This object is a simple logger for PowerShell.

    .PARAMETER OutFile
        Path to the log file.

    .EXAMPLE
        PS> New-Logger

        Create a logger that will write every log entry into the PowerShell console.

    .EXAMPLE
        PS> New-Logger -OutFile "./myfile.log"

        Create a logger that will write every log entry into the specified file.

    .NOTES
        The logger uses the information stream (stream #6) when it writes log entries into the PowerShell console.

        If you execute a script which uses this Logger with console redirection,
        you can still redirect every log entry into a file using the redirection operator.

        To redirect the information stream to a file:

        PS> .\myscript.ps1 6> myfile.log

        Or redirect all the output streams to a file:

        PS> .\myscript.ps1 *> myfile.log

    #>

    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseShouldProcessForStateChangingFunctions', '')]
    [CmdletBinding()]
    [OutputType([Logger])]
    param (
        [Parameter()]
        [string] $OutFile
    )

    process {
        try {
            if ($OutFile) {
                New-Object -TypeName Logger -ArgumentList $OutFile
            }
            else {
                New-Object -TypeName Logger
            }
        }
        catch {
            Write-Error -Message ("Cannot initiate logger: {0}" -f $_.Exception.Message)
        }
    }
}

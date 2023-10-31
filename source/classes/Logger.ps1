#region Enum classes for Logger class
enum LogLevels {
    Error = 1
    Warning = 2
    Info = 3
    Debug = 4
}
enum LogOutputs {
    Console
    File
}
#endregion Enums classes for Logger class

class Logger {
    # Simple logger for PowerShell that generates formatted log entries.

    # Logging output
    [LogOutputs] $LogOutput
    # Log filepath (when LogOutput is set to File)
    [string] $FilePath
    # Logging level
    [LogLevels] $LogLevel = [LogLevels]::Info
    # Datetime format
    hidden [string] $DateFormat = "yyyy-MM-dd HH:mm:ss K"
    # Log entry format
    static [string] $LogFormat = "{0} - {1}: {2}"  # -f $LogLevel, $Date, $Message
    # Use color in console output
    hidden [bool] $UseColor = $true
    # Colors definition
    static [System.ConsoleColor] $NoColor = [System.ConsoleColor]::White
    static [System.ConsoleColor] $ErrorColor = [System.ConsoleColor]::Red
    static [System.ConsoleColor] $WarningColor = [System.ConsoleColor]::Yellow
    static [System.ConsoleColor] $InfoColor = [System.ConsoleColor]::White
    static [System.ConsoleColor] $DebugColor = [System.ConsoleColor]::Cyan

    Logger() {
        # Initialize Logger to write log entries into the PowerShell console
        $this.LogOutput = [LogOutputs]::Console
    }

    Logger([string] $FilePath) {
        # Initialize Logger to write log entries into file
        $this.LogOutput = [LogOutputs]::File
        $this.FilePath = $FilePath
    }

    hidden [void] WriteToConsole(
        # Write log entry into console
        [string] $LogEntry,
        [System.ConsoleColor] $Color
    ) {
        $WriteHostParams = @{
            Object          = $LogEntry
            ForegroundColor = if ($this.UseColor) { $Color } else { [Logger]::NoColor }
        }
        # Note that Write-Host uses the Information stream (Stream #6)
        Microsoft.PowerShell.Utility\Write-Host @WriteHostParams
    }

    hidden [void] WriteToFile([string] $LogEntry) {
        # Write log entry into file
        Add-Content -Path $this.FilePath -Value $LogEntry
    }

    hidden [void] Write(
        [LogLevels] $LogLevel,
        [string] $Message,
        [System.ConsoleColor] $Color
    ) {
        # Wrapper to write log entry
        if ($LogLevel -le $this.LogLevel) {
            $LogEntry = [Logger]::LogFormat -f (
                (Get-Date -Format $this.DateFormat),
                $LogLevel.ToString().ToUpper(),
                $Message
            )
            switch ($this.LogOutput) {
                ([LogOutputs]::Console) {
                    $this.WriteToConsole($LogEntry, $Color)
                }
                ([LogOutputs]::File) {
                    $this.WriteToFile($LogEntry)
                }
            }
        }
    }

    [void] Error([string] $Message) {
        # Generate error log entry
        $this.Write([LogLevels]::Error, $Message, [Logger]::ErrorColor)
    }

    [void] Warning([string] $Message) {
        # Generate warning log entry
        $this.Write([LogLevels]::Warning, $Message, [Logger]::WarningColor)
    }

    [void] Info([string] $Message) {
        # Generate information log entry
        $this.Write([LogLevels]::Info, $Message, [Logger]::InfoColor)
    }

    [void] Debug([string] $Message) {
        # Generate debug log entry
        $this.Write([LogLevels]::Debug, $Message, [Logger]::DebugColor)
    }

    [void] SetLogLevel([LogLevels] $LogLevel) {
        # Set logging level
        $this.LogLevel = $LogLevel
    }
}

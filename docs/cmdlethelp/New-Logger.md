---
external help file: GenericPSModule-help.xml
Module Name: GenericPSModule
online version:
schema: 2.0.0
---

# New-Logger

## SYNOPSIS
Create logger.

## SYNTAX

```
New-Logger [[-OutFile] <String>] [<CommonParameters>]
```

## DESCRIPTION
Create a new logger object.

## EXAMPLES

### EXAMPLE 1
```
New-Logger
```

Create a logger that will write every log entry into the PowerShell console.

### EXAMPLE 2
```
New-Logger -OutFile "./myfile.log"
```

Create a logger that will write every log entry into the specified file.

## PARAMETERS

### -OutFile
Path to the log file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None. You cannot pipe objects to New-Logger.
## OUTPUTS

### Logger. This object is a simple logger for PowerShell.
## NOTES
The logger uses the information stream (stream #6) when it writes log entries into the PowerShell console.

If you execute a script which uses this Logger with console redirection,
you can still redirect every log entry into a file using the redirection operator.

To redirect the information stream to a file:

PS\> .\myscript.ps1 6\> myfile.log

Or redirect all the output streams to a file:

PS\> .\myscript.ps1 *\> myfile.log

## RELATED LINKS

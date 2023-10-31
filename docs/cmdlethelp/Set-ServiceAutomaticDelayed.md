---
external help file: GenericPSModule-help.xml
Module Name: GenericPSModule
online version:
schema: 2.0.0
---

# Set-ServiceAutomaticDelayed

## SYNOPSIS
Set Windows service to Automatic (Delayed start).

## SYNTAX

```
Set-ServiceAutomaticDelayed [-Name] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This function sets a Windows service to Automatic (Delayed start).

As the "Set-Service" PowerShell cmdlet does not have this startup
type in PowerShell 5.1, this function is an alternative.

This function uses the Service Control (sc.exe) Windows command.
More details available on this page: https://ss64.com/nt/sc.html

## EXAMPLES

### EXAMPLE 1
```
Set-ServiceAutomaticDelayed -Name "MyService"
```

## PARAMETERS

### -Name
Name of the Windows service.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None. You cannot pipe objects to Set-ServiceAutomaticDelayed.
## OUTPUTS

### None.
## NOTES

## RELATED LINKS

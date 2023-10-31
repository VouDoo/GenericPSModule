---
external help file: GenericPSModule-help.xml
Module Name: GenericPSModule
online version:
schema: 2.0.0
---

# Get-ComputerPhysicalMemorySize

## SYNOPSIS
Get physical memory size.

## SYNTAX

```
Get-ComputerPhysicalMemorySize [[-BinaryPrefix] <String>] [<CommonParameters>]
```

## DESCRIPTION
Get the total size of the physical memory present on the system.

## EXAMPLES

### EXAMPLE 1
```
Get-ComputerPhysicalMemorySize
```

Return physical memory size in Gigabyte.

### EXAMPLE 2
```
Get-ComputerPhysicalMemorySize -Prefix Mega
```

Return physical memory size in Megabyte.

## PARAMETERS

### -BinaryPrefix
Binary prefix to convert the memory size

```yaml
Type: String
Parameter Sets: (All)
Aliases: Prefix, Unit, UnitPrefix

Required: False
Position: 1
Default value: Gigabyte
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None. You cannot pipe objects to Get-ComputerPhysicalMemorySize.
## OUTPUTS

### int. It returns the total physical memory size.
## NOTES

## RELATED LINKS

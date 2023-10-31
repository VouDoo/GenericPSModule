#
# Helper functions for managing PowerShell dependencies (modules)
#

function Get-RequiredModules {
    <#
    .SYNOPSIS
        Get required modules.

    .SYNOPSIS
        Get required module specs from a requirements file.

    .EXAMPLE
        PS> Get-RequiredModules -Path ".\requirements.psd1"

        Return list of modules.

    #>

    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseSingularNouns', '')]
    [CmdletBinding()]
    [OutputType([Microsoft.PowerShell.Commands.ModuleSpecification[]])]
    param (
        [Parameter(
            Mandatory,
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [ValidateScript( { Test-Path -Path $_ -PathType Leaf } )]
        [Alias("Path")]
        [string] $RequirementsFilePath
    )

    process {
        [Microsoft.PowerShell.Commands.ModuleSpecification[]] (Import-PowerShellDataFile -Path $RequirementsFilePath).Modules
    }
}

function Install-AllDependencies {
    <#
    .SYNOPSIS
        Install all dependencies.

    .DESCRIPTION
        Install every dependency module listed in the requirement file.

    .EXAMPLE
        PS> Install-Dependencies -RequirementsFilePath ".\requirements.psd1"

        Install all dependencies in default scope (CurrentUser).

    #>

    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseSingularNouns', '')]
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory,
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [ValidateScript( { Test-Path -Path $_ -PathType Leaf } )]
        [Alias("Path")]
        [string] $RequirementsFilePath,

        [Parameter()]
        [ValidateSet("CurrentUser", "AllUsers")]
        [string] $Scope = "CurrentUser"
    )

    begin {
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12
    }

    process {
        $Modules = Get-RequiredModules -Path $RequirementsFilePath

        if ($Modules) {
            # Get the current installation policy
            $Policy = (Get-PSRepository -Name PSGallery).InstallationPolicy
            try {
                Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
                $Modules | Install-Module -Scope $Scope -Repository PSGallery -SkipPublisherCheck -AllowClobber -WarningAction SilentlyContinue
            }
            finally {
                # Revert to the previously set installation policy
                Set-PSRepository -Name PSGallery -InstallationPolicy $Policy
            }
        }
    }
}

function Import-Dependency {
    <#
    .SYNOPSIS
        Import a dependency.

    .DESCRIPTION
        Import a dependency module present in the requirement file.

    .EXAMPLE
        PS> Import-Dependency -ModuleName "Pester" -RequirementsFile ".\requirements.psd1"

        Import Pester dependency.

    #>

    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory,
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [Alias("Name")]
        [string] $ModuleName,

        [Parameter(
            Mandatory,
            Position = 1,
            ValueFromPipelineByPropertyName
        )]
        [ValidateScript( { Test-Path -Path $_ -PathType Leaf } )]
        [Alias("Path")]
        [string] $RequirementsFilePath
    )

    process {
        $Module = Get-RequiredModules -Path $RequirementsFilePath | Where-Object -Property Name -EQ $ModuleName | Select-Object -Unique
        if ($Module) {
            Import-Module @Module -Force
        }
        else {
            throw "No `"$ModuleName`" module found in requirements file."
        }
    }
}

Export-ModuleMember -Function Install-AllDependencies, Import-Dependency

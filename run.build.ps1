#requires -Modules InvokeBuild

[System.Diagnostics.CodeAnalysis.SuppressMessage('PSReviewUnusedParameter', '')]
[CmdletBinding()]
param(
    [Parameter(
        HelpMessage = "Bootstrap dependencies"
    )]
    [switch] $Bootstrap
)

function Write-BuildInfo {
    param(
        [Parameter(ValueFromPipeline)]
        [string] $Message
    )
    process {
        Write-Information -MessageData ("[{0}] {1}" -f $Task.Name, $Message) -InformationAction Continue
    }
}

# Load settings
$Settings = & (Join-Path -Path $BuildRoot -ChildPath "settings.ps1")

# Default Task
task . CompileModule, TestModule

task Init {
    "Print PowerShell version:" | Write-BuildInfo
    $PSVersionTable | Format-Table

    "Print settings:" | Write-BuildInfo
    $Settings

    "Import functions from helper modules." | Write-BuildInfo
    $Settings.HelperModules | ForEach-Object -Process { Import-Module -Name $_.FullName -Force }

    if ($Bootstrap.IsPresent) {
        "Install required modules (dependencies)." | Write-BuildInfo
        Install-AllDependencies -Path $Settings.RequirementsFile
    }
}

task CleanUp Init, {
    if (Test-Path -Path $Settings.Release -PathType Container) {
        "Remove existing files in release directory." | Write-BuildInfo
        Get-ChildItem -Path $Settings.Release | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    }
}

task CompileModule Init, CleanUp, {
    assert (Test-Version -VersionString $Settings.ModuleVersion) "Version string does not respect the versioning format."

    if (-not (Test-Path -Path $Settings.Release -PathType Container)) {
        "Create release directory." | Write-BuildInfo
        New-Item -Path $Settings.Release -ItemType Directory | Out-Null
    }

    $ModuleFile = @{
        Path     = $Settings.ReleaseModule
        Encoding = $Settings.ReleaseEncoding
    }

    "Start to compile `"{0}`" module." -f $Settings.ModuleName | Write-BuildInfo
    [string] $Content = $null
    @(
        $Settings.SourceHeader
        $Settings.SourceClasses
        $Settings.SourcePrivateFunctions
        $Settings.SourcePublicFunctions
    ) | ForEach-Object -Process {
        "Include `"{0}`"." -f $_.BaseName | Write-BuildInfo
        $Content += [System.IO.File]::ReadAllText($_.FullName) + "`r`n"
    }

    "Create release module file: {0}" -f $Settings.ReleaseModule | Write-BuildInfo
    Set-Content @ModuleFile -Value $Content
    Remove-Utf8Bom -Path $ModuleFile.Path

    "Create release manifest file: {0}" -f $Settings.ReleaseManifest | Write-BuildInfo
    $NewModuleManifestParams = @{
        RootModule    = (Get-Item -Path $Settings.ReleaseModule).Name
        ModuleVersion = $Settings.ModuleVersion
    }
    New-ModuleManifest @NewModuleManifestParams -Path $Settings.ReleaseManifest

    "Update release manifest with source manifest values." | Write-BuildInfo
    $SourceManifestParams = Import-PowerShellDataFile -Path $Settings.SourceManifest
    Update-ModuleManifest @SourceManifestParams -Path $Settings.ReleaseManifest

    if ($Settings.SourcePublicFunctions) {
        "Update FunctionsToExport in release manifest." | Write-BuildInfo
        $UpdateModuleManifestParams = @{
            FunctionsToExport = $Settings.SourcePublicFunctions.BaseName
        }
        Update-ModuleManifest @UpdateModuleManifestParams -Path $Settings.ReleaseManifest
    }
}

task AnalyzeCode Init, {
    $DependencyParams = @{
        ModuleName           = "PSScriptAnalyzer"
        RequirementsFilePath = $Settings.RequirementsFile.FullName
    }
    Import-Dependency @DependencyParams -ErrorAction Stop

    $ScriptAnalyzerParams = @{
        Path     = $Settings.ReleaseModule
        Settings = $Settings.ScriptAnalyzerSettings
        Recurse  = $true
    }
    $Result = Invoke-ScriptAnalyzer @ScriptAnalyzerParams
    if ($Result) {
        $Result | Format-Table -AutoSize
    }
    else {
        "No defect detected." | Write-BuildInfo
    }
}

task TestModule Init, AnalyzeCode, {
    $DependencyParams = @{
        ModuleName           = "Pester"
        RequirementsFilePath = $Settings.RequirementsFile.FullName
    }
    Import-Dependency @DependencyParams -ErrorAction Stop

    try {
        Import-Module -Name $Settings.ReleaseModule -Force

        $env:PESTER_MODULE_FILE = $Settings.ReleaseModule
        $env:PESTER_MODULE_NAME = $Settings.ModuleName
        $PesterParams = @{
            Path   = $Settings.TestsFiles
            Output = "Detailed"
        }
        Invoke-Pester @PesterParams
    }
    finally {
        Remove-Module -Name $Settings.ModuleName
        Remove-Module -Name Pester
    }
}

task GenerateHelp CompileModule, {
    $DependencyParams = @{
        ModuleName           = "platyPS"
        RequirementsFilePath = $Settings.RequirementsFile.FullName
    }
    Import-Dependency @DependencyParams -ErrorAction Stop

    try {
        Import-Module -Name $Settings.ReleaseManifest -Force

        $MarkdownHelpParams = @{
            Module         = $Settings.ModuleName
            OutputFolder   = $Settings.DocsHelpOut
            WithModulePage = $false
            Local          = $Settings.DocsHelpLocale
            Encoding       = [System.Text.Encoding]::GetEncoding($Settings.DocsHelpEncoding)
            Force          = $true
        }
        New-MarkdownHelp @MarkdownHelpParams
    }
    finally {
        Remove-Module -Name $Settings.ModuleName
        Remove-Module -Name platyPS
    }
}

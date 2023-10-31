$ModuleName = "GenericPSModule"
$ModuleVersion = "0.1.0"

# Project root directory and subdirectories
$Root = if ($BuildRoot) { $BuildRoot } else { $PSScriptRoot }
$Source = Join-Path -Path $Root -ChildPath "source"
$Tests = Join-Path -Path $Root -ChildPath "tests"
$Release = Join-Path -Path $Root -ChildPath "release\PS$PSEdition\$ModuleName\$ModuleVersion"
$Docs = Join-Path -Path $Root -ChildPath "docs"

@{
    # Project
    ProjectRoot            = $Root
    # Module
    ModuleName             = $ModuleName
    ModuleVersion          = $ModuleVersion
    # Build
    HelperModules          = Get-ChildItem -Path "$Root/helpers" -Include "*.psm1" -Recurse -File
    RequirementsFile       = Get-Item -Path "$Root/requirements.psd1"
    # Source
    Source                 = Get-Item -Path $Source
    SourceHeader           = Get-Item -Path "$Source/header.ps1"
    SourceManifest         = Get-Item -Path "$Source/manifest.psd1"
    SourceClasses          = Get-ChildItem -Path "$Source/classes" -Include "*.ps1" -Recurse -File
    SourcePrivateFunctions = Get-ChildItem -Path "$Source/private" -Include "*.ps1" -Recurse -File
    SourcePublicFunctions  = Get-ChildItem -Path "$Source/public" -Include "*.ps1" -Recurse -File
    # Script Analyzer
    ScriptAnalyzerSettings = Get-Item -Path "PSScriptAnalyzerSettings.psd1"
    # Tests
    Tests                  = Get-Item -Path $Tests
    TestsFiles             = Get-ChildItem -Path $Tests -Include "*.Tests.ps1" -Recurse -File
    # Release
    Release                = $Release
    ReleaseModule          = Join-Path -Path $Release -ChildPath "$ModuleName.psm1"
    ReleaseManifest        = Join-Path -Path $Release -ChildPath "$ModuleName.psd1"
    ReleaseEncoding        = "utf8"  # String
    # Docs
    Docs                   = Get-Item -Path $Docs
    DocsHelpOut            = Join-Path -Path $Docs -ChildPath "cmdlethelp"
    DocsHelpLocale         = "EN-US"
    DocsHelpEncoding       = "UTF-8"  # System.Text.Encoding
}

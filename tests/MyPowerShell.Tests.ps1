BeforeAll {
    if ($env:PESTER_MODULE_FILE -ne $null) {
        Import-Module -Name $env:PESTER_MODULE_FILE
    }
    else {
        . "$PSScriptRoot\..\import.release.ps1"
    }
}

Describe "Test PowerShell versions" {
    Context "When using latest version of PowerShell Desktop" {
        BeforeEach {
            $MockParams = @{ ModuleName = $env:PESTER_MODULE_NAME }
            Mock @MockParams Get-PowerShellVersion { return "5.1" }
            Mock @MockParams Get-PowerShellEdition { return "Desktop" }
            Mock @MockParams Get-PowerShellLatestAvailableVersion { return "7.3.9" }
        }

        It "Should print that it is using the latest version of PowerShell Desktop" {
            Test-MyPowerShell | Should -Be "You use the latest version of PowerShell Desktop."
        }
    }

    Context "When using latest version of PowerShell Core" {
        BeforeEach {
            $MockParams = @{ ModuleName = $env:PESTER_MODULE_NAME }
            Mock @MockParams Get-PowerShellVersion { return "7.3.9" }
            Mock @MockParams Get-PowerShellEdition { return "Core" }
            Mock @MockParams Get-PowerShellLatestAvailableVersion { return "7.3.9" }
        }

        It "Should print that it is using the latest version of PowerShell Desktop" {
            Test-MyPowerShell | Should -Be "You use the latest version of PowerShell Core."
        }
    }

    Context "When using ancient piece of software" {
        BeforeEach {
            $MockParams = @{ ModuleName = $env:PESTER_MODULE_NAME }
            Mock @MockParams Get-PowerShellVersion { return "2.0" }
            Mock @MockParams Get-PowerShellEdition { return "Desktop" }
            Mock @MockParams Get-PowerShellLatestAvailableVersion { return "7.3.9" }
        }

        It "Should print that it is using the latest version of PowerShell Desktop" {
            Test-MyPowerShell | Should -Be "You must not use this version of PowerShell anymore..."
        }
    }
}

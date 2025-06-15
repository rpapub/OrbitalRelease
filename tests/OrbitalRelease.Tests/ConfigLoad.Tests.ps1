$modulePath = Join-Path $PSScriptRoot '../../src/OrbitalRelease/OrbitalRelease.psm1'
Import-Module $modulePath -Force

Describe "Invoke-ConfigLoad" {
    It "returns base config if no local config file" {
        $result = Invoke-ConfigLoad -LocalConfigPath "nonexistent.json"
        $result.SettingA | Should -Be "DefaultA"
        $result.SettingB | Should -Be "DefaultB"
    }

    It "merges local config overrides" {
        $fixturePath = Join-Path $PSScriptRoot '../Fixtures/localconfig.json'

        $result = Invoke-ConfigLoad -LocalConfigPath $fixturePath
        $result.SettingA | Should -Be "DefaultA"
        $result.SettingB | Should -Be "OverriddenB"
        $result.SettingC | Should -Be "AddedC"
    }
}

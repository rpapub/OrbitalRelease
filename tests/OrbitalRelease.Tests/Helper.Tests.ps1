Describe "Get-Timestamp" {
    BeforeAll {
    $helperPath = Join-Path $PSScriptRoot '../../src/OrbitalRelease/Private/Helper.ps1'
    . $helperPath
    }

  It "should output a string matching ISO 8601 format" {
    $timestamp = Get-Timestamp
    $timestamp | Should -BeOfType [string]

    # Simple regex for ISO 8601 UTC format YYYY-MM-DDTHH:mm:ss.fffZ
    $iso8601Regex = '^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z$'
    $timestamp | Should -Match $iso8601Regex
  }
}

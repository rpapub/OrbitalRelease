Describe "OrbitalRelease module" {
  It "should import without errors" {
    { Import-Module "$PSScriptRoot/../../src/OrbitalRelease" -Force -ErrorAction Stop } | Should -Not -Throw
  }
}

Describe "Invoke-DevCheck" {
  BeforeAll {
    # Remove any existing module with same name to avoid conflicts
    if (Get-Module -Name OrbitalRelease) {
      Remove-Module OrbitalRelease -Force
    }

    # Import module explicitly and globally to make functions available in tests
    $modulePath = Join-Path $PSScriptRoot '../../src/OrbitalRelease/OrbitalRelease.psm1'
    Import-Module -Name $modulePath -Force -Global -ErrorAction Stop

    Write-Verbose "Available commands in module: $((Get-Command -Module OrbitalRelease).Name -join ', ')"
  }

  It "should return an object with Status = 'OK'" {
    $result = Invoke-DevCheck
    $result.Status | Should -Be 'OK'
    $result.Checked | Should -BeExactly 0
  }
}

Describe "Pester sanity check" {
  It "should pass a basic truth test" {
    $true | Should -Be $true
  }
}

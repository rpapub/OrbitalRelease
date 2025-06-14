# OrbitalRelease module root

Write-Verbose "Loading Public functions"
. $PSScriptRoot/Public/Invoke-DevCheck.ps1

Write-Verbose "Loading Private helpers"
. $PSScriptRoot/Private/Helper.ps1

Export-ModuleMember -Function Invoke-DevCheck

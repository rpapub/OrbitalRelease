# OrbitalRelease module root

Write-Verbose "Loading Public functions"
. $PSScriptRoot/Public/Invoke-DevCheck.ps1

Write-Verbose "Loading Private helpers"
. $PSScriptRoot/Private/Helper.ps1

Export-ModuleMember -Function Invoke-DevCheck

# Import private class (do NOT export)
. $PSScriptRoot/Private/LocalFileConfigStrategy.ps1

# Import public API
. $PSScriptRoot/Public/ConfigLoader.ps1

# Export only public function(s)
Export-ModuleMember -Function Invoke-ConfigLoad
#Export-ModuleMember -TypeName LocalFileConfigStrategy

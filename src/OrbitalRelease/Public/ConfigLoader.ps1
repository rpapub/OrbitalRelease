# src/OrbitalRelease/Public/ConfigLoader.ps1

. $PSScriptRoot/../Private/DefaultConfig.ps1

function Invoke-ConfigLoad {
    param (
        [string]$LocalConfigPath
    )

    # Get the base default config
    $baseConfig = Get-DefaultConfig

    if (-not (Test-Path $LocalConfigPath)) {
        return $baseConfig
    }

    # Load local config from JSON file
    $localConfigJson = Get-Content $LocalConfigPath -Raw
    $localConfig = $localConfigJson | ConvertFrom-Json -AsHashtable

    # Merge base and local config, local overrides base
    $mergedConfig = @{}

    foreach ($key in $baseConfig.Keys) {
        $mergedConfig[$key] = $baseConfig[$key]
    }
    foreach ($key in $localConfig.Keys) {
        $mergedConfig[$key] = $localConfig[$key]
    }

    return $mergedConfig
}

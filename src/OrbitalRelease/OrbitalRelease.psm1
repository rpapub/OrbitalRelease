# OrbitalRelease module root

Write-Verbose "Importing Classes"
Get-ChildItem -Path "$PSScriptRoot/Classes" -Filter *.ps1 | ForEach-Object { . $_.FullName }

Write-Verbose "Importing Data scripts"
Get-ChildItem -Path "$PSScriptRoot/Data" -Filter *.ps1 | ForEach-Object { . $_.FullName }

Write-Verbose "Importing Functions"
Get-ChildItem -Path "$PSScriptRoot/Functions" -Recurse -Filter *.ps1 | ForEach-Object { . $_.FullName }

# Export all public functions
$publicFunctions = Get-ChildItem -Path "$PSScriptRoot/Functions" -Recurse -Filter *.ps1 |
    ForEach-Object {
        Select-String -Path $_.FullName -Pattern 'function\s+([^\s{(]+)' |
            ForEach-Object { $_.Matches[0].Groups[1].Value }
    }

Export-ModuleMember -Function $publicFunctions

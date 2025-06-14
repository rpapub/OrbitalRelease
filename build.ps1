param(
  [string]$ModulePath = "src/OrbitalRelease",
  [string]$NuspecTemplate = "OrbitalRelease.nuspec",
  [string]$OutputDir = "output"
)

# Ensure output directory exists
if (-not (Test-Path $OutputDir)) {
  New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

# Step 1: Get semantic version from GitVersion
Write-Host "Running GitVersion..."
$versionInfo = dotnet gitversion /output json | ConvertFrom-Json
$semVer = $versionInfo.SemVer
Write-Host "Semantic Version: $semVer"

# Step 2: Update ModuleVersion in manifest
$manifestPath = Join-Path $ModulePath "OrbitalRelease.psd1"
$manifestContent = Get-Content $manifestPath -Raw
$updatedContent = $manifestContent -replace "ModuleVersion\s*=\s*'.*?'", "ModuleVersion = '$semVer'"
Set-Content -Path $manifestPath -Value $updatedContent
Write-Host "Updated ModuleVersion in manifest to $semVer"

# Step 3: Prepare nuspec file with replaced version
$nuspecPath = Join-Path $ModulePath $NuspecTemplate
$nuspecContent = Get-Content $nuspecPath -Raw
$nuspecContent = $nuspecContent -replace '\$version\$', $semVer

$tempNuspecPath = Join-Path $ModulePath "OrbitalRelease.temp.nuspec"
Set-Content -Path $tempNuspecPath -Value $nuspecContent

Write-Host "Packing NuGet package..."
Push-Location $ModulePath
nuget pack OrbitalRelease.temp.nuspec -OutputDirectory "..\$OutputDir"
Pop-Location

# Cleanup temporary nuspec
Remove-Item $tempNuspecPath

Write-Host "Package created in $OutputDir"

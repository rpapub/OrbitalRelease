# Ensure we're using TLS 1.2+
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Write-Host "`n🔧 Setting up local dev tools for OrbitalRelease..."

if ($PSVersionTable.PSVersion.Major -lt 7) {
  Write-Warning "PowerShell 7 or higher is required."
  exit 1
} else {
  Write-Host "PowerShell $($PSVersionTable.PSVersion) detected. Proceeding."
}

# Suppress .NET CLI telemetry
$env:DOTNET_CLI_TELEMETRY_OPTOUT = '1'

# Install GitVersion as local .NET tool
if (-Not (Test-Path ".config/dotnet-tools.json")) {
  dotnet new tool-manifest
}
$gitVersionStatus = dotnet tool install GitVersion.Tool --version 5.* --local 2>&1
Write-Host $gitVersionStatus

# Install Pester for testing
$pesterModule = Get-Module -ListAvailable -Name Pester
if ($null -eq $pesterModule) {
  Write-Host "📦 Installing Pester..."
  $oldWarningPref = $WarningPreference
  $WarningPreference = 'SilentlyContinue'
  Install-Module Pester -Scope CurrentUser -Force -SkipPublisherCheck
  $WarningPreference = $oldWarningPref
  Write-Host "Pester installed."
} else {
  Write-Host "Pester already installed (version $($pesterModule[0].Version))"
}

Write-Host "`n✅ Setup complete.`n"

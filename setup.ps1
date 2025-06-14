# Ensure we're using TLS 1.2+
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Write-Host "`n🔧 Setting up local dev tools for OrbitalRelease..."

# Install GitVersion as local .NET tool
if (-Not (Test-Path ".config/dotnet-tools.json")) {
  dotnet new tool-manifest
}
dotnet tool install GitVersion.Tool --version 5.* --local

# Install Pester for testing
if (-Not (Get-Module -ListAvailable -Name Pester)) {
  Write-Host "📦 Installing Pester..."
  Install-Module Pester -Scope CurrentUser -Force -SkipPublisherCheck
}

Write-Host "`n✅ Setup complete.`n"

# 🛠️ Contributing to OrbitalRelease

Welcome! This project provides reusable tools for governance-aware static analysis and automation in RPA projects (e.g., UiPath). All contributions must adhere to platform-agnostic design and high-quality automation practices.

## 📚 Table of Contents

- [🛠️ Contributing to OrbitalRelease](#️-contributing-to-orbitalrelease)
  - [📚 Table of Contents](#-table-of-contents)
  - [1. Overview](#1-overview)
  - [2. Repository Scope and Design Goals](#2-repository-scope-and-design-goals)
  - [3. Code Structure](#3-code-structure)
  - [4. Development Environment Setup](#4-development-environment-setup)
  - [5. Cross-Platform Compatibility](#5-cross-platform-compatibility)
  - [6. Testing with Pester](#6-testing-with-pester)
  - [7. Versioning with GitVersion](#7-versioning-with-gitversion)
  - [8. Submitting Contributions](#8-submitting-contributions)
  - [9. Coding Conventions](#9-coding-conventions)
  - [10. Folder and File Naming](#10-folder-and-file-naming)
  - [11. License and Attribution](#11-license-and-attribution)

## 1. Overview

This repo is intended to be forked and reused by organizations wishing to implement governance-aware, CI-friendly RPA tooling—especially around UiPath static analysis. It provides PowerShell modules, scripts, and configuration conventions.

## 2. Repository Scope and Design Goals

- Reusable core logic in PowerShell Module form  
- GitVersion-based semantic versioning  
- Compatible with Jenkins runners (especially Windows)  
- Centralized `.cprima/` config pattern for project-level rulesets  
- Minimal external dependencies  
- Cross-platform compatibility: Windows, macOS, Linux

## 3. Code Structure

```

src/
OrbitalRelease/        # Main module
Public/              # Functions exposed to consumers
Private/             # Internal logic
tests/
OrbitalRelease.Tests/  # Pester test specs
tools/
setup.ps1              # Dev environment bootstrap
docs/
...                    # Optional documentation
.cprima/                 # Example consumer project config (external)

````

## 4. Development Environment Setup

1. Clone the repo
2. Run the setup script:

   ```powershell
   pwsh ./tools/setup.ps1
````

This installs:

* Local `dotnet-gitversion`
* Pester for testing

## 5. Cross-Platform Compatibility

All scripts and tools must support:

* `pwsh` (PowerShell Core)
* `dotnet` SDK 8+
* Windows, Linux, macOS

Do **not** use:

* `powershell.exe`, WMI, COM, GUI-dependent cmdlets
* Hardcoded `C:\` paths or `cmd.exe` syntax

Always start scripts with:

```powershell
#!/usr/bin/env pwsh
if ($PSVersionTable.PSEdition -ne 'Core') {
  Write-Error "Only PowerShell Core is supported."
  exit 1
}
```

## 6. Testing with Pester

Test structure:

* Pester 5.x only
* Tests live in `tests/OrbitalRelease.Tests/`
* Run all tests:

  ```powershell
  Invoke-Pester -Path tests
  ```

## 7. Versioning with GitVersion

This repo uses [GitVersion](https://gitversion.net/) to auto-generate semantic versions based on Git history.

* Defined via `GitVersion.yml`
* Run locally with:

  ```powershell
  dotnet gitversion /output json
  ```

Versioning is enforced during packaging and publishing.

## 8. Submitting Contributions

* Fork the repository
* Use a `dev/feature-name` branch
* Keep `main` clean: no direct pushes
* Run all tests and linters before PR
* Follow the coding conventions

## 9. Coding Conventions

* 4-space indentation for `.ps1` / `.psm1`
* Use `Join-Path`, `Resolve-Path`, `Test-Path` for all file logic
* Prefer `[CmdletBinding()]` and parameter validation
* All public functions must have help comments

## 10. Folder and File Naming

* Use lowercase names with dashes for simple scripts (e.g., `setup.ps1`, `run-analyzer.ps1`)
* Public command scripts follow PowerShell verb-noun convention with dash, placed in `Public/` folder  
  - Example: `Public/Invoke-DevCheck.ps1`
* Private helpers and classes use PascalCase without dashes, placed in `Private/` folder  
  - Example: `Private/LocalFileConfigStrategy.ps1`
* Module root files are PascalCase without dashes:  
  - `OrbitalRelease.psm1`, `OrbitalRelease.psd1`
* Test files named after the functionality they test, mirroring subject casing, inside `tests/OrbitalRelease.Tests/`


## 11. License and Attribution

All content in this repository is published under **Creative Commons CC-BY 4.0**.
When forking, retain attribution and link back to the original repository.

Thank you for contributing!

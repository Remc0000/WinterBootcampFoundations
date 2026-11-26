#Requires -Version 5.1

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " GitHub Copilot CLI - Machine Setup"
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""


# ------------------------------------------------------------
# CHECK WINGET
# ------------------------------------------------------------

Write-Host "Checking WinGet..." -ForegroundColor Yellow

if (-not (Get-Command winget.exe -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: WinGet is not installed." -ForegroundColor Red
    exit 1
}

Write-Host "WinGet found." -ForegroundColor Green


# ------------------------------------------------------------
# CHECK / INSTALL POWERSHELL 7
# ------------------------------------------------------------

Write-Host ""
Write-Host "Checking PowerShell 7..." -ForegroundColor Yellow

$pwshPath = where.exe pwsh 2>$null | Select-Object -First 1

if (-not $pwshPath) {

    Write-Host "PowerShell 7 not found. Installing..." -ForegroundColor Yellow

    winget.exe install `
        --id Microsoft.PowerShell `
        --exact `
        --source winget `
        --accept-source-agreements `
        --accept-package-agreements

    $pwshPath = where.exe pwsh 2>$null | Select-Object -First 1
}

if (-not $pwshPath) {
    Write-Host "ERROR: PowerShell 7 could not be found after installation." -ForegroundColor Red
    exit 1
}

Write-Host "PowerShell 7 found:" -ForegroundColor Green
Write-Host "  $pwshPath"


# ------------------------------------------------------------
# SWITCH TO POWERSHELL 7
# ------------------------------------------------------------

if ($PSVersionTable.PSVersion.Major -lt 7) {

    Write-Host ""
    Write-Host "Currently running PowerShell $($PSVersionTable.PSVersion)." -ForegroundColor Yellow
    Write-Host "Switching to PowerShell 7..." -ForegroundColor Cyan
    Write-Host ""

    & $pwshPath -NoProfile -ExecutionPolicy Bypass -File $PSCommandPath

    exit $LASTEXITCODE
}

Write-Host ""
Write-Host "Running PowerShell $($PSVersionTable.PSVersion)" -ForegroundColor Green


# ------------------------------------------------------------
# UPDATE POWERSHELL 7
# ------------------------------------------------------------

Write-Host ""
Write-Host "Checking for PowerShell 7 updates..." -ForegroundColor Yellow

winget.exe upgrade `
    --id Microsoft.PowerShell `
    --exact `
    --source winget `
    --accept-source-agreements `
    --accept-package-agreements `
    --silent

Write-Host "PowerShell update check complete." -ForegroundColor Green


# ------------------------------------------------------------
# CHECK / INSTALL COPILOT CLI
# ------------------------------------------------------------

Write-Host ""
Write-Host "Checking GitHub Copilot CLI..." -ForegroundColor Yellow

$copilotPath = Join-Path $env:LOCALAPPDATA "GitHubCopilotCLI\copilot.exe"

if (-not (Test-Path $copilotPath)) {

    Write-Host "GitHub Copilot CLI not found. Installing..." -ForegroundColor Yellow

    winget.exe install `
        --id GitHub.Copilot `
        --exact `
        --source winget `
        --accept-source-agreements `
        --accept-package-agreements

}
else {

    Write-Host "GitHub Copilot CLI is already installed." -ForegroundColor Green
    Write-Host "Checking for updates..." -ForegroundColor Yellow

    winget.exe upgrade `
        --id GitHub.Copilot `
        --exact `
        --source winget `
        --accept-source-agreements `
        --accept-package-agreements `
        --silent
}


# ------------------------------------------------------------
# VERIFY COPILOT.EXE
# ------------------------------------------------------------

Write-Host ""
Write-Host "Checking Copilot executable..." -ForegroundColor Yellow

$copilotPath = Join-Path $env:LOCALAPPDATA "GitHubCopilotCLI\copilot.exe"

if (-not (Test-Path $copilotPath)) {
    Write-Host ""
    Write-Host "ERROR: copilot.exe could not be found." -ForegroundColor Red
    Write-Host "Expected:"
    Write-Host "  $copilotPath"
    exit 1
}

Write-Host "GitHub Copilot CLI found:" -ForegroundColor Green
Write-Host "  $copilotPath"


# ------------------------------------------------------------
# GET COPILOT VERSION
# ------------------------------------------------------------

Write-Host ""
Write-Host "Checking Copilot version..." -ForegroundColor Yellow

$copilotVersion = & $copilotPath --version

Write-Host "Copilot version: $copilotVersion" -ForegroundColor Green


# ------------------------------------------------------------
# SETUP COMPLETE
# ------------------------------------------------------------

Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host " SETUP COMPLETE"
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""

Write-Host "PowerShell: $($PSVersionTable.PSVersion)" -ForegroundColor Green
Write-Host "Copilot:    $copilotVersion" -ForegroundColor Green
Write-Host ""

Write-Host "Copilot executable:"
Write-Host "  $copilotPath"
Write-Host ""


# ------------------------------------------------------------
# OPEN COPILOT IN NEW POWERSHELL 7 WINDOW
# ------------------------------------------------------------

Write-Host "Opening GitHub Copilot CLI..." -ForegroundColor Cyan
Write-Host ""

$command = "& '" + $copilotPath + "'"

Start-Process `
    -FilePath $pwshPath `
    -ArgumentList "-NoExit", "-Command", $command

Write-Host "New PowerShell 7 window opened." -ForegroundColor Green
Write-Host "GitHub Copilot CLI should now be running there." -ForegroundColor Green
Write-Host ""
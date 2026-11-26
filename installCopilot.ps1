#Requires -Version 5.1

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " Winter Bootcamp - Copilot CLI Setup"
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""


# ============================================================
# 1. CHECK WINGET
# ============================================================

Write-Host "Checking WinGet..." -ForegroundColor Yellow

if (-not (Get-Command winget.exe -ErrorAction SilentlyContinue)) {
    Write-Host ""
    Write-Host "ERROR: WinGet is not installed." -ForegroundColor Red
    Write-Host "Install Microsoft App Installer and run this script again."
    Write-Host ""
    exit 1
}

Write-Host "WinGet found." -ForegroundColor Green


# ============================================================
# 2. CHECK / INSTALL POWERSHELL 7
# ============================================================

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
    Write-Host ""
    Write-Host "ERROR: PowerShell 7 could not be found after installation." -ForegroundColor Red
    exit 1
}

Write-Host "PowerShell 7 found:" -ForegroundColor Green
Write-Host "  $pwshPath"


# ============================================================
# 3. SWITCH TO POWERSHELL 7
# ============================================================

if ($PSVersionTable.PSVersion.Major -lt 7) {

    Write-Host ""
    Write-Host "Currently running PowerShell $($PSVersionTable.PSVersion)." -ForegroundColor Yellow
    Write-Host "Switching to PowerShell 7..." -ForegroundColor Cyan
    Write-Host ""

    & $pwshPath `
        -NoProfile `
        -ExecutionPolicy Bypass `
        -File $PSCommandPath

    exit $LASTEXITCODE
}

Write-Host ""
Write-Host "Running PowerShell $($PSVersionTable.PSVersion)" -ForegroundColor Green


# ============================================================
# 4. UPDATE POWERSHELL 7
# ============================================================

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


# ============================================================
# 5. CHECK NODE.JS
# ============================================================

Write-Host ""
Write-Host "Checking Node.js..." -ForegroundColor Yellow

$nodeCommand = Get-Command node.exe -ErrorAction SilentlyContinue
$installNode = $true

if ($nodeCommand) {

    $nodeVersionText = (& node --version).Trim()

    # Example: v24.11.0 -> 24
    $nodeMajor = ($nodeVersionText -replace "^v", "".Split(".")[0])

    Write-Host "Node.js $nodeVersionText is currently installed." -ForegroundColor Green

    if ($nodeMajor -eq 24) {
        $installNode = $false
        Write-Host "Node.js 24 LTS is already installed." -ForegroundColor Green
    }
    elseif ($nodeMajor -gt 24) {
        Write-Host "Node.js $nodeVersionText is installed." -ForegroundColor Yellow
        Write-Host "Winter Bootcamp standard is Node.js 24 LTS." -ForegroundColor Yellow
    }
    else {
        Write-Host "Node.js version is older than the Bootcamp standard." -ForegroundColor Yellow
    }
}
else {

    Write-Host "Node.js is not installed." -ForegroundColor Yellow
}


# ============================================================
# 6. INSTALL NODE.JS 24 LTS
# ============================================================

if ($installNode) {

    Write-Host ""
    Write-Host "Installing Node.js 24 LTS..." -ForegroundColor Cyan

    winget.exe install `
        --id OpenJS.NodeJS.LTS `
        --exact `
        --source winget `
        --version 24 `
        --accept-source-agreements `
        --accept-package-agreements

    Write-Host ""
    Write-Host "Node.js 24 LTS installation completed." -ForegroundColor Green
}
else {

    Write-Host ""
    Write-Host "Checking for Node.js 24 LTS updates..." -ForegroundColor Yellow

    winget.exe upgrade `
        --id OpenJS.NodeJS.LTS `
        --exact `
        --source winget `
        --accept-source-agreements `
        --accept-package-agreements `
        --silent

    Write-Host "Node.js update check complete." -ForegroundColor Green
}


# ============================================================
# 7. CHECK / INSTALL COPILOT CLI
# ============================================================

Write-Host ""
Write-Host "Checking GitHub Copilot CLI..." -ForegroundColor Yellow

$copilotPath = Join-Path `
    $env:LOCALAPPDATA `
    "GitHubCopilotCLI\copilot.exe"

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


# ============================================================
# 8. VERIFY COPILOT.EXE
# ============================================================

Write-Host ""
Write-Host "Checking Copilot executable..." -ForegroundColor Yellow

$copilotPath = Join-Path `
    $env:LOCALAPPDATA `
    "GitHubCopilotCLI\copilot.exe"

if (-not (Test-Path $copilotPath)) {

    Write-Host ""
    Write-Host "ERROR: copilot.exe could not be found." -ForegroundColor Red
    Write-Host "Expected:"
    Write-Host "  $copilotPath"

    exit 1
}

Write-Host "GitHub Copilot CLI found:" -ForegroundColor Green
Write-Host "  $copilotPath"


# ============================================================
# 9. GET COPILOT VERSION
# ============================================================

Write-Host ""
Write-Host "Checking Copilot version..." -ForegroundColor Yellow

$copilotVersion = (& $copilotPath --version 2>&1 | Out-String).Trim()

Write-Host "Copilot version: $copilotVersion" -ForegroundColor Green


# ============================================================
# 10. VERIFY NODE.JS AFTER INSTALLATION
# ============================================================

Write-Host ""
Write-Host "Checking Node.js installation..." -ForegroundColor Yellow

# Normal Node.js installation location on Windows
$nodePath = "$env:ProgramFiles\nodejs\node.exe"
$npmPath = "$env:ProgramFiles\nodejs\npm.cmd"

if (Test-Path $nodePath) {

    $nodeVersion = (& $nodePath --version).Trim()

    Write-Host "Node.js version: $nodeVersion" -ForegroundColor Green

}
else {

    $nodeVersion = "Installed - restart terminal to refresh PATH"

    Write-Host "Node.js was installed but is not visible in this session yet." -ForegroundColor Yellow
}


if (Test-Path $npmPath) {

    $npmVersion = (& $npmPath --version).Trim()

    Write-Host "npm version: $npmVersion" -ForegroundColor Green

}
else {

    $npmVersion = "Installed with Node.js"
}


# ============================================================
# 11. SETUP COMPLETE
# ============================================================

Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host " SETUP COMPLETE"
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""

Write-Host "PowerShell" -ForegroundColor Cyan
Write-Host "  Version: $($PSVersionTable.PSVersion)"

Write-Host ""

Write-Host "Node.js" -ForegroundColor Cyan
Write-Host "  Version: $nodeVersion"

Write-Host ""

Write-Host "npm" -ForegroundColor Cyan
Write-Host "  Version: $npmVersion"

Write-Host ""

Write-Host "GitHub Copilot CLI" -ForegroundColor Cyan
Write-Host "  Version: $copilotVersion"

Write-Host ""


# ============================================================
# 12. OPEN COPILOT IN NEW POWERSHELL 7 WINDOW
# ============================================================

Write-Host "Opening GitHub Copilot CLI..." -ForegroundColor Cyan
Write-Host ""

$command = "& '" + $copilotPath + "'"

Start-Process `
    -FilePath $pwshPath `
    -WorkingDirectory (Get-Location).Path `
    -ArgumentList "-NoExit", "-Command", $command

Write-Host "New PowerShell 7 window opened." -ForegroundColor Green
Write-Host "GitHub Copilot CLI should now be running there." -ForegroundColor Green
Write-Host ""

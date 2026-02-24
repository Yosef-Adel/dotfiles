# Windows Dotfiles Setup Script
# Usage: Open PowerShell as Administrator, then run:
#   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
#   .\install.ps1
#
# Optional flags:
#   -SkipPackages   Skip winget/scoop installation
#   -SkipLinks      Skip symlink creation

param(
    [switch]$SkipPackages,
    [switch]$SkipLinks
)

$ErrorActionPreference = "Stop"
$DotfilesRoot = $PSScriptRoot

# ── Helpers ────────────────────────────────────────────────────────────────────
function Write-Step { param([string]$Msg) Write-Host "`n==> $Msg" -ForegroundColor Cyan }
function Write-OK   { param([string]$Msg) Write-Host "  [OK] $Msg" -ForegroundColor Green }
function Write-Warn { param([string]$Msg) Write-Host "  [!!] $Msg" -ForegroundColor Yellow }
function Write-Fail { param([string]$Msg) Write-Host "  [XX] $Msg" -ForegroundColor Red }

function New-Link {
    param([string]$Target, [string]$Link)

    $parentDir = Split-Path $Link -Parent
    if (-not (Test-Path $parentDir)) {
        New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
    }

    if (Test-Path $Link) {
        $item = Get-Item $Link -Force
        if ($item.LinkType -eq "SymbolicLink" -or $item.LinkType -eq "Junction") {
            Remove-Item $Link -Force -Recurse
        } else {
            $backup = "$Link.bak"
            Write-Warn "Backing up $Link -> $backup"
            Move-Item $Link $backup -Force
        }
    }

    New-Item -ItemType SymbolicLink -Path $Link -Target $Target | Out-Null
    Write-OK "$Link  ->  $Target"
}

# ── Prerequisite check ────────────────────────────────────────────────────────
Write-Step "Checking prerequisites..."

# Symlinks on Windows need either Admin or Developer Mode
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator
)
$devModeEnabled = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" `
    -Name "AllowDevelopmentWithoutDevLicense" -ErrorAction SilentlyContinue).AllowDevelopmentWithoutDevLicense -eq 1

if (-not $isAdmin -and -not $devModeEnabled) {
    Write-Fail "Symlinks require Administrator or Developer Mode."
    Write-Host "  Enable Developer Mode: Settings -> System -> For Developers -> Developer Mode" -ForegroundColor Yellow
    Write-Host "  Or re-run this script as Administrator." -ForegroundColor Yellow
    exit 1
}

Write-OK "Permission check passed (Admin: $isAdmin, DevMode: $devModeEnabled)"

# ── Package installation ───────────────────────────────────────────────────────
if (-not $SkipPackages) {
    Write-Step "Installing packages via winget..."

    $WingetPackages = @(
        @{ Id = "Neovim.Neovim";             Name = "Neovim" },
        @{ Id = "JesseDuffield.lazygit";      Name = "lazygit" },
        @{ Id = "BurntSushi.ripgrep.MSVC";    Name = "ripgrep" },
        @{ Id = "junegunn.fzf";               Name = "fzf" },
        @{ Id = "sharkdp.fd";                 Name = "fd" },
        @{ Id = "wez.wezterm";                Name = "WezTerm" },
        @{ Id = "Git.Git";                    Name = "Git" },
        @{ Id = "OpenJS.NodeJS.LTS";          Name = "Node.js LTS" },
        @{ Id = "GoLang.Go";                  Name = "Go" },
        @{ Id = "Microsoft.PowerShell";       Name = "PowerShell 7" },
    )

    foreach ($pkg in $WingetPackages) {
        Write-Host "  Installing $($pkg.Name)..." -NoNewline
        $out = winget install --id $pkg.Id --accept-source-agreements --accept-package-agreements --silent 2>&1
        if ($LASTEXITCODE -eq 0 -or ($out | Select-String "already installed")) {
            Write-OK $pkg.Name
        } else {
            Write-Warn "$($pkg.Name) - install manually if needed"
        }
    }

    # Install Scoop for tools not in winget
    Write-Step "Setting up Scoop..."
    if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    } else {
        Write-OK "Scoop already installed"
    }

    $ScoopPackages = @("lazydocker", "yazi", "gitmux", "lua")
    foreach ($pkg in $ScoopPackages) {
        Write-Host "  Installing $pkg..." -NoNewline
        $out = scoop install $pkg 2>&1
        if ($LASTEXITCODE -eq 0 -or ($out | Select-String "already installed")) {
            Write-OK $pkg
        } else {
            Write-Warn "$pkg - install manually if needed"
        }
    }

    # PowerShell modules
    Write-Step "Installing PowerShell modules..."
    $PSModules = @("PSFzf", "posh-git")
    foreach ($mod in $PSModules) {
        if (-not (Get-Module -ListAvailable $mod -ErrorAction SilentlyContinue)) {
            Install-Module $mod -Scope CurrentUser -Force
            Write-OK $mod
        } else {
            Write-OK "$mod already installed"
        }
    }
}

# ── Symlinks ──────────────────────────────────────────────────────────────────
if (-not $SkipLinks) {
    Write-Step "Creating symlinks..."

    # Neovim: dotfiles/nvim/.config/nvim -> %LOCALAPPDATA%\nvim
    New-Link -Target "$DotfilesRoot\nvim\.config\nvim" -Link "$env:LOCALAPPDATA\nvim"

    # Git config: dotfiles/gitconfig/.gitconfig -> ~\.gitconfig
    New-Link -Target "$DotfilesRoot\gitconfig\.gitconfig" -Link "$HOME\.gitconfig"

    # WezTerm: dotfiles/wezterm/.config/wezterm -> ~\.config\wezterm
    # WezTerm on Windows checks: ~/.config/wezterm/wezterm.lua
    New-Link -Target "$DotfilesRoot\wezterm\.config\wezterm" -Link "$HOME\.config\wezterm"

    # PowerShell profile: dotfiles/powershell/... -> ~/Documents/PowerShell/...
    $psProfileDir = Split-Path $PROFILE -Parent
    New-Link -Target "$DotfilesRoot\powershell\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" `
             -Link $PROFILE
}

# ── Done ──────────────────────────────────────────────────────────────────────
Write-Step "Setup complete!"
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Restart your terminal (or open WezTerm)"
Write-Host "  2. Run 'nvim' - Lazy.nvim will auto-install plugins on first launch"
Write-Host "  3. Inside nvim, run :Mason to install LSP servers (tsserver, gopls, etc.)"
Write-Host "  4. Install a Nerd Font for icons: https://www.nerdfonts.com"
Write-Host "     Recommended: JetBrainsMono Nerd Font"
Write-Host ""
Write-Host "WezTerm pane keybindings (replaces tmux on Windows):" -ForegroundColor Cyan
Write-Host "  Ctrl+Shift+E    Split horizontal"
Write-Host "  Ctrl+Shift+O    Split vertical"
Write-Host "  Ctrl+Shift+H/J/K/L  Navigate panes"
Write-Host "  Ctrl+Shift+Z    Zoom pane"
Write-Host "  Ctrl+Shift+T    New tab"
Write-Host "  Ctrl+1-9        Switch tabs"
Write-Host ""
Write-Host "Note: tmux is not available on native Windows." -ForegroundColor DarkGray
Write-Host "  Use WezTerm splits/tabs above as an alternative." -ForegroundColor DarkGray

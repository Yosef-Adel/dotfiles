# PowerShell Profile - dotfiles Windows branch
# Linked to: $HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

# ── Aliases ────────────────────────────────────────────────────────────────────
Set-Alias lg lazygit
Set-Alias v nvim
Set-Alias vi nvim
Set-Alias ll Get-ChildItem

# ── fzf key bindings (requires PSFzf module) ───────────────────────────────────
if (Get-Module -ListAvailable PSFzf -ErrorAction SilentlyContinue) {
    Import-Module PSFzf
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
}

# ── Git prompt (requires posh-git module) ──────────────────────────────────────
if (Get-Module -ListAvailable posh-git -ErrorAction SilentlyContinue) {
    Import-Module posh-git
}

# ── Useful functions ───────────────────────────────────────────────────────────
# Quick directory jump with fzf
function fcd {
    $dir = Get-ChildItem -Directory -Recurse -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty FullName |
        fzf --preview "dir {}"
    if ($dir) { Set-Location $dir }
}

# Open lazygit in current directory
function lg { lazygit @args }

# ── Environment ────────────────────────────────────────────────────────────────
$env:EDITOR = "nvim"

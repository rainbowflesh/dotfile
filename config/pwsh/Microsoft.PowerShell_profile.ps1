$SCRIPTS_DIR = "$HOME\Developments\rainbowflesh\src\scripts"
$starships = "$HOME\.config\starships\"
$files = Get-ChildItem $starships | Where-Object { $_.PSIsContainer -eq $false }
$fileCount = $files.Count
if ($fileCount -gt 0) {
    $randomIndex = Get-Random -Minimum 0 -Maximum $fileCount
    $randomFile = $files[$randomIndex].Name
    Write-Host " [starship] Random theme $randomFile loaded"
}

$ENV:STARSHIP_CONFIG = "$starships\$randomFile"
Invoke-Expression (&starship init powershell)

# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\$randomFile" | Invoke-Expression

Invoke-Expression (& {
        $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
    })

# Import-Module posh-git
Import-Module TabExpansionPlusPlus

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

# Scripts
Set-Alias -Name dofpgan -Value "$SCRIPTS_DIR\fpgan.ps1"
Set-Alias -Name dowaifu2x -Value "$SCRIPTS_DIR\waifu2x.ps1"
Set-Alias -Name getWallpaper -Value "$SCRIPTS_DIR\find_current_wallpaper.ps1"
Set-Alias -Name initwpaproxy -Value "$SCRIPTS_DIR\initial_wsa_proxy.ps1"
Set-Alias -Name kwsl -Value "$SCRIPTS_DIR\wsl_script.ps1"
Set-Alias -Name lama -Value "$SCRIPTS_DIR\lama.ps1"

## Linux style
Set-Alias -Name cat -Value bat -Option AllScope # --theme="Solarized (light)" --style=plain
Set-Alias -Name cd -Value "z" -Option AllScope
Set-Alias -Name cdi -Value "zi" -Option AllScope
Set-Alias -Name fd -Value 'fzf'
Set-Alias -Name grep -Value Select-String
Set-Alias -Name l -Value 'ls'
Set-Alias -Name mklink -Value New-Item -Option AllScope -Description 'Creates a symbolic link'
Set-Alias -Name vim -Value 'hx'
Set-Alias -Name whereis -Value Get-Command
Set-Alias -Name which -Value Get-Command

## SuperStupidPowerScript (not shell)
function cargot {
    cargo nextest run --no-capture $args
}

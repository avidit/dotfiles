#Requires -RunAsAdministrator
$ErrorActionPreference = "Stop"
Set-ExecutionPolicy RemoteSigned

$DOTFILES = "$HOME\dotfiles"

# configure windows
# & "$DOTFILES\windows.ps1"

function Install-Winget() {
    $file = "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle"
    $latest = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
    $browserDownloadUrl = ((Invoke-WebRequest -Uri $latest | ConvertFrom-Json).assets | Where-Object { $_.name -eq $file }).browser_download_url

    Write-Host "Dowloading latest release $browserDownloadUrl"
    Invoke-WebRequest $browserDownloadUrl -OutFile "$env:TEMP\$file"

    Import-Module Appx
    Add-AppxPackage "$env:TEMP\$file"
}

if (!(Get-Command winget -errorAction SilentlyContinue)) {
    Install-Winget
}

# install apps
winget import --import-file $DOTFILES\packages.json

# install modules
Install-PackageProvider NuGet -Force
Install-Module -Name PowerShellGet -Force
Set-PSRepository PSGallery -InstallationPolicy Trusted

Install-Module -Name PSScriptAnalyzer -Scope CurrentUser
Install-Module -Name posh-git -Scope CurrentUser
Install-Module -Name ZLocation -Scope CurrentUser
Install-Module -Name Terminal-Icons -Scope CurrentUser

# dotfiles
$files = @("gitconfig", "gitignore_global")
$files | ForEach-Object {
    if (Test-Path -Path $HOME/.$_) {
        Write-Host "backing up existing file $file"
        Rename-Item -Path "$HOME\.$_" -NewName "$HOME\.$_.bak" -Force
    }
    New-Item -ItemType SymbolicLink -Path "$HOME\.$_" -Target "$DOTFILES\$_"
}

# profile
if (Test-Path -Path $PROFILE.CurrentUserAllHosts) {
    Write-Host "backing up existing file $PROFILE.CurrentUserAllHosts"
    Rename-Item -Path $PROFILE.CurrentUserAllHosts -NewName "$($PROFILE.CurrentUserAllHosts).bak"
}
New-Item -ItemType SymbolicLink -Path $PROFILE.CurrentUserAllHosts -Target "$DOTFILES\profile.ps1"

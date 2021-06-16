$ErrorActionPreference = "Stop"
Set-ExecutionPolicy RemoteSigned

Install-PackageProvider NuGet -Force
Install-Module -Name PowerShellGet -Force
Set-PSRepository PSGallery -InstallationPolicy Trusted

Install-Module -Name PSReadLine -Scope CurrentUser
Install-Module -Name PSScriptAnalyzer -Scope CurrentUser
Install-Module -Name posh-git -Scope CurrentUser

$DOTFILES = "$HOME\dotfiles"
$files = @("gitconfig", "gitignore_global")
$files | ForEach-Object {
    if (Test-Path -Path $HOME/.$_) {
        Write-host "backing up existing file $file"
        Rename-Item -Path "$HOME\.$_" -NewName "$HOME\.$_.bak"
    }
    New-Item -ItemType SymbolicLink -Path "$HOME\.$_" -Target  "$DOTFILES\$_"
}

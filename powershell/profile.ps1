# starship
Invoke-Expression (&starship init powershell)

# zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# source functions
. $HOME\dotfiles\powershell\functions.ps1

# source custom scripts
$PSScripts = "$HOME\PSScripts"
if (Test-Path -Path $PSScripts) {
    Get-ChildItem -Path $PSScripts -Filter *.ps1 | ForEach-Object {
        . $_.FullName
    }
}

# import modules
Import-Module posh-git
$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true

# source functions
. $HOME\dotfiles\functions.ps1

# source custom scripts
$PSScripts = "$HOME\PSScripts"
if(Test-Path -Path $PSScripts) {
    Get-ChildItem -Path $PSScripts -Filter *.ps1 | ForEach-Object {
        . $_.FullName
    }
}

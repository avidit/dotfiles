function .. { Set-Location .. }
function ... { Set-Location .. ; Set-Location .. }
function home { Set-Location $env:USERPROFILE }

# import modules
Import-Module posh-git
$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true

# source custom scripts
$PSScripts = "$HOME\PSScripts"
if(Test-Path -Path $PSScripts) {
    Get-ChildItem -Path $PSScripts -Filter *.ps1 | ForEach-Object {
        . $_.FullName
    }
}

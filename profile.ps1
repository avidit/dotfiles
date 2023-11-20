# import modules

# https://github.com/devblackops/Terminal-Icons
Import-Module -Name Terminal-Icons

# https://github.com/dahlbyk/posh-git
Import-Module posh-git
$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
$GitPromptSettings.DefaultPromptBeforeSuffix.Text = ' $((Get-GitStatus).Upstream)`n'

# https://github.com/dracula/powershell/blob/master/theme/dracula-prompt-configuration.ps1
# Dracula readline configuration. Requires version 2.0, if you have 1.2 convert to `Set-PSReadlineOption -TokenType`
Set-PSReadlineOption -Color @{
    "Command" = [ConsoleColor]::Green
    "Parameter" = [ConsoleColor]::Gray
    "Operator" = [ConsoleColor]::Magenta
    "Variable" = [ConsoleColor]::White
    "String" = [ConsoleColor]::Yellow
    "Number" = [ConsoleColor]::Blue
    "Type" = [ConsoleColor]::Cyan
    "Comment" = [ConsoleColor]::DarkCyan
}

# Dracula Prompt Configuration
$GitPromptSettings.DefaultPromptPrefix.Text = "$([char]0x2192) " # arrow unicode symbol
$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Green
$GitPromptSettings.DefaultPromptPath.ForegroundColor =[ConsoleColor]::Cyan
$GitPromptSettings.DefaultPromptSuffix.Text = "$([char]0x203A) " # chevron unicode symbol
$GitPromptSettings.DefaultPromptSuffix.ForegroundColor = [ConsoleColor]::Magenta
# Dracula Git Status Configuration
$GitPromptSettings.BeforeStatus.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.BranchColor.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.AfterStatus.ForegroundColor = [ConsoleColor]::Blue

# npmrc profile
# https://github.com/deoxxa/npmrc
function prompt {
    if (Get-Command npmrc -errorAction SilentlyContinue) {
        $npmrc = Split-Path $(Get-Item $(npm get userconfig)).Target -Leaf
        $prompt = Write-Prompt "[ $npmrc] " -ForegroundColor ([ConsoleColor]::Red)
        $prompt += & $GitPromptScriptBlock
        if ($prompt) { "$prompt " } else { " " }
    } else {
        & $GitPromptScriptBlock
    }
}

# https://github.com/vors/ZLocation
Import-Module ZLocation

# source functions
. $HOME\dotfiles\functions.ps1

# source custom scripts
$PSScripts = "$HOME\PSScripts"
if (Test-Path -Path $PSScripts) {
    Get-ChildItem -Path $PSScripts -Filter *.ps1 | ForEach-Object {
        . $_.FullName
    }
}

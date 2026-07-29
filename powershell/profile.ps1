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

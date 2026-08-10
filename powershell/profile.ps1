# starship
if (Get-Command starship -ErrorAction SilentlyContinue) {
    . ([ScriptBlock]::Create((starship init powershell --print-full-init | Out-String)))
}

# zoxide
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    . ([ScriptBlock]::Create((zoxide init powershell | Out-String)))
}

# PSReadLine
if (Get-Command Set-PSReadLineOption -ErrorAction SilentlyContinue) {
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
}

# source functions (follow profile symlink to dotfiles repo)
$profileItem = Get-Item -LiteralPath $MyInvocation.MyCommand.Path
$profileRoot = if ($profileItem.LinkType -eq 'SymbolicLink') {
    Split-Path -Parent $profileItem.Target
} else {
    $PSScriptRoot
}
. (Join-Path $profileRoot 'functions.ps1')

# source custom scripts
$PSScripts = Join-Path $HOME 'PSScripts'
if (Test-Path -Path $PSScripts) {
    Get-ChildItem -Path $PSScripts -Filter *.ps1 | ForEach-Object {
        . $_.FullName
    }
}

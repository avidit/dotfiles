
function .. { Set-Location .. }

function ... { Set-Location .. ; Set-Location .. }

function home { Set-Location $env:USERPROFILE }

function which([string]$cmd) { (Get-Command $cmd -ErrorAction SilentlyContinue).Definition }

function touch([string]$file) {
    if (Test-Path $file) { (Get-Item $file).LastWriteTime = Get-Date }
    else { New-Item -ItemType File -Path $file | Out-Null }
}

function export([string]$key, [string]$value) {
    Set-ItemProperty "HKCU:\Environment" $key $value
    Invoke-Expression "`$env:${key} = `"$value`""
}

function Invoke-Elevated([scriptblock]$Script) {
    if (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole('Administrator')) {
        & $Script
    } else {
        Start-Process pwsh -Verb RunAs -Wait -ArgumentList '-NoProfile', '-Command', ('& { ' + $Script + ' }')
    }
}

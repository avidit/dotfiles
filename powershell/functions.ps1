
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

function Install-DotfileLink {
    param(
        [Parameter(Mandatory)]
        [string]$Path,
        [Parameter(Mandatory)]
        [string]$Target
    )

    $targetPath = (Resolve-Path -LiteralPath $Target).Path
    $parent = Split-Path -Parent $Path
    if ($parent -and !(Test-Path -LiteralPath $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }
    if (Test-Path -LiteralPath $Path) {
        Remove-Item -LiteralPath $Path -Force
    }
    try {
        New-Item -ItemType SymbolicLink -Path $Path -Target $targetPath -Force | Out-Null
    } catch {
        New-Item -ItemType HardLink -Path $Path -Target $targetPath -Force | Out-Null
    }
}

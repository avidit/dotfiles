function .. { Set-Location .. }
function ... { Set-Location .. ; Set-Location .. }
function home { Set-Location $env:USERPROFILE }
function which([string]$cmd) { Get-Command $cmd -ErrorAction SilentlyContinue | Select-Object Definition }
function touch([string]$file) { "" | Out-File $file -Encoding ASCII }
function export([string]$key, [string]$value) {
    Set-ItemProperty "HKCU:\Environment" $variable $value
    Invoke-Expression "`$env:${key} = `"$value`""
}

. (Join-Path $PSScriptRoot 'functions.ps1')

$profilePath = $PROFILE.CurrentUserAllHosts
$profileDir = Split-Path -Parent $profilePath

Install-DotfileLink -Path $profilePath -Target (Join-Path $PSScriptRoot 'profile.ps1')
Install-DotfileLink -Path (Join-Path $profileDir 'functions.ps1') -Target (Join-Path $PSScriptRoot 'functions.ps1')

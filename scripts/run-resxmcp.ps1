# run-resxmcp.ps1
# Ensure ResxMcp.exe exists (download from GitHub Releases if missing), then run it (stdio).
param([string] $Version = "v1.0.0")
$ErrorActionPreference = "Stop"

$root    = Split-Path -Parent $MyInvocation.MyCommand.Path
$binDir  = Join-Path $root "..\.bin\resxmcp"
$exePath = Join-Path $binDir "ResxMcp.exe"
New-Item -ItemType Directory -Force -Path $binDir | Out-Null

if (!(Test-Path $exePath)) {
  Write-Host "Downloading ResxMcp $Version ..."
  $zip = "ResxMcp-$Version-win-x64.zip"
  $url = "https://github.com/miaofalianhua/ResxMcp/releases/download/$Version/$zip"
  $zipPath = Join-Path $binDir $zip
  Invoke-WebRequest -Uri $url -OutFile $zipPath
  Expand-Archive -Path $zipPath -DestinationPath $binDir -Force
}

& $exePath

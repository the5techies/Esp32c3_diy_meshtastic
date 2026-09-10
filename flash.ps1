param(
    [Parameter(Mandatory = $true)]
    [string]$Port
)

$ErrorActionPreference = "Stop"
$image = Join-Path $PSScriptRoot "firmware\firmware.factory.bin"

if (-not (Test-Path -LiteralPath $image)) {
    throw "Firmware image not found: $image"
}

python -m esptool --chip esp32c3 --port $Port --baud 921600 write-flash 0x0 $image
if ($LASTEXITCODE -ne 0) {
    throw "Flashing failed with exit code $LASTEXITCODE"
}

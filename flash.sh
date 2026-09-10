#!/usr/bin/env sh
set -eu

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 /dev/ttyACM0" >&2
    exit 2
fi

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
python3 -m esptool --chip esp32c3 --port "$1" --baud 921600 write-flash 0x0 "$script_dir/firmware/firmware.factory.bin"

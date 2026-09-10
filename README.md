# ESP32-C3 DIY Meshtastic firmware

Ready-to-flash custom Meshtastic firmware for an ESP32-C3 Super Mini connected to a Waveshare Core1262-HF/SX1262 radio.

The included image was built from Meshtastic firmware `2.8.1.a495ef0` and verified on the target hardware. The SX1262 initialized successfully, DIO2 RF switching and the 1.8 V DIO3 TCXO were detected, transmit power was limited to 22 dBm, and BLE advertising and pairing succeeded.

## Hardware wiring

| SX1262 signal | ESP32-C3 GPIO |
| --- | ---: |
| SCK | 4 |
| MISO | 5 |
| MOSI | 6 |
| CS/NSS | 7 |
| DIO1 | 10 |
| BUSY | 20 |
| RESET | 21 |

The Core1262-HF uses DIO2 for its RF switch and DIO3 for its 1.8 V TCXO. GPIO 0 and 1 remain available for ADC, while GPIO 8 and 9 are assigned to I2C. No display, GPS, button, keyboard, or sensors are enabled.

## Flashing

Install Python 3 and esptool:

```console
python -m pip install esptool
```

On Windows, connect the board and run:

```powershell
.\flash.ps1 -Port COM9
```

On Linux or macOS:

```sh
./flash.sh /dev/ttyACM0
```

The scripts write `firmware/firmware.factory.bin` at address `0x0`. This includes the bootloader, partition table, boot application, and firmware. The separate `firmware.bin` is provided for application-only updates at `0x10000`.

After flashing, connect through the Meshtastic app over BLE and select the regulatory region appropriate for your location before transmitting.

## Board definition

The exact PlatformIO variant is under `variant/`. To rebuild it, copy that directory into a Meshtastic firmware checkout at:

```text
variants/esp32c3/diy/diy-c3-waveshare-sx1262/
```

Then build with:

```console
pio run -e diy-c3-waveshare-sx1262
```

Meshtastic firmware is licensed under GPL-3.0. See `LICENSE`.

# VENTUNO-Q JHAT Device Tree Overlays

Device Tree overlays for hardware connected to the 40-pin JHAT
connector on the Arduino VENTUNO-Q / Monza platform.

## Supported HATs

### Waveshare High-Precision AD HAT

Device Tree overlay:

    monaco-arduino-monza-precision-hat.dtso

The overlay configures the SPI interface required by the
Waveshare High-Precision AD HAT.

### Pimoroni Automation HAT

Device Tree overlay:

    monaco-arduino-monza-automation-hat.dtso

The overlay configures the interfaces required by the
Pimoroni Automation HAT, including the ADS1015 ADC and
SN3218 LED controller.

## Building

A Linux kernel source tree is required because the Device Tree
sources use dt-bindings headers from the kernel.

Build all overlays:

    make KDIR=/path/to/linux

For example:

    make KDIR=/local/mnt/workspace/upstream_kernel/linux

Build only the Precision HAT overlay:

    make KDIR=/path/to/linux precision-hat

Build only the Automation HAT overlay:

    make KDIR=/path/to/linux automation-hat

The resulting Device Tree overlay binaries are:

    monaco-arduino-monza-precision-hat.dtbo
    monaco-arduino-monza-automation-hat.dtbo

Clean generated files:

    make clean

## Kernel integration

The corresponding Linux kernel Device Tree Makefile entries are
provided in:

    Makefile.kernel

These entries are intended for integration with:

    arch/arm64/boot/dts/qcom/Makefile

## License

The Device Tree overlay source files contain their applicable
SPDX license identifiers. See the individual source files for
license information.

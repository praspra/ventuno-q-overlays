# Standalone build for monaco-arduino-monza overlays.
#
# The .dtso sources use <dt-bindings/*> and <dt-bindings/sound/qcom,*>
# headers from a Linux kernel tree, so point KDIR at one before building:
#
#   make KDIR=/path/to/linux                   # build all overlays
#   make KDIR=/path/to/linux precision-hat    # build one
#   make clean

DTC       ?= dtc
CPP       ?= cpp
KDIR      ?=

CPPFLAGS  := -nostdinc -undef -x assembler-with-cpp
CPPFLAGS  += -I$(KDIR)/include
CPPFLAGS  += -I$(KDIR)/arch/arm64/boot/dts
CPPFLAGS  += -I$(KDIR)/arch/arm64/boot/dts/qcom

DTCFLAGS  := -@ -q -O dtb -b 0

DTSO_SRC  := $(wildcard monaco-arduino-monza-*.dtso)
DTBO_OUT  := $(DTSO_SRC:.dtso=.dtbo)

.PHONY: all clean check

all: $(DTBO_OUT)

check:
	@if [ -z "$(KDIR)" ]; then \
		echo "error: set KDIR=/path/to/linux (need dt-bindings headers)"; \
		exit 1; \
	fi

%.dtbo: %.dtso | check
	$(CPP) $(CPPFLAGS) -o $*.pp.dtso $<
	$(DTC) $(DTCFLAGS) -i . -o $@ $*.pp.dtso
	@rm -f $*.pp.dtso

# Friendly short names:
# `make precision-hat` -> monaco-arduino-monza-precision-hat.dtbo
$(patsubst monaco-arduino-monza-%.dtso,%,$(DTSO_SRC)):
	$(MAKE) monaco-arduino-monza-$@.dtbo

clean:
	rm -f *.dtbo *.pp.dtso

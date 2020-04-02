#!/usr/bin/make

ISE=/opt/Xilinx/ise
VIVADO=/opt/Xilinx/vivado
TASK=imp

vpath %.zip downloads

all: iverilog

#
# Prepare
#

examples:
	git clone git@github.com:laforest/FPGADesignElements.git examples
	sed -i -E "s/parameter\s+WORD_WIDTH\s*=\s*0/parameter WORD_WIDTH = 8/g" examples/*.v
	sed -i -E "s/parameter\s+WORD_COUNT\s*=\s*0/parameter WORD_COUNT = 2/g" examples/*.v
	sed -i -E "s/parameter\s+PULSE_LENGTH\s*=\s*0/parameter PULSE_LENGTH = 2/g" examples/*.v
	sed -i -E "s/parameter\s+WORD_WIDTH_A\s*=\s*0/parameter WORD_WIDTH_A = 8/g" examples/*.v
	sed -i -E "s/parameter\s+WORD_WIDTH_B\s*=\s*0/parameter WORD_WIDTH_B = 8/g" examples/*.v
	sed -i -E "s/parameter\s+ADDR_WIDTH\s*=\s*0/parameter ADDR_WIDTH = 3/g" examples/*.v
	sed -i -E "s/parameter\s+INPUT_ADDR_BASE\s*=\s*0/parameter INPUT_ADDR_BASE = 3/g" examples/*.v
	sed -i -E "s/parameter\s+OUTPUT_ADDR_WIDTH\s*=\s*0/parameter OUTPUT_ADDR_WIDTH = 3/g" examples/*.v
	sed -i -E "s/parameter\s+INPUT_COUNT\s*=\s*0/parameter INPUT_COUNT = 3/g" examples/*.v

#
# Collecting Verilog files
#

VERILOGS  = $(shell find examples/ -type f -name '*.v')

# Filtering Files
## Not synthesizable
VERILOGS_TO_FILTER  = examples/Simulation_Clock.v

VERILOGS := $(filter-out $(VERILOGS_TO_FILTER), $(VERILOGS))

NO_OF_VERILOGS = $(words $(VERILOGS))

#
# iVerilog analysis
#

iverilog:
	@echo "Analysing $(NO_OF_VERILOGS) files with iVerilog"
	@$(foreach FILE, $(VERILOGS), \
		echo "* $(FILE)"; \
		iverilog -Iexamples -yexamples $(FILE); \
	)
	@echo "DONE"

verilator:
	@echo "Analysing $(NO_OF_VERILOGS) files with iVerilog"
	@$(foreach FILE, $(VERILOGS), \
		echo "* $(FILE)"; \
		verilator --lint-only -Iexamples $(FILE); \
	)
	@echo "DONE"

#
# Clean
#

clean:
	rm -fr a.out temp

clean-all: clean
	rm -fr examples reports

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

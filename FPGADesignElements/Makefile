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
	wget -P downloads -c https://github.com/laforest/FPGADesignElements/archive/master.zip
	mkdir -p examples
	unzip -o -d examples downloads/master.zip
	mv examples/*/* examples

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
	rm -fr downloads examples reports

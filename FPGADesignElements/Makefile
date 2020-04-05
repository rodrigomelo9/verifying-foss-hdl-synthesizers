#!/usr/bin/make

ISE=/opt/Xilinx/ise
VIVADO=/opt/Xilinx/vivado
TASK=imp

all: prepare

#
# Prepare
#

prepare:
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
	sed -i -E "s/parameter\s+BINARY_WIDTH\s*=\s*0/parameter BINARY_WIDTH = 8/g" examples/*.v
	sed -i -E "s/parameter\s+OUTPUT_WIDTH\s*=\s*0/parameter OUTPUT_WIDTH = 8/g" examples/*.v
	sed -i -E "s/parameter\s+OUTPUT_COUNT\s*=\s*0/parameter OUTPUT_COUNT = 8/g" examples/*.v
	sed -i -E "s/parameter\s+PIPE_DEPTH\s*=\s*0/parameter PIPE_DEPTH = 2/g" examples/*.v
	sed -i -E "s/parameter\s+WORD_WIDTH_IN\s*=\s*0/parameter WORD_WIDTH_IN = 8/g" examples/*.v
	sed -i -E "s/parameter\s+WORD_WIDTH_OUT\s*=\s*0/parameter WORD_WIDTH_OUT = 8/g" examples/*.v
	sed -i -E "s/parameter\s+IMPLEMENTATION\s*=\s*\"\"/parameter IMPLEMENTATION = \"MUX\"/g" examples/*.v
	sed -i -E "s/parameter\s+EDGE_TYPE\s*=\s*\"\"/parameter EDGE_TYPE = \"POS\"/g" examples/*.v

#
# Collecting Verilog files
#

VERILOGS  = $(shell find examples/ -type f -name '*.v' | sort)

# Filtering Files
## Not synthesizable
VERILOGS_TO_FILTER  = examples/Simulation_Clock.v

VERILOGS := $(filter-out $(VERILOGS_TO_FILTER), $(VERILOGS))

NO_OF_VERILOGS = $(words $(VERILOGS))

#
# Verify
#

verify: iverilog verilator

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
# Synthesis with Yosys
#

yosys-vivado:
	mkdir -p reports/$@
	@echo "Analysing $(NO_OF_VERILOGS) files with $@"
	@$(foreach FILE, $(VERILOGS), \
		echo "* Analizyng $(FILE)"; \
		fpga-hdl2bit --outdir temp/yosys --tool $@ --run $(TASK) $(FILE) > \
		$(addprefix reports/$@/, $(addsuffix .txt, $(notdir $(basename $(FILE))))); \
	)
	@echo "DONE"

#
# Synthesis with vendor tools
#

ise vivado quartus:
	mkdir -p reports/$@
	@echo "Analysing $(NO_OF_VERILOGS) files with $@"
	@$(foreach FILE, $(VERILOGS), \
		echo "* Analizyng $(FILE)"; \
		fpga-hdl2bit --outdir temp/$@ --tool $@ --run $(TASK) $(FILE) > \
		$(addprefix reports/$@/, $(addsuffix .txt, $(notdir $(basename $(FILE))))); \
	)
	@echo "DONE"

#
# Report
#

report-errors:
	@$(foreach DIR,$(wildcard reports/*), \
		echo "*\n* $(DIR)\n*"; \
		grep -rnE "ERROR|error:" $(DIR); \
		grep -rin "Aborted"      $(DIR); \
	)

#
# Clean
#

clean:
	rm -fr a.out temp

clean-all: clean
	rm -fr examples reports
